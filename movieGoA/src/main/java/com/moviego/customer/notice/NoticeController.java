package com.moviego.customer.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.moviego.common.FileManager;
import com.moviego.common.MyUtil;
import com.moviego.employee.SessionInfo;



@Controller("customer.notice.noticeController")
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	@Autowired
	private MyUtil myutil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/customer/noticeCreated", method=RequestMethod.GET)
	public String noticeCreatedForm(Model model, HttpSession session) throws Exception{  //공지 글쓰기폼
			
			model.addAttribute("treeview-menu", "1"); //뷰에 전달
		
			model.addAttribute("mode", "created"); 
		return ".admin4.customer.noticeCreated";   // customer/noticeCreated.jsp 로 결과값 리턴	
	}
	
	@RequestMapping(value="/customer/noticeCreated", method=RequestMethod.POST)  //view createdForm에서 post 형식으로 보냈기때문에 noticeCreatedSubmit 메소드로 들어온다.
	public String noticeCreatedSubmit(Notice dto, HttpSession session) throws Exception{ //공지 글 서버로 보내기
		
		SessionInfo info = (SessionInfo)session.getAttribute("employee"); //세션에 글입력한 회원정보(employee)를 가져옴
		
		//String root = session.getServletContext().getRealPath("/"); //세션의 웹서버의  root패스를 가져온다.
		//String pathname = root + File.separator + "uploads" + File.separator + "notice"; //root + 업로드의 경로
		
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";  // 하나의 프로젝트 작업을 할때는 위에 2줄을 써주면 되지만 관리자와 클라이언트 둘다 해야하기 때문에 파일 저장경로를 c 드라이브경로로 바꾼거다.
		
		dto.setEmployeeIdx(info.getEmployeeIdx()); // 이거 없으면 무결성제약조건에러발생 부모키 없다.
		                                                               // DTO 의 회원ID를 저장한다.
		

		service.insertNotice(dto, pathname);  //디비에 입력한다.
		
		return "redirect:/customer/noticeList"; //리스트로 리다이렉션 시킨다.
	}
	
	@RequestMapping(value="/customer/noticeList")
	public String list(
			@RequestParam(value="page", defaultValue="1")int current_page,   // 첫페이지에 인자값이 null 값을 가지면 안되니까 1을 지정해준것.
			@RequestParam(value="searchKey", defaultValue="subject")String searchKey, 
			@RequestParam(value="searchValue", defaultValue="")String searchValue, 
				Model model, 
				HttpServletRequest req
			) throws Exception{
	
		String cp = req.getContextPath();
		
		int numPerPage=10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		//전체 페이지 수 
		Map<String, Object> map =  new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		//데이터 개수
		dataCount = service.dataCount(map);
		if(dataCount!=0){
			total_page= myutil.pageCount(numPerPage, dataCount);
		}
		
		//다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(total_page<current_page){
			total_page=current_page;
		}
		
		// 1페이지인 경우 공지리스트 가져오기
		List<Notice> noticeList = null;  //Notice 객체만 저장(다른건 불가)
		if(current_page==1){
			noticeList=service.noticeListTop();
		}
		
		//리스트에 출력할 데이터를 가져오기 
		int start = (current_page-1) * numPerPage +1; 
		int end = current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		//글리스트
		List<Notice> list = service.noticeList(map);
		
		// 리스트의 번호
		Date endDate = new Date();
		long gap;   // 한시간 전에 등록한 것을 글 리스트에서 new이미지 보이게 하기 위함
		int listNum, n = 0;
		Iterator<Notice> it =list.iterator();
		while(it.hasNext()){
			Notice data =it.next();
			listNum = dataCount - (start +n -1); 
			data.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getRegDate());
			
			gap=(endDate.getTime()- beginDate.getTime())/(60*60*1000);
			data.setGap(gap);
			
			data.setRegDate(data.getRegDate().substring(0, 10));
			n++;
		}
		
		String params="";
		String urlList=cp+"/customer/noticeList";  //리스트 주소
		String urlArticle = cp + "/customer/noticeArticle?page=" + current_page;  //글보기 주소
		if(searchValue.length()!=0){
			params="searchKey="+ searchKey +
					"&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if(params.length() !=0){
			urlList = cp+"/customer/noticeList?"+params;
			urlArticle = cp+"/customer/noticeArticle?page="+ current_page+ "&" + params;
		}
		
		String paging=myutil.paging(current_page, total_page, urlList);
		
		model.addAttribute("treeview-menu", "1");   // 뷰에게 전달할 model 데이터 추가
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("urlArticle", urlArticle); //글보기주소
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		return ".admin4.customer.noticeList";
	}
	
	@RequestMapping(value="/customer/noticeArticle", method=RequestMethod.GET)
	public String article(
		@RequestParam(value="noticeIdx") int noticeIdx,
		@RequestParam(value="page") String page,
		@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
		@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model
			) throws Exception{
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		service.updateHitCount(noticeIdx);
		
		Notice dto=service.readNotice(noticeIdx);
	    if(dto==null)																			    	//dto 가 null이면
	    	new ModelAndView("redirect:/customer/noticeList?page="+page);  // 이페이지로 리다이렉트하라

	    dto.setContent(dto.getContent().replaceAll("\n", "<br>")); 
	    
	    
	    // 이전 글, 다음 글
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("searchKey", searchKey);
	    map.put("searchValue", searchValue);
	    map.put("noticeIdx", noticeIdx);
	    
	    Notice preReadDto = service.preReadNotice(map);  // 이전 글보기
	    Notice nextReadDto = service.nextReadNotice(map); // 다음 글보기
	    
	    //파일
	    List<Notice> listFile=service.listFile(noticeIdx);       //위 article의 인자값 noticeIdx를  listFile로 받아와서,
	    
	    
	    String params = "page="+page;
	    if(searchValue.length()!=0){
	    	params += "&searchKey=" + searchKey + 
	    			"&searchValue="+ URLEncoder.encode(searchValue, "utf-8");
	    }
	    model.addAttribute("treeview-menu", "1");
	    
	    model.addAttribute("dto", dto);
	    model.addAttribute("preReadDto", preReadDto);
	    model.addAttribute("nextReadDto",nextReadDto);
	    
	    model.addAttribute("listFile", listFile);    //받아온 값을 넘겨주는것. jsp파일에 el 태그   ${listFile}이 있을거다.
	    
	    model.addAttribute("page", page);
	    model.addAttribute("params", params);
	    
	    
		return ".admin4.customer.noticeArticle";
	}
	
	@RequestMapping(value="/customer/updateNotice", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam(value="noticeIdx") int noticeIdx, 
			@RequestParam(value="page") String page, 
			Model model, 
			HttpSession session) throws Exception{
		
		Notice dto = (Notice)service.readNotice(noticeIdx);
		if(dto==null){
			return "redirect:/customer/noticeList?page="+ page;
		}
		
		//파일
		List<Notice> listFile=service.listFile(noticeIdx);
		
		model.addAttribute("treeview-menu", "1");
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".admin4.customer.noticeCreated";
	}
	
	@RequestMapping(value="/customer/updateNotice", method=RequestMethod.POST)
	public String updateSubmit(
			Notice dto,
			@RequestParam String page,
			HttpSession session) throws Exception{
		
		
		SessionInfo info = (SessionInfo)session.getAttribute("employee"); //세션에 글입력한 회원정보(employee)를 가져옴
		
		//String root = session.getServletContext().getRealPath("/"); //세션의 웹서버의  root패스를 가져온다.
		//String pathname = root + File.separator + "uploads" + File.separator + "notice"; //root + 업로드의 경로
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";
		
		dto.setEmployeeIdx(info.getEmployeeIdx()); // 이거 없으면 무결성제약조건에러발생 부모키 없다.
		
		service.updateNotice(dto, pathname);
		
		return "redirect:/customer/noticeList?page="+ page;
	}
	
	@RequestMapping(value="/customer/deleteNotice",  method=RequestMethod.GET)
	public String delete( // 글삭제
			@RequestParam int noticeIdx,
			@RequestParam String page,
			HttpSession session
			) throws Exception{
		
		//String root = session.getServletContext().getRealPath("/");
		//String pathname = root + File.separator + "uploads" + File.separator + "notice";
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";
		
		//내용 지우기
		service.deleteNotice(noticeIdx, pathname);
		
		return "redirect:/customer/noticeList?page=" + page;
		
	}
	
	@RequestMapping(value="customer/download")
	public void download(  // 파일다운로드
			@RequestParam int fileIdx,
			HttpServletResponse resp,
			HttpSession session) throws Exception{
		
		//String root = session.getServletContext().getRealPath("/");
		//String pathname = root + File.separator + "uploads" + File.separator + "notice";
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";
		
		boolean b = false;
		
		Notice dto = service.readFile(fileIdx);
		if(dto !=null) {
			
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value="/customer/deleteFile", method=RequestMethod.POST)
	@ResponseBody      // 반드시 map 일때만 사용가능.  
	public Map<String, Object> deleteFile(
			@RequestParam int fileIdx,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		//String root = session.getServletContext().getRealPath("/");
		//String pathname = root + File.separator + "uploads" + File.separator + "notice";
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";
		
		Notice dto=service.readFile(fileIdx);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "fileIdx");
		map.put("noticeIdx", fileIdx);
		service.deleteFile(map);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;    // javaScript  function(data) 에 data 값이 model이다.
	}
		
	
	
}
