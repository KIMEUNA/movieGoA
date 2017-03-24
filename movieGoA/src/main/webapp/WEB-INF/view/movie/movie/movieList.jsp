<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css" />

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

$(function(){
   
	$(".box-contents a").click(function(){
		var url = "<%=cp%>/movie/movieInfo";
		var query = "movieIdx="+$(this).attr("data-movieCd");
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success: function(data) {
				var dto = data.dto;
				
				var movieIdx = dto.movieIdx;
				var movieName = dto.movieName;
				var gradeName = dto.gradeName;
				var genreName = dto.genreName;
				var effect = dto.effect;
				var runTime = dto.runTime;
				var director = dto.director;
				var actor = dto.actor;
				var nation = dto.nation;
				var regdate = dto.regdate;
				
				$("#movieIdx").val(movieIdx);
				$("#movieName").html(movieName);
				$("#gradeName").html(gradeName);
				$("#genreName").html(genreName);
				$("#effect").html(effect);
				$("#runTime").html(runTime);
				$("#director").html(director);
				$("#actor").html(actor);
				$("#nation").html(nation);
				$("#regdate").html(regdate);
				
				$("#modal_add").show();
				
			},
			error: function(e) {
				console.log(e.responseText);
			}
			
		});		
	});
	
	$("#btnModalOk").click(function(){
		var url = "<%=cp%>/movie/addMovie";
		
		var f = document.addMovie;
	
		f.movieName.value = $("#movieName").text();
		f.gradeName.value = $("#gradeName").text();
		f.genreName.value = $("#genreName").text();
		f.effect.value = $("#effect").text();
		f.runTime.value = $("#runTime").text();
		f.director.value = $("#director").text();
		f.actor.value = $("#actor").text();
		f.nation.value = $("#nation").text();
		f.regdate.value = $("#regdate").text();
		
		
		var formdata = new FormData(f);
			
		$.ajax({
			type:"post",
			url:url,
			processData: false,
			contentType: false,		
			data:formdata,
			dataType:"json",
			success: function(data) {
				alert("해당 영화가 등록되었습니다.");
				$("#modal_add").hide();				
			},
			error: function(e) {
				alert("이미 등록되었거나 작성한 양식이 부적합합니다.");
				console.log(e.responseText);
			}
			
		});		
		
		$("#poster").val("");
		$("#story").val("");	
		
	});
	
    $("#btnModalClose").click(function() {
    	$("#modal_add").hide();
    });
			
});
</script>

