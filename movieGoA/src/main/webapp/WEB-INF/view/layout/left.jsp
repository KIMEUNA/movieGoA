<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*, java.util.Calendar, java.util.Date, java.text.SimpleDateFormat" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String cp=request.getContextPath();

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");

	String date = formatter.format(new java.util.Date());
%>
<!-- 
<script type="text/javascript">
$(function(){
	var tidx = "${treeview}";
	if(!tidx) tidx=0;
	var treeview=$(".treeview")[tidx];
	$(treeview).addClass("active");
	
	var idx="${subMenu}";
	if(!idx) idx=0;
	var subMenu=$(".treeview-menu>li")[idx];
	$(subMenu).addClass("active");
});
</script> -->

  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>       
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>영화 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
             <c:if test="${sessionScope.employee.employeeGrade == 'admin'}">
	        	<li><a href="<%=cp%>/movie/apiList"><i class="fa fa-circle-o"></i>영화진흥원 자료</a></li>
	        	<li><a href="<%=cp%>/movie/regList"><i class="fa fa-circle-o"></i>전체 영화</a></li>
            </c:if>            
            <c:if test="${sessionScope.employee.employeeGrade == 'manager'}">
            	<li><a href="<%=cp%>/movie/regList?cinemaIdx=${sessionScope.employee.cinemaIdx}"><i class="fa fa-circle-o"></i>전체 영화</a></li>
            	<li><a href="<%=cp%>/schedule/list?cinemaIdx=${sessionScope.employee.cinemaIdx}&date=<%=date%>"><i class="fa fa-circle-o"></i>영화 일정</a></li>
            </c:if>               
          </ul>        
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>고객센터 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="<%=cp%>/customer/noticeList"><i class="fa fa-circle-o"></i>공지사항</a></li> 
          </ul>
        </li>        
      </ul>
    </section>
  </aside>