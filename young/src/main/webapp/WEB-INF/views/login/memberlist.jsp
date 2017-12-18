<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file ="/WEB-INF/views/include/design.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 관리 페이지</title>
<script>
$(function(){
	$('form').submit(function() {return false;});
});
	/* 페이징 */
	function searchMember(pIndex){
		
			var frm = document.getElementById('memberForm');
			$('input[name=selectPage]').val(pIndex);
			
			frm.action = "/login/memberlist.do";
			frm.submit();	
	}
	/* 페이징 */
	function insertMember(){
		var frm = document.getElementById('memberForm');
		frm.action = "/login/memberview.do";
		frm.submit();
	}
	function go_updatemember(userId){
		var frm = document.getElementById('memberForm');
		$('input[name=userId]').val(userId);
		frm.action = "/login/updatememberView.do";
		frm.submit();
	}
	function go_multidel(){
		var frm = document.getElementById('memberForm');
		if($('input:checkbox[name=checkbox]:checked').length>0){
	  		var retVal = confirm("정말로 삭제 하시겠습니까?");
	  		if(retVal){
	  			$('#mes').val("삭제 완료");
	  			frm.action = "/login/multidelete.do";
				frm.submit();
	  		}
		}else{
			alert("삭제할 회원을 한 명 이상 선택하십시오.");
		}
			
	}
	function allclick(){
		if($('input:checkbox[name=allcheckbox]').is(":checked"))
			$('input:checkbox[name=checkbox]').not(":disabled").prop("checked",true);
		else
			$('input:checkbox[name=checkbox]').not(":disabled").prop("checked",false);
	}
	function logout(){
		var frm = document.getElementById('memberForm');
			alert("로그아웃");
	  		frm.action="/login/logout.do";
	  		frm.submit();
	}
</script>
</head>
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
<form name="memberListForm" id="memberForm" method="post" >
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
		<div class="input-group">
		<a class="navbar-brand" href="/project/main.do">Code-Farm 현황판</a>
		<label class="navbar-brand"><%=session.getAttribute("userName")%>(<%=session.getAttribute("userId")%>)님 </label>
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
	          <a class="nav-link" href="/login/indivisualView.do">
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
	<div class="content-wrapper">
		<div class="container-fluid">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/login/memberlist.do">회원관리</a></li>
			</ol>
			<div class="card mb-3">
				<div class="card-body bg-faded">
				<div class="table-responsive">
					<div class="dataTables_wrapper container-fluid dt-bootstrap4" id="dataTable_wrapper">
						<div class="row">
							<div class="col-md-12">
								<div class="dataTables_filter" id="dataTable_filter">
									<span class="input-group-btn col-md-8"> 
										<select class="form-control" name="searchOption">
												<option value="1" ${params.searchOption eq "1" ? "selected" : ""}>이름</option>
												<option value="2" ${params.searchOption eq "2" ? "selected" : ""}>아이디</option>
												<option value="3" ${params.searchOption eq "3" ? "selected" : ""}>소속</option>
												<option value="4" ${params.searchOption eq "4" ? "selected" : ""}>직책</option>
										</select>
										<input type="text" class="form-control" name="searchkeyword" value="${params.searchkeyword}"/>
										<button class="btn btn-primary" type="submit" onclick="searchMember()"><i class="fa fa-search"></i></button>
										<button class="btn btn-primary" type="button" onclick="insertMember()">회원가입</button>
 
									</span>	
								</div>
							</div>
						</div>
						<input type="hidden" id="mes" name="mes"/>
						<div class="row">
							<div class="col-sm-12">
								<table class="table table-bordered dataTable" id="dataTable" role="grid" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th><input type="checkbox" name="allcheckbox" onclick="allclick();" /></th>
											<th>번호</th>
											<th>아이디</th>
											<th>이름</th>
											<th>직책</th>
											<th>소속</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>생성날짜</th>
										</tr>
									</thead>
									<tbody>
									<c:if test="${membercnt>0}">
									<c:forEach var="list" items="${memberlist}" varStatus="status">
										<tr>
											<td>
											<c:choose>
												<c:when test="${list.adminYn eq 'Y'}">
												<input type="checkbox" name="checkbox" value="${list.userId}" disabled="true" >&nbsp;
												</c:when>
												<c:when test="${list.userDeleteYn eq 'Y'}">
												삭제된 회원
												</c:when>
												<c:otherwise>
												<input type="checkbox" name="checkbox" value="${list.userId}" >&nbsp;
												</c:otherwise>
											</c:choose>
											</td>
											<td>${params.currentpageDB=params.currentpageDB+1}</td>
											<c:choose>
											<c:when test="${list.userDeleteYn eq 'Y'}">
											<td>${list.userId}</td>
											</c:when>
											<c:otherwise><td><a href="#" onclick="go_updatemember('${list.userId}');">${list.userId}</a></td></c:otherwise>											
											</c:choose>
											<td>${list.userName}</td>
											<td>${list.userRank}</td>
											<td>${list.userPosition}</td>
											<td>${list.userEmail}</td>
											<td>${list.userPhoneNumber}</td>
											<td>${list.createDate}</td>
										</tr>
										</c:forEach>
										</c:if>
										<c:if test="${membercnt<=0}">
											<td colspan="9" style="text-align:center">검색한 결과가 없습니다.</td>
										</c:if>
										<input type="hidden" name="userId" value="">
										<input type="hidden" name="checklength" value="">
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
						<!-- 페이징 -->
						<c:if test="${membercnt>0}">
						<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
						<ul class="pagination">
							<c:if test="${params.selectPage-1!=0}">
							<li class="paginate_button page-item prvious disable"><button name="prv" class="page-link" onclick="searchMember(${params.selectPage - 1})">이전</button></li>
 							</c:if>
							<c:forEach var="pIndex" begin="${params.startpage}" end="${params.endpageNo}" step="1">
								<c:choose>
									<c:when test="${params.currentpage eq pIndex}">
										<li id="pagingNumbering" class="paginate_button page-item active"><a class="page-link" href="#" onclick="searchMember(${pIndex})">${pIndex}</a></li>
									</c:when>
									<c:otherwise>
										<li id="pagingNumbering" class="paginate_button page-item"><a class="page-link" href="#" onclick="searchMember(${pIndex})">${pIndex}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${params.endpage != params.currentpage}">
								<li class="paginate_button page-item next"><button name="next" class="page-link" onclick="searchMember(${params.selectPage +1})">다음</button></li>
 							</c:if>
						<input type="hidden" name="selectPage" value=""/>
						<input type="hidden" name="underPaging" value=""/>
						<input type="hidden" name="startpage" value="${params.startpage}"/>
						<input type="hidden" name="endpageNo" value="${params.endpageNo}"/>
						</ul>
						</div>
						</c:if>
						</div>
						<!-- 페이징 -->
						<div class="row">
						<div>
							<button class="btn btn-danger" type="button" onclick="go_multidel();">삭제</button>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</form>
</body>

</html>