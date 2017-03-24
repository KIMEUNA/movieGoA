package com.moviego.movie.schedule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviego.employee.SessionInfo;

@Controller("movie.schedule.scheduleController")
public class ScheduleController {
	
	@Autowired
	private SchduleService service;
	
	// 영화 정보 모달
	@RequestMapping(value = "/schedule/modalInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getRegMovieInfo(
			@RequestParam int movieIdx,
			@RequestParam int cinemaIdx
			) throws Exception {
		
		Schedule movie = service.getMovieInfo(movieIdx);
		List<Schedule> list_m = service.getMultiplexList(cinemaIdx);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list_m", list_m);
		map.put("movie", movie);		
		
		return map;
	}

	@RequestMapping(value="/schedule/addSchedule", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSchedule(
			Schedule dto,
			@RequestParam int price_adult,
			@RequestParam(defaultValue="0") int price_youth
			) throws Exception {		
		
		dto.setMovieIdx(dto.getMovieIdx());
		dto.setMultiplexIdx(dto.getMultiplexIdx());
		dto.setStartTime(dto.getStartTime());
		dto.setEndTime(dto.getEndTime());
		
		System.out.println(dto.toString());
		
		List<Integer> prices = new ArrayList<>();
		List<String> kinds = new ArrayList<>();
		prices.add(price_adult);
		kinds.add("일반");
		
		if(price_youth != 0) {
			prices.add(price_youth);			
			kinds.add("청소년");
		}
		
		dto.setPrices(prices);
		dto.setKinds(kinds);
			
		service.insertSchedule(dto);
		
		return new HashMap<>();
	}
	
	@RequestMapping(value="/schedule/list")
	public String scheduleList(
			@RequestParam int cinemaIdx,
			@RequestParam String date,
			Model model
			) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("cinemaIdx", cinemaIdx);
		map.put("date", date);
		
		List<Schedule> list_show = service.getShowMovieList(map);
		List<Schedule> list = service.getScheduleList(map);
		List<Schedule> list_multiplex = service.getMultiplexList(cinemaIdx);
		
		String cinemaName = list_multiplex.get(0).getCinemaName();
		
		model.addAttribute("list", list);
		model.addAttribute("list_show", list_show);
		model.addAttribute("list_multiplex", list_multiplex);
		model.addAttribute("cinemaName", cinemaName);
		model.addAttribute("cinemaIdx", cinemaIdx);
		model.addAttribute("date", date);
		
		return ".admin4.movie.schedule.list";
	}
	
/*	@RequestMapping(value="/schedule/list_m")
	public String scheduleManagement(
					@RequestParam int multiplexIdx,
					Model model,
					HttpSession session
			) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("employee");
		
		if(!info.getEmployeeGrade().equals("manager")) 
			return ".admin4.movie.schedule.list";
		
		System.out.println("multiplexIdx : "+multiplexIdx);
		
		Map<String, Object> map = new HashMap<>();
		map.put("multiplexIdx", multiplexIdx);
		
		List<Schedule> list= service.getShowMovieList(map);
		
		Schedule dto = service.getMultiplex(multiplexIdx);
		
		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		
		return "movie/schedule/management";
	}*/
	
	@RequestMapping(value="/schedule/list_m")
	public String scheduleList_m(
					@RequestParam int multiplexIdx,
					@RequestParam String date,
					Model model
			) {
						
		Map<String, Object> map = new HashMap<>();		
		map.put("multiplexIdx", multiplexIdx);
		map.put("date", date);
		
		List<Schedule> list = service.getScheduleList_m(map);
		
		String multiplexName ="";
		String cinemaName ="";
		int cinemaIdx = 0;
		
		if(list.size() >= 1) {
			multiplexName = list.get(0).getMultiplexName();
			cinemaName = list.get(0).getCinemaName();
			cinemaIdx = list.get(0).getCinemaIdx();
		}
		else {
			Schedule multiplex = service.getMultiplex(multiplexIdx);
			multiplexName = multiplex.getMultiplexName();
			cinemaName = multiplex.getCinemaName();
			cinemaIdx = multiplex.getCinemaIdx();
		}		
		
		map.put("cinemaIdx", cinemaIdx);
		
		List<Schedule> list_show = service.getShowMovieList(map);
		
		model.addAttribute("list_show", list_show);
		model.addAttribute("list", list);
		model.addAttribute("cinemaIdx", cinemaIdx);
		model.addAttribute("cinemaName", cinemaName);
		model.addAttribute("multiplexName", multiplexName);
		model.addAttribute("multiplexIdx", multiplexIdx);
		model.addAttribute("date", date);
		
		return "movie/schedule/list_m";
	}	
	
	@RequestMapping(value="/schedule/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSchedule(
			Schedule dto
			) throws Exception {
		System.out.println("드러옴ㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱㄱ");
		
		dto.setScheduleIdx(dto.getScheduleIdx());
		dto.setMovieIdx(dto.getMovieIdx());
		dto.setStartTime(dto.getStartTime());
		dto.setEndTime(dto.getEndTime());
		
		System.out.println(dto.toString());
		
		service.updateSchedule(dto);
				
		return new HashMap<>();
	}		
	
	@RequestMapping(value="/schedule/delete_s", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteSchedule(
			@RequestParam int scheduleIdx
			) throws Exception {
		
		service.deleteSchedule(scheduleIdx);
		
		return new HashMap<>();
	}
	
		
}
