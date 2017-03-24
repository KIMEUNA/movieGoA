<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/jquery-ui.css" />

<script type="text/javascript" src="<%=cp%>/res/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/js/jquery.ui.datepicker-ko.js"></script>

<script type="text/javascript">

var multiplexIdx;
var runtime;
var startDateTime;
var endDateTime;
var movieIdx_u;

$(function() {

	$("#date").datepicker({
		dateFormat: "yy/mm/dd"
	});
	
	$("#date").change(function () {		
		var url = "<%=cp%>/schedule/list";
		url += "?cinemaIdx="+$("#cinemaIdx").val();
		url += "&date="+$(this).val();
		
		location.href=url;		
	});
	
	$("body").on("click", "#btnAdd", function () {
		multiplexIdx = $(this).attr("data-multiplex_idx");
		$("#multiplexIdx").val(multiplexIdx);		
		$("#multiplexName").html($(this).attr("data-multiplex_name"));
		
		var default_movie = $("input[name=movie] option:eq(0)").val();
		$("input[name=movie]").val(default_movie);	
		
		$("#modal_add").show();		
	});
	

	$("input[name=startTime]").change(function() {
		var s = $(this).val();
		runtime=jQuery(this).parents(".modal-body").find("select[name=movie] option:selected").attr("data-runTime");
		endTimeCal(s);
		
		startDateTime = $("input[name=date_s]").val() + " " + s;
		endDateTime = $("input[name=endTime]").val();
	});			
    
 // 영화 종료시간 자동 계산 
    function endTimeCal(obj) {
	 var s = obj.split(':');

	 console.log(s[0]+","+s[1]);
   	 var hours = parseInt(s[0]);
   	 var minutes = parseInt(s[1]);   		
   	 
   	 

    	console.log("minutes:"+minutes);
   	 console.log("runtime:"+runtime);
   	 while(runtime>=60) {
   		 runtime -= 60;
   		 hours++;
   	 }

   	 console.log(runtime);
   	 minutes += runtime;
   	console.log("minutes:"+minutes);
   	 if(minutes>=60) {
   		minutes -= 60;
   		hours++;
   	 }
   	console.log("minutes:"+minutes);
   	 console.log(hours+","+minutes);
   	 
   	 hours = hours.toString().length<2 ? '0' + hours : hours;
	 minutes = minutes.toString().length<2 ? '0' + minutes : minutes;
   	
	 
   	 $("input[name=endTime]").val(hours + ":" + minutes);
   	 
   }	
 
	$("#btnModalOk").click(function () {
		var url = "<%=cp%>/schedule/addSchedule";		
						
		var query = "movieIdx="+ $("#movie").val();
		query += "&multiplexIdx=" + multiplexIdx;
		query += "&startTime=" + startDateTime;
		query += "&endTime=" + endDateTime;
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
		
		$("#startTime").val("");
		$("#endTime").val("");
		$("#price_adult").val("");
		$("#price_youth").val("");	
		
	});
	
	$("body").on("click", "#movie_u", function () {
		movieIdx_u = $(this).val();
		console.log("sfddfsfd: "+ movieIdx_u);
	});
	
	$("body").on("click", "#btnModalOk_u", function () {
	
		var url = "<%=cp%>/schedule/update";
		
		var query = "scheduleIdx="+ $(this).attr("data-schedule_idx");
		query += "&movieIdx="+ movieIdx_u;
		query +="&startTime=" + startDateTime;
		query +="&endTime=" + endDateTime;	
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success: function(data) {
				alert("해당 일정 수정되었습니다.");
			},
			error: function(e) {
				alert("해당 일정을 수정할 수 없습니다.");;
				console.log(e.responseText);
			}
		
		});
		
		var default_movie = $("input[name=movie] option:eq(0)").val();
		$("input[name=movie]").val(default_movie);	
		
	});
	
    $("button[name=close]").click(function() {
    	$(".modal").hide();
    	
		$("input[name=startTime]").val("");
		$("input[name=endTime]").val("");
		$("#price_adult").val("");
		$("#price_youth").val("");	
    });    
    
	$("body").on("click", "button[name=btnDelete]",function() {
		var url = "<%=cp%>/schedule/delete_s";
		var query = "scheduleIdx="+ $(this).attr("data-schedule_idx");
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success: function(data) {
				alert("해당 일정이 삭제되었습니다.");
			},
			error: function(e) {
				console.log(e.responseText);
			}
		});
	});
})