<div class="content-wrapper">
	<!-- <div id="contaniner"> -->
		<div id="contents">
			<div class="wrap-movie-chart">
			 <section class="content-header">
				<div class="tit-heading-wrap">
					<h3>영화진흥원 자료</h3>
				</div>
			</section>

				<form action="" name="searchFrom" onsubmit="return check();">
					현재페이지 : 	<input type="text" name="curPage" value="${dto.curPage}">
					최대 출력갯수: <input type="text" name="itemPerPage" value="${dto.itemPerPage}"> 
					감독명:	 		<input type="text" name="director" value="${dto.director}"> 
					영화명: 		<input type="text" name="movieName" value="${dto.movieName}"> <br />
					개봉연도조건: 	<input type="text" name="openStartDt" value="${dto.openStartDt}"> ~ 
									<input type="text" name="openEndDt" value="${dto.openEndDt}"> 
					제작연도조건: 	<input type="text" name="prdtStartYear" value="${dto.prdtStartYear}"> ~ 
									<input type="text" name="prdtEndYear" value="${dto.prdtEndYear}"><br>
									
					국적:<select name="repNationCd">
						<option value="">-전체-</option>
						<c:forEach items="${nationCd.codes}" var="code">
							<option value="<c:out value="${code.fullCd}"/>"
								<c:if test="${param.repNationCd eq code.fullCd}"> selected="seleted"</c:if>>
								<c:out value="${code.korNm}" /></option>
						</c:forEach>
					</select><br/> 
					
					영화형태:
					<c:forEach items="${movieTypeCd.codes}" var="code" varStatus="status">
						<input type="checkbox" name="movieTypeCdArr"
									value="<c:out value="${code.fullCd}"/>"
									id="movieTpCd_<c:out value="${code.fullCd}"/>" />
						<label for="movieTpCd_<c:out value="${code.fullCd}"/>"><c:out
								value="${code.korNm}" /></label>
						<c:if test="${status.count %4 eq 0}">
							<br />
						</c:if>
					</c:forEach>
					<br /> <input type="submit" value="조회">
				</form>

				검색 결과:&nbsp;
				<c:out value="${result.movieListResult.totCnt}" /> 개				
					<div class="sect-movie-chart">
						<ol>
							<c:if test="${not empty result.movieListResult.movieList}">
								<c:forEach var="movie" items="${result.movieListResult.movieList}">

									<li>
									<div class="box-contents">
											<a href="#" onclick="return false;" data-movieCd="${movie.movieCd}"> 
												<strong class="title">
													<c:out value="${movie.movieNm}"/>
												</strong>
											</a> 
											<span class="txt-info"> 
												<strong> 
													<span>개봉일:&nbsp;</span>
													<c:out value="${movie.openDt}" />
												</strong>
											</span> 
											<span class="txt-info"> 
												<strong> 
													<span>제작:&nbsp;</span>
												<c:out value="${movie.prdtYear}" />,&nbsp; 
												<c:out value="${movie.repNationNm}" />&nbsp;
											</strong>
											</span> 
											
											<span class="txt-info"> 
												<strong> 
												<span>감독:&nbsp;</span>
												<c:forEach var="director" items="${movie.directors}" varStatus="stat">
															<c:out value="${director.peopleNm}" />
															${not stat.last ? ',' : ''}
								  				</c:forEach>
												</strong>
											</span>
										</div>
									</li>
								</c:forEach>
							</c:if>
						</ol>
					</div>
			</div>
		</div>
	<!-- </div> -->
</div>


<!-- start modal -->
<div class="modal fade in" id="modal_add" tabindex="-1" role="dialog"
	aria-labelledby="scheduleModalLabel" aria-hidden="true" style="padding-right: 17px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="scheduleModalLabel"
					style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">
					영화 등록</h4>
			</div>
			<div class="modal-body">
				<form id="addMovie" name="addMovie" class="form-horizontal" enctype="multipart/form-data" >
				  <input type="hidden" id="movieIdx" name="movieIdx">
					<div class="form-group">
						<label class="col-sm-2 control-label">영화</label>
						<div class="col-sm-10">
							<p class="form-control-static">
							<label  id="movieName"></label>
							</p>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">포스터</label>
						<div class="col-sm-10">
							<input id="upload"  name="upload" type="file" class="form-control input-sm" style="width: 70%;">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">제작 국가</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="nation" ></p>							
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">감독</label>
						<div class="col-sm-10">
							<p class="form-control-static"  id="director" ></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">배우</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="actor"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">장르</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="genreName"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">상영 유형</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="effect"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">상영 시간</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="runTime"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">관람 등급</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="gradeName"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">개봉일</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="regdate"></p>
						</div>
					</div>
					<div class="form-group" style="min-height: 75px;">
						<label class="col-sm-2 control-label">내용</label>
						<div class="col-sm-10">
							<textarea name="story"  id="story" class="form-control"  style="width: 430px; height: 100px;"></textarea>
							<input type="hidden" name="movieName">
							<input type="hidden" name="gradeName">
							<input type="hidden" name="genreName">
							<input type="hidden" name="effect">
							<input type="hidden" name="runTime">
							<input type="hidden" name="director">
							<input type="hidden" name="actor">
							<input type="hidden" name="nation">
							<input type="hidden" name="regdate">
									
						</div>
					</div>
				</form>
				<div style="text-align: right;">
					<button id="btnModalOk"  class="btn btn-primary">
						 <span class="glyphicon glyphicon-ok">등록</span></button>
						 
					<button type="button" class="btn btn-default"
						data-dismiss="modal" style="margin-left: 0px;" id="btnModalClose">
						닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>