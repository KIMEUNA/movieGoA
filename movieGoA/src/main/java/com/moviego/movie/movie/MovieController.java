package com.moviego.movie.movie;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviego.common.MyUtil;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;

@Controller("movie.movieController")
public class MovieController {

	@Autowired
	private MovieService service;
	
	@Autowired
	private MyUtil myUtil;

	// 발급키
	String key = "4b9505dc476db22cbac34d139f1e1f0f";
	// KOBIS 오픈 API Rest Client를 통해 호출
	KobisOpenAPIRestService KOARservice = new KobisOpenAPIRestService(key);

	// 전체 영화 리스트
	@RequestMapping(value = "/movie/apiList", method = RequestMethod.GET)
	public String apiList(Movie dto, Model model) throws Exception {

		String[] movieType = null;

		if (dto.getMovieTypeCdArr() != null) {
			movieType = new String[dto.getMovieTypeCdArr().size()];
			for (int i = 0; i < movieType.length; i++) {
				movieType[i] = dto.getMovieTypeCdArr().get(i);
			}
		}

		// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String
		// itemPerPage,String directorNm,
		// String movieCd, String movieNm, String openStartDt,String openEndDt,
		// String ordering,
		// String prdtEndYear, String prdtStartYear, String repNationCd,
		// String[] movieTypeCdArr)
		String movieCdResponse = KOARservice.getMovieList(true, dto.getCurPage(), dto.getItemPerPage(),
				dto.getMovieName(), dto.getDirector(), dto.getOpenStartDt(), dto.getOpenEndDt(), dto.getPrdtStartYear(),
				dto.getPrdtEndYear(), dto.getRepNationCd(), movieType);

		String nationCdResponse = KOARservice.getComCodeList(true, "2204");
		String movieTypeCdResponse = KOARservice.getComCodeList(true, "2201");

		// Json 라이브러리를 통해 Handling
		ObjectMapper mapper = new ObjectMapper();

		HashMap<String, Object> result = mapper.readValue(movieCdResponse, HashMap.class);
		HashMap<String, Object> nationCd = mapper.readValue(nationCdResponse, HashMap.class);
		HashMap<String, Object> movieTypeCd = mapper.readValue(movieTypeCdResponse, HashMap.class);

		model.addAttribute("dto", dto);
		model.addAttribute("result", result);
		model.addAttribute("nationCd", nationCd);
		model.addAttribute("movieTypeCd", movieTypeCd);
		// model.addAttribute("treeview", "1");
		// model.addAttribute("subMenu", "0");

		return ".admin4.movie.movie.movieList";
	}