function list_m(multiplexIdx) {
	var url="<%=cp%>/schedule/list_m";
	var query= "multiplexIdx="+multiplexIdx;
	query += "&date=" + $("input[name=date_s]").val();
	
	jQuery.ajax({
			type:"post",
			url:url,
			data:query,
			success: function(data){
				$("#schedule_m").html(data);
			},
			error: function(e) {
				console.log(e.responseText);
			}
		});
}


</script>

<div class="content-wrapper" >
	<div id="cgvwrap" >
		<div id="contents" class="" >
			<!-- 실컨텐츠 시작 -->
			<div class="wrap-theater">
				<div class="sect-theater " style="clear: both;">
					<section class="content-header">
						<h4 class="theater-tit" style="float: left; margin-top: 20px;">
							<span >MovieGo ${cinemaName}점</span>
						</h4>
					</section>
					<input id="cinemaIdx" type="hidden" value="${cinemaIdx}">
					
					<div class="form-group" >
						<div class="col-sm-10" >
							<div class="row" >
								<div class="col-sm-2"  style="float: right;">
									<input class="form-control" id="date" type="text" placeholder="기준 날짜">
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<!-- .sect-theater -->
				<div class="cols-content">
					<div class="col-detail">
						<div class="showtimes-wrap">
							<div class="sect-schedule">		
							</div>

							<div class="sect-showtimes">
								
								<div class="btn-group" style="margin-top: 20px; width: 100%">
									<c:forEach var="multiplex" items="${list_multiplex}" varStatus="stat">
										<span class="btn bg-olive btn-flat" style="left: ${stat.index*20}px">
											<a onclick="list_m('${multiplex.multiplexIdx}');" style="text-decoration:none">
												${multiplex.multiplexName}</a></span>
									</c:forEach>
								</div>
								
								<div style="margin-top: 25px"></div>
								
								<div id="schedule_m">
								
								<ul>
									<c:forEach var="multiplex" items="${list_multiplex}">
										<li>
										
											<div class="box">
												<div class="box-header with-border">
													<h3 class="box-title"><a onclick="list_m('${multiplex.multiplexIdx}');" style="text-decoration:none">${multiplex.multiplexName}</a></h3>
													<div style="float: right; margin-right: 20px;">
														<button type="button" class="btn btn-block btn-primary btn-flat"
															data-multiplex_idx = "${multiplex.multiplexIdx}"
															data-multiplex_name = "${multiplex.multiplexName}"
															data-date = "${date}"
															id="btnAdd">회차 추가</button>
													</div>
												</div>									
												
												
												<!-- /.box-header -->
												<div class="box-body">			
														<table class="table table-bordered"
														style="font-size: 14px;">
														<tr>
															<th style="width: 200px">시작 시간</th>
															<th style="width: 100px">종료 시간</th>
															<th style="width: 400px">제목 / 감독</th>
															<th style="width: 70px">런타임</th>
															<th style="width: 70px">유형</th>														
															<th style="width: 150px"></th>
														</tr>
														<c:forEach var="dto" items="${list}">
															<c:if test="${dto.multiplexName eq multiplex.multiplexName}">
																<tr>
																	<td>${dto.startTime}</td>
																	<td>${dto.endTime}</td>
																	<td>${dto.movieName}/ ${dto.director}</td>
																	<td>${dto.runTime}분</td>
																	<c:if test="${dto.effect eq '2D'}">
																		<td><span class="badge bg-green">${dto.effect}</span></td>
																	</c:if>
																	<c:if test="${dto.effect eq '3D'}">
																		<td><span class="badge bg-blue">${dto.effect}</span></td>
																	</c:if>
																	<c:if test="${dto.effect eq '4D'}">
																		<td><span class="badge bg-red">${dto.effect}</span></td>
																	</c:if>
																	<td>
																		<button type="button" class="btn bg-gray"style="font-size: 12px"
																			data-target="#modal_update${dto.scheduleIdx}" data-toggle="modal"
																			onclick="time('${dto.startTime}');">수정</button>
																				
																	<!--start Modal  -->
																		<div class="modal fade in" id="modal_update${dto.scheduleIdx}"  tabindex="-1" role="dialog" 
																			aria-labelledby="scheduleModalLabel" aria-hidden="true" style="padding-right: 17px;">
																			<div class="modal-dialog">
																				<div class="modal-content">
																					<div class="modal-header">
																						<button type="button" name="close" class="close" data-dismiss="modal" aria-label="Close">
																							<span aria-hidden="true">×</span>
																						</button>
																						<h4 class="modal-title" id="scheduleModalLabel"style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">
																							상영 일정 수정</h4>
																					</div>
																					<div class="modal-body">
																						<form class="form-horizontal">
																							<div class="form-group">
																								<label class="col-sm-2 control-label">${cinemaName}</label>
																								<div class="col-sm-10">
																									<p class="form-control-static">${dto.multiplexName}
																									<input type="hidden" value="${dto.multiplexIdx}">
																								</div>
																							</div>
																		
																							<div class="form-group">
																								<label class="col-sm-2 control-label">영화</label>
																								<div class="col-sm-10">
																									<select name="movie" id="movie_u" class="form-control select2" style="width: 230px;">
																										<option selected="selected" value="${dto.movieIdx}" data-runTime="${dto.runTime}">
																											${dto.movieName} / (${dto.runTime}분)</option> 
																										<c:forEach var="show" items="${list_show}">
																											<c:if test="${dto.movieIdx ne show.movieIdx }">																											
																												<option value="${show.movieIdx}" data-runTime="${show.runTime}">
																												${show.movieName} / (${show.runTime}분) </option>
																											</c:if>
																										</c:forEach>
																									</select>			
																								</div>
																							</div>
																		
																							<div class="form-group">
																								<label class="col-sm-2 control-label">시작 시간</label>
																								<div class="col-sm-10">
																									<div class="row">
																										<div class="col-sm-4" style="padding-left: 15px;">
																											<p class="form-control-static"> ${date}
																											<input name="date_s" type="hidden" value="${date}">
																											<input  name="startTime" class="form-control"  type="time">
																											<script type="text/javascript">																											
																												function time(obj) {
																												 	var t = obj.substr(11, 5);
																												 	
																												 	$("input[name=startTime]").val(t);
																												}																											
																											</script>
																										</div>
																									</div>
																								</div>
																							</div>
																		
																							<div class="form-group">
																								<label class="col-sm-2 control-label">종료 시간</label>
																								<div class="col-sm-10">
																									<div class="row">
																										<div class="col-sm-4" style="padding-left: 15px;">
																											<p class="form-control-static"> ${date}
																											<input name="endTime" class="form-control" readonly="readonly" 
																											placeholder="${dto.endTime}" type="text" value="${dto.endTime}"
																											style="background: white;">
																										</div>
																									</div>
																								</div>
																							</div>
																						</form>
																		
																						<div style="text-align: right;">
																						   <!--  <input  id="movieIdx" type="hidden">  -->
																							<button id="btnModalOk_u" class="btn btn-primary" 
																								data-schedule_idx="${dto.scheduleIdx}">확인 
																								<span class="glyphicon glyphicon-ok"></span></button>
																							<button id="btnModalClose_u" name="close" type="button" class="btn btn-default" data-dismiss="modal"style="margin-left: 0px;">닫기</button>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>
																		<!-- end Modal -->

																		<button name="btnDelete" data-schedule_idx="${dto.scheduleIdx}" type="button"
																			class="btn bg-gray" style="font-size: 12px">삭제</button>
																	</td>
																</tr>
															</c:if>
														</c:forEach>
													</table>
												</div>
												<!-- /.box-body -->
											</div>
											
										</li>
									</c:forEach>

								</ul>
								</div>
							</div>
						</div>
					</div>
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
				<button type="button" name="close" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="scheduleModalLabel"style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">
					상영 일정 추가</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label">${cinemaName}</label>
						<div class="col-sm-10">
							<p class="form-control-static" id="multiplexName">
							<input id="multiplexIdx" type="hidden">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">영화</label>
						<div class="col-sm-10">
							<select name="movie" id="movie" class="form-control select2" style="width: 230px;">
								<c:forEach var="show" items="${list_show}">
									<option value="${show.movieIdx}" data-runTime="${show.runTime}">
									${show.movieName} / (${show.runTime}분) </option>
								</c:forEach>
							</select>			
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">시작 시간</label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-4" style="padding-left: 15px;">
									<p class="form-control-static"> ${date}
									<input name="date_s" type="hidden" value="${date}">
									<input name="startTime" class="form-control" id="startTime" type="time" placeholder="시작 시간">
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">종료 시간</label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-4" style="padding-left: 15px;">
									<p class="form-control-static"> ${date}
									<input name="endTime" class="form-control" readonly="readonly" id="endTime" type="text" placeholder="종료시간">
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
					<button id="btnModalClose" name="close" type="button" class="btn btn-default" data-dismiss="modal"style="margin-left: 0px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

