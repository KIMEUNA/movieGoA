<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
	String cp=request.getContextPath();
%>

<style>

.table-bordered input {
	border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}

</style>

<ul>
		<li>		
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><a onclick="list_m('${multiplexIdx}');" style="text-decoration:none">${multiplexName}</a></h3>
					<div style="float: right; margin-right: 20px;">
						<button type="button" class="btn btn-block btn-primary btn-flat"
							data-multiplex_idx = "${multiplexIdx}"
							data-multiplex_name = "${multiplexName}"
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
																	<input  name="startTime" class="form-control" type="time">
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
																	<input name="endTime" class="form-control" style="background: white;" readonly="readonly" 
																		placeholder="${dto.endTime}" type="text" value="${dto.endTime}">
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
						</c:forEach>
					</table>
				</div>
				<!-- /.box-body -->
			</div>
		</li>
</ul>