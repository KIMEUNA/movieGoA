package com.moviego.customer.notice;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.moviego.common.FileManager;
import com.moviego.common.dao.CommonDAO;

@Service("customer.notice.noticeService")
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public int insertNotice(Notice dto, String pathname) {
		int result = 0;
		try {
			int maxNum= dao.getIntValue("customer.maxNum");   //dao 인터페이스에 재정의된 MybatisDaoImpl 데이터의 추가가 이뤄진다.
			dto.setNoticeIdx(maxNum+1);
			
			result=dao.insertData("customer.insertNotice", dto);
			
			if(! dto.getUpload().isEmpty()){
				for(MultipartFile mf : dto.getUpload()){
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename != null){
						String originalFilename=mf.getOriginalFilename();
						long fileSize = mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
						
					}
				}
			}
	
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result=dao.getIntValue("customer.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Notice> noticeList(Map<String, Object> map) { //공지사항 리스트
		List<Notice> list = null;
		
		try {
			list=dao.getListData("customer.noticeList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Notice> noticeListTop() {
		List<Notice> list = null;
		
		try {
			list=dao.getListData("customer.noticeListTop");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateHitCount(int noticeIdx) {
		int result=0;
		
		try {
			result=dao.updateData("customer.updateHitCount", noticeIdx);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Notice readNotice(int noticeIdx) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("customer.readNotice", noticeIdx);  // (String id, String value)

		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("customer.preReadNotice", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("customer.nextReadNotice", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public int updateNotice(Notice dto, String pathname) {
		int result=0;
		
		try {
			result=dao.updateData("customer.updateNotice", dto);
			if(!dto.getUpload().isEmpty()){
				for(MultipartFile mf : dto.getUpload()){
					if(mf.isEmpty())
						continue;
					
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null){
						String originalFilename=mf.getOriginalFilename();
						long fileSize = mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
			
			
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public int deleteNotice(int noticeIdx, String pathname) {
		int result=0;
	
		try {
			// 파일지우기
			List<Notice> listFile=listFile(noticeIdx);
			if(listFile !=null){
				Iterator<Notice> it=listFile.iterator();
				while(it.hasNext()){
					Notice dto = it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
				
			}
			
			//파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticeIdx");
			map.put("noticeIdx", noticeIdx);
			deleteFile(map);
			
			result=dao.deleteData("customer.deleteNotice", noticeIdx);
		} catch (Exception e) {
		}

		return result;
	}

	@Override
	public int insertFile(Notice dto) {  // 파일 삽입
		int result=0;
		try {
			result=dao.insertData("customer.insertFile", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}	
	
	@Override
	public List<Notice> listFile(int noticeIdx) {
		List<Notice> listFile=null;
		
		try {
			listFile=dao.getListData("customer.listFile", noticeIdx);  // 여기서 mapper로 들어가서 쿼리문을 실행한다..
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return listFile;
	}

	@Override
	public Notice readFile(int fileIdx) {
		Notice dto=null;
		
		try {
			dto=dao.getReadData("customer.readFile", fileIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.deleteData("customer.deleteFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

}
