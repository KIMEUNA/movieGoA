package com.moviego.movie.movie;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.FileManager;
import com.moviego.common.dao.CommonDAO;

@Service("movie.movie.movieService")
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertMovie(Movie dto, String pathname) throws Exception {
		
		try {
			
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				String poster = fileManager.doFileUpload(dto.getUpload(), pathname);
				int index = poster.lastIndexOf(".");
				poster = poster.substring(0, index);
				
				dto.setPoster(poster);
			}
			
			dao.insertData("movie.insertMovie", dto);
			dao.insertData("movie.insertEffect", dto);
			dao.insertData("movie.insertIntro", dto);
			
		} catch (Exception e) {throw e;}
	}
	
	@Override
	public int getDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("movie.getDataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Movie> getMovieList(Map<String, Object> map) {
		List<Movie> list = null;
		try {
			list = dao.getListData("movie.getMovieList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Movie getMovieInfo(int movieIdx) {
		Movie dto = null;
		
		try {
			dto = dao.getReadData("movie.getMovieInfo", movieIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public List<Movie> getMovieList2(Map<String, Object> map) {
		List<Movie> list = null;
		
		try {
			list = dao.getListData("movie.getMovieList2", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public List<Movie> getMultiplexList(int cinemaIdx) {
		List<Movie> list = null;
		
		try {
			list = dao.getListData("movie.getMultiplexList", cinemaIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
}
