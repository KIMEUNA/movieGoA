package com.moviego.movie.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.moviego.common.dao.CommonDAO;

@Service("movie.schedule.scheduleService")
public class ScheduleServiceImpl implements SchduleService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception{
		try {
			dto.setScheduleIdx(dao.getIntValue("schedule.getMaxSeq"));
			dao.insertData("schedule.insertSchedule", dto);
			for (int i = 0; i < dto.getPrices().size(); i++) {
				dto.setPrice(dto.getPrices().get(i));
				dto.setKind(dto.getKinds().get(i));
				dao.insertData("schedule.insertPrice", dto);
			}
		} catch (Exception e) {throw e;}
	}
	
	// 상영 일정 리스트
	@Override
	public List<Schedule> getScheduleList(Map<String, Object> map) {
		
		List<Schedule> list = null;
		
		try {
			list = dao.getListData("schedule.getScheduleList", map);		
		} catch (Exception e) {
			System.out.println(e.toString());	
		}
		
		return list;
	}	
	
	@Override
	public List<Schedule> getScheduleList_m(Map<String, Object> map) {
		
		List<Schedule> list = null;
		
		try {
			list = dao.getListData("schedule.getScheduleList_m", map);
		} catch (Exception e) {
			System.out.println(e.toString());	
		}
		
		return list;
	}

	
	@Override
	public List<Schedule> getShowMovieList(Map<String, Object> map) {
		List<Schedule> list = null;
		
		try {
			list  = dao.getListData("schedule.getShowMovieList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	@Override
	public List<Schedule> getMultiplexList(int cinemaIdx) {
		List<Schedule> list = null;
		try {
			list = dao.getListData("schedule.getMultiplexList", cinemaIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	

	@Override
	public Schedule getMultiplex(int multiplexIdx) {
		Schedule dto = null;
		try {
			dto = dao.getReadData("schedule.getMultiplex", multiplexIdx);
		} catch (Exception e) {}
		return dto;
	}
	
	@Override
	public Schedule getMovieInfo(int movieIdx) {
		Schedule dto = null;
		try {
			dto = dao.getReadData("schedule.getMovieInfo", movieIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public void deleteSchedule(int scheduleIdx) throws Exception {
		try {
			dao.deleteData("schedule.deletePrice", scheduleIdx);
			dao.deleteData("schedule.deleteSchedule", scheduleIdx);
		} catch (Exception e) {throw e;}
		
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception {
		try {
			dao.updateData("schedule.updateSchedule", dto);
		} catch (Exception e) {throw e;}
	}

}
