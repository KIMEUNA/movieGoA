package com.moviego.movie.schedule;

import java.util.List;

public class Schedule {
	private int scheduleIdx;	
	private String startTime;
	private String endTime;

	// 지점 정보
	private int cinemaIdx;
	private String cinemaName;
	
	// 상영관 정보
	private int multiplexIdx;
	private String multiplexName;
	private int multiplexGrade;
	private int multiplexSeat;
	
	// 영화 정보
	private int movieIdx;
	private String movieName;
	private String genreName;
	private String gradeName;
	private String director;
	private String runTime;
	private String effect;
	private String regdate_movie;
	
	// 가격
	private List<Integer> prices;
	private List<String> kinds;
	private int price;
	private String kind;	
	
	public List<Integer> getPrices() {
		return prices;
	}
	public void setPrices(List<Integer> prices) {
		this.prices = prices;
	}
	public List<String> getKinds() {
		return kinds;
	}
	public void setKinds(List<String> kinds) {
		this.kinds = kinds;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getCinemaIdx() {
		return cinemaIdx;
	}
	public void setCinemaIdx(int cinemaIdx) {
		this.cinemaIdx = cinemaIdx;
	}
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	public int getMultiplexIdx() {
		return multiplexIdx;
	}
	public void setMultiplexIdx(int multiplexIdx) {
		this.multiplexIdx = multiplexIdx;
	}
	public String getMultiplexName() {
		return multiplexName;
	}
	public void setMultiplexName(String multiplexName) {
		this.multiplexName = multiplexName;
	}
	public int getMultiplexGrade() {
		return multiplexGrade;
	}
	public void setMultiplexGrade(int multiplexGrade) {
		this.multiplexGrade = multiplexGrade;
	}
	public int getMultiplexSeat() {
		return multiplexSeat;
	}
	public void setMultiplexSeat(int multiplexSeat) {
		this.multiplexSeat = multiplexSeat;
	}
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getRunTime() {
		return runTime;
	}
	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}
	public String getEffect() {
		return effect;
	}
	public void setEffect(String effect) {
		this.effect = effect;
	}
	public String getRegdate_movie() {
		return regdate_movie;
	}
	public void setRegdate_movie(String regdate_movie) {
		this.regdate_movie = regdate_movie;
	}
	@Override
	public String toString() {
		return "Schedule [scheduleIdx=" + scheduleIdx + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", cinemaIdx=" + cinemaIdx + ", cinemaName=" + cinemaName + ", multiplexIdx=" + multiplexIdx
				+ ", multiplexName=" + multiplexName + ", multiplexGrade=" + multiplexGrade + ", multiplexSeat="
				+ multiplexSeat + ", movieIdx=" + movieIdx + ", movieName=" + movieName + ", genreName=" + genreName
				+ ", gradeName=" + gradeName + ", director=" + director + ", runTime=" + runTime + ", effect=" + effect
				+ ", regdate_movie=" + regdate_movie + ", prices=" + prices + ", kinds=" + kinds + ", price=" + price
				+ ", kind=" + kind + "]";
	}
	
}
