<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>로그인 페이지</title>
<%@ include file ="/WEB-INF/views/include/design.jsp" %>
  <script>
  $(function(){
	  $('form').submit(function() {return false;});
  }); 
  	function go_main(){
  		var frm = document.getElementById('loginForm');
  		//$('input[name=userId]').attr('value',"afsdf");
  		if($('input[name=userId]').val().trim()==""){
  			alert("아이디를 입력하시오");
  		}else if($('input[name=userPw]').val().trim()==""){
  			alert("비밀번호를 입력하시오");
  		}else{
		  	frm.action = "/login/logincheck.do";
			frm.submit();
  		}
  		
  	}
  </script>

</head>
<body>
<br><br><br><br>
<form name="loginForm" id="loginForm" method="post">
	<div class="text-center"><h1>Code-farm현황판</h1></div> 
	<br><br>
  <div class="container" >
    <div class="card-login mx-auto mt-5" >
          <div class="form-group">
            <label>아이디</label>
            <input class="form-control" name="userId" type="text" value="${id}"/>
          </div>
          <div class="form-group">
            <label>비밀번호</label> 
            <input class="form-control" name="userPw" type="password">
          </div>
          <button class="btn btn-primary btn-block" onclick="go_main()">로그인</button>
        </div>
  </div>
</form>
</body>
</html>
