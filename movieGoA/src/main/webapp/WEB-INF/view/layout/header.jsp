<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
   String cp = request.getContextPath();
%>

  <header class="main-header">

    <!-- Logo -->
     <c:if test="${sessionScope.employee.employeeGrade == 'admin'}">
    <a href="<%=cp%>/movie/regList" class="logo">    
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>MovieGo</b>Admin</span>
    </a>
    </c:if>
    
    <c:if test="${sessionScope.employee.employeeGrade == 'manager'}">
    <a href="<%=cp%>/movie/regList?cinemaIdx=${sessionScope.employee.cinemaIdx}" class="logo">    
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>MovieGo</b>Admin</span>
    </a>
    </c:if>           

    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">

          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu" style="clear: both;">
            <a href="#" style="float: right;">
              <span class="hidden-xs" >${sessionScope.employee.name}</span>
            </a>
            <div style="float:right; margin-top: 10px;">
                  <a href="<%=cp%>/logout" class="btn btn-default btn-flat">Sign out</a>
            </div>           
           
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>

    </nav>
  </header>