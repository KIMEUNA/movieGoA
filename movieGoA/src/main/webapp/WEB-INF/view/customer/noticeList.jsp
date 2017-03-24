<%@ page contentType="text/html; charset=UTF-8"%>
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
<script type="text/javascript">
function searchList(){
	var f=document.searchForm;
	f.action="<%=cp%>/customer/noticeList";
	f.submit();
}
</script>

  <div class="content-wrapper">
  <div id="contents">
	<div class="wrap-movie-chart">
    <section class="content-header">
    <div class="tit-heading-wrap">
      <h3> 공지사항 </h3>
     </div>
     
      	<div>
      		<c:if test="${dataCount!=0}">
      		    <div style="clear : both; height : 30px; line-height : 30px;">
	      		      <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	      		      <div style="float: right;">&nbsp;</div>
      		    </div>
      		</c:if>	
      	</div>
      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> AdminHome</a></li>
	        <li><a href="#">고객센터 관리</a></li>
	        <li class="active">공지사항</li>
      </ol>
    </section>
    
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
            
             <h3 class="box-title">공지사항 목록</h3>
             
            <div style="float: right; width: 100%; text-align: right;">
        		     <form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey" >
						      <option value="subject">제목</option>
						      <option value="content">내용</option>
						      <option value="regDate">등록일</option>
						  </select>
						  
						  <input type="text" class="form-control input-sm input-search" name="searchValue">
						  <button type="button" class="btn btn-default btn-sm wbtn" onclick="searchList();">검색</button>
        		    </form>
        		</div>
             
              
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
               <thead>
	                <tr>
		                  <th class="text-center" style="width: 80px;">번호</th>
		                  <th class="text-center" style="width: 100px;">구분</th>
		                  <th>제목</th>
		                  <th class="text-center" style="width: 80px;">글쓴이</th>
		                  <th class="text-center" style="width: 100px;">날짜</th>
		                  <th class="text-center" style="width: 100px;">조회수</th>
	                </tr>
                </thead>
                
                <tbody>
       <c:forEach var="dto" items="${noticeList}"> <!--[공지] 리스트 -->
	                <tr>
	                <td class="text-center">
	                <span style="display: inline-block;width: 28px;height:18px;line-height:18px; background: #ED4C00;color: #FFFFFF">공지</span>
	                </td>
		                <td class="text-center">${dto.type}</td>
                        <td><a href="${urlArticle}&noticeIdx=${dto.noticeIdx}">${dto.subject}</a></td>
                        <td class="text-center">${dto.employeeName}</td>
                        <td class="text-center">${dto.regDate}</td>
                        <td class="text-center">${dto.hitCount}</td>
	                </tr>
	    </c:forEach> 
	    
	    <c:forEach var="dto" items="${list}">  <!--그냥 공지사항 리스트 -->
                    <tr>
                        <td class="text-center">${dto.listNum}</td>
                        <td class="text-center">${dto.type}</td>
                        <td><a href="${urlArticle}&noticeIdx=${dto.noticeIdx}">${dto.subject}</a></td>
                        <td class="text-center">${dto.employeeName}</td>
                        <td class="text-center">${dto.regDate}</td>
                        <td class="text-center">${dto.hitCount}</td>
                    </tr>
     </c:forEach>     
	    
               </tbody>
              </table>
              
             <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
	          	  <c:if test="${dataCount==0}">
	                  	등록된 게시물이 없습니다.
	         	  </c:if>
	          	  <c:if test="${dataCount!=0}">
	              	  ${paging}
	           	 </c:if>
      		  </div>        
           </div>

            <div class="box-footer clearfix">
	             <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/customer/noticeCreated';">글쓰기</button>   <!-- 현재창에서 글쓰기 폼 경로로 이동할 수 있도록 링크를 걸어주는 것 . (onclick) -->
	             <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/customer/noticeList';">새로고침</button>
            </div>
          </div>

        </div>
      </div>
    </section>
  </div>
  </div>
  </div>