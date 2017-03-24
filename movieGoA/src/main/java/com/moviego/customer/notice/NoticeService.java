package com.moviego.customer.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	public int insertNotice(Notice dto, String pathname);
	public int dataCount(Map<String, Object> map);
	
	public List<Notice> noticeList (Map<String, Object> map);
	public List<Notice> noticeListTop();
	
	public int updateHitCount(int noticeIdx);
	
	public Notice readNotice(int noticeIdx);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public int updateNotice(Notice dto, String pathname);
	public int deleteNotice(int noticeIdx, String pathname);
	
	public int insertFile(Notice dto);
	public List<Notice> listFile(int noticeIdx);
	public Notice readFile(int fileIdx);
	public int deleteFile(Map<String, Object> map);
}
