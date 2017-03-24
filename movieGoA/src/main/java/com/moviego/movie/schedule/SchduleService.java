package com.moviego.movie.schedule;

import java.util.List;
import java.util.Map;

public interface SchduleService {
	public void insertSchedule (Schedule dto) throws Exception;
	public List<Schedule> getScheduleList (Map<String, Object> map);
	public List<Schedule> getScheduleList_m (Map<String, Object> map);
	public List<Schedule> getShowMovieList(Map<String, Object> map);
	public List<Schedule> getMultiplexList(int cinemaIdx);
	public Schedule getMultiplex(int multiplexIdx);
	public Schedule getMovieInfo(int movieIdx);
	public void deleteSchedule (int scheduleIdx) throws Exception;
	public void updateSchedule (Schedule dto) throws Exception;}
