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
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/jquery-ui.min.css">
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/jquery.datetimepicker.css">

<script type="text/javascript" src="<%=cp%>/res/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/js/jquery.datetimepicker.full.min.js"></script>

<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.action = "<%=cp%>/movie/regList";
	f.submit();
}

$(function(){
	$("body").on("click", ".btnAdd", function() {
		console.log("btnAdd");
		var url = "<%=cp%>/schedule/modalInfo";
		var query = "movieIdx="+$(this).attr("data-movie_cd");
			  query+="&cinemaIdx="+$(this).attr("data-cinema_idx");
		
			  console.log(url+"  "+query);
			  
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success: function(data) {
				var movie = data.movie;
				var list_m = data.list_m;
				
				var movieIdx = movie.movieIdx;
				var movieName = movie.movieName;
				var gradeName = movie.gradeName;
				var effect = movie.effect;
				var runTime = movie.runTime;
				var director = movie.director;
				var nation = movie.nation;
				var regdate = movie.regdate;
				
				var cinemaName = list_m[0].cinemaName;
				var default_multiplex = list_m[0].multiplexIdx;
				
				$("#movieName").text(movieName+" / "+director+" / "+effect);
				$("#gradeName").html(gradeName);
				$("#runTime").html(runTime);
				$("#nation").html(nation);
				$("#regdate").html(regdate);
				$("#cinemaName").html(cinemaName);
				$("#movieIdx").val(movieIdx);
				$("#default_multiplex").val(default_multiplex);
				
				var multiplexIdx="";
				for (var i = 0; i < list_m.length; i++) {
					multiplexIdx=multiplexIdx+"<option value=\""+list_m[i].multiplexIdx+"\">"+list_m[i].multiplexName+"</option>";
				}
				$("#multiplexIdx").html(multiplexIdx);
				
				$("#modal_add").show();
				
			},
			error: function(e) {
				console.log(e.responseText);
			}
			
		});		
	});
	
	$("#startTime").datetimepicker();
	
	$("#startTime").change(function() {
		endTimeCal($(this).val());
	});
	
    
	 // 영화 종료시간 자동 계산 
    function endTimeCal(obj) {
	 var time=obj.substr(11, 5);
	 
   	 var hours = parseInt(time.split(':')[0]);
   	 var minutes = parseInt(time.split(':')[1]);
   	 
   	 // 영화 정보 중 시간정보가 항상 배열 맨 마지막에 있을 때
   	 var runtime = $("#runTime").text();
   	 
   	 console.log(runtime);
   	 
   	 while(runtime>=60) {
   		 runtime -= 60;
   		 hours++;
   	 }

   	 minutes += runtime;
   	 
   	 if(minutes>=60) {
   		minutes -= 60;
   		hours++;
   	 }
   	 
   	 hours = hours.toString().length<2 ? '0' + hours : hours;
	 minutes = minutes.toString().length<2 ? '0' + minutes : minutes;
   	
   	 $("#endTime").val(hours + ":" + minutes);
   }
		
	$("#btnModalOk").click(function () {
		var url = "<%=cp%>/schedule/addSchedule";		
						
		var query = "movieIdx="+ $("#movieIdx").val();
		query += "&multiplexIdx=" + $("#multiplexIdx").val();
		query += "&startTime=" + $("#startTime").val();	
		query += "&endTime=" + $("#endTime").val();	
		query += "&price_adult=" + $("#price_adult").val();	
		if($("#price_youth").val())
		   query += "&price_youth=" + $("#price_youth").val();
				
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success: function(data) {
				alert("상영 일정이 등록되었습니다.");
				$("#modal_add").hide();				
			},
			error: function(e) {
				alert("작성한 양식이 부적합합니다.");
				console.log(e.responseText);
			}
			
		});		
		
		$("#multiplexIdx").val($("#default_multiplex").val());
		$("#startTime").val("");
		$("#endTime").val("");
		$("#price_adult").val("");
		$("#price_youth").val("");	
		
	});
	
    $("#btnModalClose").click(function() {
    	$("#modal_add").hide();
    	
    	$("#multiplexIdx").val($("#default_multiplex").val());
		$("#startTime").val("");
		$("#endTime").val("");
		$("#price_adult").val("");
		$("#price_youth").val("");	
    });      

});

