<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>MovieGo_Admin | Login</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="<%=cp%>/res/css/bootstrap.min.css">  
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=cp%>/res/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="<%=cp%>/res/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<script type="text/javascript">
	function check() {
		var frm = document.loginForm;
		var id = frm.txtId;
		var pass = frm.txtPass;
		
		if(!id.value) {
			alert("아이디를 입력해주세요.");
			id.focus();
			return false;
		}
		if(!pass.value) {
			alert("비밀번호를 입력해주세요.")
			pass.focus();
			return false;
		}
		return true;
		
	}
</script>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="<%=cp%>"><b>MovieGo</b>Admin</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>

    <form name="loginForm" action="<%=cp%>/login_check" method="post" onsubmit="return check();">
      <div class="form-group has-feedback">
        <input id="txtId" name="txtId" type="text" class="form-control" placeholder="ID">
      </div>
      <div class="form-group has-feedback">
        <input id="txtPass" name="txtPass" type="password" class="form-control" placeholder="Password">
      </div>
      <div class="row">
        <div class="col-xs-8">
      		<a href="#">I forgot my password</a><br>
        </div>
        <div class="col-xs-8">
      		<span style="color: blue;">${message}</span>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="<%=cp%>/res/js/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="<%=cp%>/res/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="<%=cp%>/res/js/icheck.min.js"></script>
<!-- <script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
</script> -->
</body>
</html>
