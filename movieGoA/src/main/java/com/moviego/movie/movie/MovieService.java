package com.moviego.movie.movie;

import java.util.List;
import java.util.Map;

import com.moviego.movie.schedule.Schedule;

public interface MovieService {	
	public void insertMovie(Movie dto, String pathname) throws Exception;
	public int getDataCount(Map<String, Object> map);
	public List<Movie> getMovieList(Map<String, Object> map);
	public List<Movie> getMovieList2(Map<String, Object> map);	
	public Movie getMovieInfo(int movieIdx);	
	public List<Movie> getMultiplexList(int cinemaIdx);
}