</script>
<div class="content-wrapper">
		<div id="contents" >
			<div class="wrap-movie-chart" >
				<section class="content-header">
				<div class="tit-heading-wrap">
					<h3>전체 영화</h3>					
				</div>
				</section>
			
				<c:if test="${dataCount != 0}">
					<div style="clear: both; height: 30px; line-height: 30px;">
						<div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
						<div style="float: right;">&nbsp;</div>
					</div>
					
					<div class="sect-movie-chart">
						<ol>
							<c:if test="${not empty list}">
								<c:forEach var="dto" items="${list}">
									<li>
										<div class="box-image">
										<a id="btnMovie" data-movie_cd="${dto.movieIdx}" 
												href="${urlArticle}&movieIdx=${dto.movieIdx}">										
											<%-- <a id="btnMovie" data-movie_cd="${dto.movieIdx}" 
												href="<%=cp%>/movie/readmovie?page=${page}&movieIdx=${dto.movieIdx}"> --%>
												<img style="width: 90%" src="<%=cp%>/res/poster/${dto.poster}.jpg" alt="${dto.movieName} 포스터"/>
											</a>
										
										</div>
										<div class="box-contents">
												<strong class="title">
													<c:out value="${dto.movieName}"/>
												</strong>
											<span class="txt-info"> 
												<strong> 
													<span>개봉일:&nbsp;</span>
													<c:out value="${dto.regdate}" />
												</strong>
											</span> 
											<span class="txt-info"> 
												<strong> 
													<span>제작:&nbsp;</span>
												<c:out value="${dto.nation}" />&nbsp;
											</strong>
											</span> 											
											<span class="txt-info"> 
												<strong> 
													<span>감독:&nbsp;</span>
												<c:out value="${dto.director}" />&nbsp;								  			
												</strong>
											</span>	
												<c:if test="${sessionScope.employee.employeeGrade == 'manager'}">
													<button type="button" class="btn bg-olive btn-flat btnAdd"
														data-movie_cd="${dto.movieIdx}"
														data-cinema_idx="${sessionScope.employee.cinemaIdx}"
														style="margin-left: 30px; float: right;">추가</button>										
												</c:if>											
										</div>
									</li>
								</c:forEach>
							</c:if>
						</ol>
					</div>
				</c:if>	
								
				<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
					<c:if test="${dataCount==0}">
						등록된 영화가 없습니다.
					</c:if>
					<c:if test="${dataCount!=0}">
						${paging}
					</c:if>
				</div>							
					
				<div style="clear: both;">
					<div style="float: left; width: 20%; min-width: 85px;">
						<button type="button" class="btn btn-default btn-sm wbtn" 
						onclick="javascript:location.href='<%=cp%>/movie/regList';">새로고침</button>
					</div>
					<div style="float: left; width: 60%; text-align: center;">
						<form name="searchForm" method="post" class="form-inline">
							<select class="form-control input-sm" name="searchKey">
								<option value="movieName">영화제목</option>
								<option value="director">감독명</option>
							</select>
							<input type="text" class="form-control input-sm input-search" name="searchValue">
							<button type="button" class="btn btn-default btn-sm wbtn" onclick="searchList();">
								검색</button>
						</form>
					</div>
				</div>	
			</div>
		</div>		
	</div>
	
	
			
<!--start Modal  -->
<div class="modal fade in" id="modal_add" tabindex="-1" role="dialog" 
	aria-labelledby="scheduleModalLabel" aria-hidden="true" style="padding-right: 17px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="scheduleModalLabel"style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">
					상영 일정 추가</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label" id="cinemaName"></label>
						<div class="col-sm-10">
							<select id="multiplexIdx" class="form-control select2" style="width: 80px;"></select>
							<input id="default_multiplex" type="hidden">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">영화</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="movieName">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">런타임</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="runTime">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">시작 시간</label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-5" style="padding-left: 15px;">
									<input class="form-control" id="startTime" type="text" placeholder="날짜 및 시간">
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">종료 시간</label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-5" style="padding-left: 15px;">
									<input class="form-control" style="background: white;" readonly="readonly" id="endTime" type="text" placeholder="종료시간">
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">일반 가격</label>
						<div class="col-sm-10">
							<input type="text" id="price_adult" style="width: 100px; height: 20px;"> 원
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">청소년 가격</label>
						<div class="col-sm-10">
							<input type="text" id="price_youth" style="width: 100px; height: 20px;"> 원
						</div>
					</div>
				</form>

				<div style="text-align: right;">
				    <input  id="movieIdx" type="hidden"> 
					<button id="btnModalOk" class="btn btn-primary" >확인 <span class="glyphicon glyphicon-ok"></span></button>
					<button id="btnModalClose" type="button" class="btn btn-default" data-dismiss="modal"style="margin-left: 0px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
