<%@page import="com.moviego.customer.notice.Notice"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css" />
<link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css" />

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
.bbs-article .table {
    margin-top: 15px;
}
.bbs-article .table thead tr, .bbs-article .table tbody tr {
    height: 30px;
}
.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
    font-weight: normal;
    border-top: none;
    border-bottom: none;
}
.bbs-article .table thead tr {
    border-top: #d5d5d5 solid 1px;
    border-bottom: #dfdfdf solid 1px;
} 
.bbs-article .table tbody tr {
    border-bottom: #dfdfdf solid 1px;
}
.bbs-article .table i {
    background: #424951;
    display: inline-block;
    margin: 0 7px 0 7px;
    position: relative;
    top: 2px;
    width: 1px;
    height: 13px;    
}
</style>

<script type="text/javascript">
function updateNotice() {
	  var noticeIdx = "${dto.noticeIdx}";
	  var page = "${page}";
	  var params = "noticeIdx="+noticeIdx+"&page="+page;
	  var url = "<%=cp%>/customer/updateNotice?" + params;

	  location.href=url;
	}
	
function deleteNotice(){
	var noticeIdx="${dto.noticeIdx}"
	var page = "${page}"
	var params = "noticeIdx="+noticeIdx+"&page="+page;
	var url = "<%=cp%>/customer/deleteNotice?" + params;

	  location.href=url;
}
</script>

<div class="content-wrapper">
	<div id="contents">
		<div class="wrap-movie-chart">
			<section class="content-header">
				<div class="tit-heading-wrap">
					<h3>공지사항</h3>
				</div>
			</section>
			<div class="table-responsive" style="clear: both;">
				<div class="bbs-article">
					<table class="table">
						<thead>
							<tr>
								<th colspan="2" style="text-align: center;">제목 :
									${dto.subject}</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td style="text-align: left;">이름 : ${dto.employeeName}</td>
								<td style="text-align: right;">${dto.regDate}<i></i>조회
									${dto.hitCount}
								</td>
							</tr>

							<tr>
								<td colspan="2" style="height: 230px;">${dto.content}</td>
							</tr>

							<c:forEach var="vo" items="${listFile}">
								<!-- listfile을 받아와서 vo로 뿌려주는것, item은 collection이라고 쉽게 생각하자 -->
								<tr>
									<td colspan="2"><span
										style="display: inline-block; min-width: 45px;">첨부</span> : <a
										href="<%=cp%>/customer/download?fileIdx=${vo.fileIdx}">${vo.originalFilename}</a>
										(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00" />
										KByte)</td>
								</tr>
							</c:forEach>

							<tr>
								<td colspan="2"><span
									style="display: inline-block; min-width: 45px;">이전글</span> : <c:if
										test="${not empty preReadDto }">
										<a
											href="<%=cp%>/customer/noticeArticle?${params}&noticeIdx=${preReadDto.noticeIdx}">${preReadDto.subject}</a>
									</c:if></td>
							</tr>
							<tr>
								<td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
									<span style="display: inline-block; min-width: 45px;">다음글</span>
									: <c:if test="${not empty nextReadDto }">
										<a
											href="<%=cp%>/customer/noticeArticle?${params}&noticeIdx=${nextReadDto.noticeIdx}">${nextReadDto.subject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>

						<tfoot>
							<tr>
								<td><c:if
										test="${sessionScope.employee.employeeGrade=='admin'}">
										<button type="button" class="btn btn-default btn-sm wbtn"
											onclick="updateNotice();">수정</button>
										<button type="button" class="btn btn-default btn-sm wbtn"
											onclick="deleteNotice();">삭제</button>
									</c:if></td>
								<td align="right">
									<button type="button" class="btn btn-default btn-sm wbtn"
										onclick="javascript:location.href='<%=cp%>/customer/noticeList?${params}';">
										목록으로</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>