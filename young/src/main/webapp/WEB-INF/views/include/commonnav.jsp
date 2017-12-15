<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file ="/WEB-INF/views/include/design.jsp" %>
<script>
	function logout(){
		var frm = document.getElementById('commonForm');
			alert("로그아웃");
	  		frm.action="/login/logout.do";
	  		frm.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
<form id="commonForm">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">

		<div class="input-group">
		<a class="navbar-brand" href="/project/main.do">Code-Farm 현황판</a>
		<label class="navbar-brand"><%= session.getAttribute("userId") %>님 </label>
	    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation" align="right">
	      <span class="navbar-toggler-icon" ></span>
	    </button>
	  </div>  
	    <div class="collapse navbar-collapse" id="navbarResponsive">
	      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
	        <li class="nav-item">
	          <a class="nav-link" href="/project/main.do">
	            <i class="fa fa-fw fa-file"></i>
	            <span class="nav-link-text">프로젝트</span>
	          </a>
	        </li>
	        <li class="nav-item" >
	          <a class="nav-link" href="#">
	            <i class="fa fa-fw fa-file"></i>
	            <span class="nav-link-text">개인</span>
	          </a>
	        </li>
	       	<li class="nav-item" >
	          <a class="nav-link" href="/login/memberlist.do">
	            <span class="nav-link-text">회원관리</span>
	          </a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#" onclick="logout()">
	            <span class="nav-link-text">로그아웃</span>
	          </a>
	        </li>
	      </ul>
	    </div>
  </nav>
  
<!--    <div class="content-wrapper">
    <div class="container-fluid">
    
      Breadcrumbs
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">회원관리</a>
        </li>
        <li class="breadcrumb-item active">회원목록</li>
      </ol>
      
      </div>
     </div> -->
     </form>
</body>
</html>