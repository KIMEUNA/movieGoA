package com.moviego.movie.movie;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Movie {
	
	// api 리스트에서 검색 조건
	private String curPage="1";			//현재페이지
	private String itemPerPage="16";	//결과row수
	private String openStartDt;				//개봉연도 시작조건 ( YYYY )
	private String openEndDt;				//개봉연도 끝조건 ( YYYY )
	private String prdtStartYear;			//제작연도 시작조건 ( YYYY )
	private String prdtEndYear;				//제작연도 끝조건    ( YYYY )
	private String repNationCd;			//대표국적코드 (공통코드서비스에서 '2204'로 조회된 국가코드)
	
	private List<String> movieTypeCdArr; //영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)
	
	private String movieIdx, genreIdx, gradeIdx, effectIdx;
	private String movieName, gradeName, genreName, effect;					//영화명
	private String runTime;
	private String nation;
	private String director, actor;	//감독명
	private String regdate;
	
	// 인트로
	private String story;
	private String poster;
	// 예고편
	private int previewIdx;
	private String previewName;
	// 스틸컷
	private int stillIdx;
	private String stillcutName;
	
	// 지점
	private int cinemaIdx, multiplexIdx;
	private String cinemaName, multiplexName;
	private String multiplexGrade;	// 2D 3D 4D
	
	// 스케쥴
	private int scheduleIdx;
	private String startTime;
	private int inning;	// startTime으로 계산해서 몇 회차 인지 .
	
	private MultipartFile upload;
	
	
	public String getCurPage() {
		return curPage;
	}
	public void setCurPage(String curPage) {
		this.curPage = curPage;
	}
	public String getItemPerPage() {
		return itemPerPage;
	}
	public void setItemPerPage(String itemPerPage) {
		this.itemPerPage = itemPerPage;
	}
	public String getOpenStartDt() {
		return openStartDt;
	}
	public void setOpenStartDt(String openStartDt) {
		this.openStartDt = openStartDt;
	}
	public String getOpenEndDt() {
		return openEndDt;
	}
	public void setOpenEndDt(String openEndDt) {
		this.openEndDt = openEndDt;
	}
	public String getPrdtStartYear() {
		return prdtStartYear;
	}
	public void setPrdtStartYear(String prdtStartYear) {
		this.prdtStartYear = prdtStartYear;
	}
	public String getPrdtEndYear() {
		return prdtEndYear;
	}
	public void setPrdtEndYear(String prdtEndYear) {
		this.prdtEndYear = prdtEndYear;
	}
	public String getRepNationCd() {
		return repNationCd;
	}
	public void setRepNationCd(String repNationCd) {
		this.repNationCd = repNationCd;
	}
	public List<String> getMovieTypeCdArr() {
		return movieTypeCdArr;
	}
	public void setMovieTypeCdArr(List<String> movieTypeCdArr) {
		this.movieTypeCdArr = movieTypeCdArr;
	}
	public String getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(String movieIdx) {
		this.movieIdx = movieIdx;
	}
	public String getGenreIdx() {
		return genreIdx;
	}
	public void setGenreIdx(String genreIdx) {
		this.genreIdx = genreIdx;
	}
	public String getGradeIdx() {
		return gradeIdx;
	}
	public void setGradeIdx(String gradeIdx) {
		this.gradeIdx = gradeIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	public String getRunTime() {
		return runTime;
	}
	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getEffectIdx() {
		return effectIdx;
	}
	public void setEffectIdx(String effectIdx) {
		this.effectIdx = effectIdx;
	}
	public String getEffect() {
		return effect;
	}
	public void setEffect(String effect) {
		this.effect = effect;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public int getPreviewIdx() {
		return previewIdx;
	}
	public void setPreviewIdx(int previewIdx) {
		this.previewIdx = previewIdx;
	}
	public String getPreviewName() {
		return previewName;
	}
	public void setPreviewName(String previewName) {
		this.previewName = previewName;
	}
	public int getStillIdx() {
		return stillIdx;
	}
	public void setStillIdx(int stillIdx) {
		this.stillIdx = stillIdx;
	}
	public String getStillcutName() {
		return stillcutName;
	}
	public void setStillcutName(String stillcutName) {
		this.stillcutName = stillcutName;
	}
	public int getCinemaIdx() {
		return cinemaIdx;
	}
	public void setCinemaIdx(int cinemaIdx) {
		this.cinemaIdx = cinemaIdx;
	}
	public int getMultiplexIdx() {
		return multiplexIdx;
	}
	public void setMultiplexIdx(int multiplexIdx) {
		this.multiplexIdx = multiplexIdx;
	}
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	public String getMultiplexName() {
		return multiplexName;
	}
	public void setMultiplexName(String multiplexName) {
		this.multiplexName = multiplexName;
	}
	public String getMultiplexGrade() {
		return multiplexGrade;
	}
	public void setMultiplexGrade(String multiplexGrade) {
		this.multiplexGrade = multiplexGrade;
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
	public int getInning() {
		return inning;
	}
	public void setInning(int inning) {
		this.inning = inning;
	}	
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
	@Override
	public String toString() {
		return "Movie [movieIdx=" + movieIdx + ", genreIdx=" + genreIdx + ", gradeIdx=" + gradeIdx + ", effectIdx="
				+ effectIdx + ", movieName=" + movieName + ", gradeName=" + gradeName + ", genreName=" + genreName
				+ ", effect=" + effect + ", runTime=" + runTime + ", nation=" + nation + ", director=" + director
				+ ", actor=" + actor + ", regdate=" + regdate + ", poster=" + poster + ", story=" + story
				+ ", cinemaIdx=" + cinemaIdx + ", multiplexIdx=" + multiplexIdx + ", cinemaName=" + cinemaName
				+ ", multiplexName=" + multiplexName + ", multiplexGrade=" + multiplexGrade + ", scheduleIdx="
				+ scheduleIdx + ", startTime=" + startTime + ", inning=" + inning + "]";
	}
	
}