	// 영화 정보 모달
	@RequestMapping(value = "/movie/movieInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMovieInfo(@RequestParam String movieIdx) throws Exception {

		String movieInfo = KOARservice.getMovieInfo(true, movieIdx);

		System.out.println(movieInfo);
		Movie dto = new Movie();

		String[] replace = { "[", "{", "\"", ":", "}", "]" };

		for (String ss : replace) {
			movieInfo = movieInfo.replace(ss, "");
		}

		dto.setMovieIdx(movieIdx);
		dto.setMovieName(movieInfo.substring(movieInfo.indexOf("movieNm") + "movieNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("movieNm") + "movieNm".length())));
		dto.setRunTime(movieInfo.substring(movieInfo.indexOf("showTm") + "showTm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("showTm") + "showTm".length())));
		dto.setNation(movieInfo.substring(movieInfo.indexOf("nationNm") + "nationNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("nationNm") + "nationNm".length())));
		dto.setDirector(movieInfo.substring(movieInfo.indexOf("peopleNm") + "peopleNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("peopleNm") + "peopleNm".length())));
		dto.setActor(movieInfo.substring(movieInfo.indexOf("actorspeopleNm") + "actorspeopleNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("actorspeopleNm") + "actorspeopleNm".length())));
		dto.setRegdate(movieInfo.substring(movieInfo.indexOf("openDt") + "openDt".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("openDt") + "openDt".length())));
		String grade = movieInfo.substring(movieInfo.indexOf("watchGradeNm") + "watchGradeNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("watchGradeNm") + "watchGradeNm".length()));
	
		dto.setGradeName(grade);
		
		String[] genres = { "기타", "가족", "액션", "드라마", "공포/호러", "느와르", "미스터리", "아동", "재난", "청춘영화", "범죄", "단편", "다큐맨터리",
				"옴니버스", "어드벤처", "SF", "로드무비", "서부", "역사", "환타지", "멜로/로맨스", "무협", "스릴러", "전기", "학원물", "코미디", "뮤지컬",
				"스포츠", "전쟁", "애로", "애니메이션", "뮤직", "시대극/사극", "종교" };

		String genre = movieInfo.substring(movieInfo.indexOf("genreNm") + "genreNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("genreNm") + "genreNm".length()));

		dto.setGenreName(genre);
		
		String effect = movieInfo.substring(movieInfo.indexOf("showTypeGroupNm") + "showTypeGroupNm".length(),
				movieInfo.indexOf(",", movieInfo.indexOf("showTypeGroupNm") + "showTypeGroupNm".length()));

		System.out.println("효과:" +effect);
		
		if(!effect.equals("2D") || !effect.equals("3D") || !effect.equals("4D"))
			effect = "2D";
		
		dto.setEffect(effect);
		
		System.out.println(dto.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dto", dto);

		return map;
	}
	
	// 영화 추가 서브밋
	@RequestMapping(value = "/movie/addMovie", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addMovie(
			Movie dto,
			HttpSession session) throws Exception {		
		
		String root = session.getServletContext().getRealPath("/");
		System.out.println(root);
		String pathname = root + File.separator + "res" + File.separator + "poster";
		
		String gradeIdx = (dto.getGenreName().equals("청소년관람불가") ? "4"
				: dto.getGenreName().equals("15세이상관람가") ? "3" 
						: dto.getGenreName().equals("12세이상관람가") ? "2" : "1");
		dto.setGradeIdx(gradeIdx);
		//
		String[] genres = { "기타", "가족", "액션", "드라마", "공포/호러", "느와르", "미스터리", "아동", 
				"재난", "청춘영화", "범죄", "단편", "다큐맨터리", "옴니버스", "어드벤처", "SF", "로드무비", 
				"서부", "역사", "판타지", "멜로/로맨스", "무협", "스릴러", "전기", "학원물", "코미디", "뮤지컬",
				"스포츠", "전쟁", "애로", "애니메이션", "뮤직", "시대극/사극", "종교" };

		for (int i = 0; i < genres.length; i++) {
			if (dto.getGenreName().matches(genres[i]))
				dto.setGenreIdx(i + "");
		}
		
		if(dto.getGenreIdx() == null)
			dto.setGenreIdx(0 + "");

		service.insertMovie(dto, pathname);

		return new HashMap<>();
	}

	@RequestMapping(value = "/movie/regList")
	public String regMovieList(
					@RequestParam(defaultValue = "1") int page,
					@RequestParam(defaultValue = "movieName") String searchKey,
					@RequestParam(defaultValue = "") String searchValue, 
					@RequestParam (defaultValue = "0") int cinemaIdx,
					Model model,
					HttpServletRequest req
			) throws Exception {
		
		String cp = req.getContextPath();

		int numPerPage = 16; // 한 화면에 보여주는 영화 수
		int total_page  = 0 ;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {	 // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = service.getDataCount(map);
		if(dataCount != 0)
			total_page = myUtil.pageCount(numPerPage, dataCount);
		
		// 다른 사람이 자료를 삭제하여 전체 페이지 수가 변화된 경우
		if(total_page < page)
			page = total_page;
		
		// 등록된 영화 리스트
		List<Movie> list = null;
		
		//리스트에 출력할 데이터를 가져오기 
		int start = (page-1) * numPerPage +1; 
		int end = page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		if(cinemaIdx == 0) {						// 관리자 일 때
			list = service.getMovieList(map);	
		}else {												// 매니저 일 때
			map.put("cinemaIdx", cinemaIdx);
			list =service.getMovieList2(map);
			List<Movie> list_multiplex = service.getMultiplexList(cinemaIdx);
			model.addAttribute("list_multiplex", list_multiplex);
		}
		
		Iterator<Movie> it = list.iterator();
		while(it.hasNext()) {
			System.out.println(it.next());
		}
		
		String params = "";
		String urlList = cp + "/movie/regList";
		String urlArticle = cp + "/movie/readmovie?page=" + page;
		if(searchValue.length() != 0) {
			params = "searchKey=" + searchKey +
					"&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if(params.length() !=0){
			urlList = cp + "/movie/regList"+params;
			urlArticle = cp+"/movie/readmovie?page="+ page+ "&" + params;
		}
		
		String paging = myUtil.paging(page, total_page, urlList);
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("urlArticle", urlArticle); 
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return ".admin4.movie.movie.regList";
	}		
	
	@RequestMapping(value="/movie/readmovie", method=RequestMethod.GET)
	public String readMovie(
					@RequestParam int movieIdx,
					@RequestParam(value="page") String page,
					@RequestParam(value="searchKey", defaultValue="movieName") String searchKey,
					@RequestParam(value="searchValue", defaultValue="") String searchValue,
					Model model
			) throws Exception {
			
		Movie dto = service.getMovieInfo(movieIdx);

		if(dto==null)
			return "redirect:/movie/regList?page="+page;

		String params = "page="+page;
		if(searchValue.length() != 0) {
			params += "&searchKey="+searchKey + "&searchValue=" +URLEncoder.encode(searchValue,"utf-8");			
		}
		
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("params", params);
		System.out.println("클릭영화:"+ dto.toString());
		
		return ".admin4.movie.movie.movieInfo";
	}

}
