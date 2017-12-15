<!-- 사용자 다중 삭제 기능 막기(체크박스도) -->
<!-- 사용자 회원가입 막기-->
<!-- 프로젝트 생성시 팀장 권한 부여(관리자만 사용자는 생성한사람이 팀장) -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/design.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(function(){
	  $('form').submit(function() {return false;});
});
/* 페이징 */
function searchMember(pIndex){
		$('input[name=selectPage]').val(pIndex);
		
		var frm = document.getElementById('mainForm');
		
		frm.action = "/project/main.do";
		frm.submit();	
}
/* 페이징 */
	function logout() {
		var frm = document.getElementById('mainForm');
		alert("로그아웃");
		frm.action = "/login/logout.do";
		frm.submit();
	}
	function createproject() {
		var frm = document.getElementById('mainForm');
		
		frm.action = "/project/createproject.do";
		frm.submit();
	}
	function projectDetailView(projectNo) {
		var frm = document.getElementById('mainForm');
		$('input[name=projectNo]').val(projectNo);
		frm.action = "/project/projectDetailView.do";
		frm.submit();
	}
	function searchProject() {
		var frm = document.getElementById('mainForm');
		frm.action = "/project/main.do";
		frm.submit();
	}
	function allclick(){
			$('input:checkbox[name=projectcheckbox]').prop("checked",$('input:checkbox[name=allcheckbox]').is(":checked"));
			/* $('input:checkbox[name=checkbox]').not(":disabled").attr("checked",true); */ 
			/* $('input:checkbox[name=checkbox]').not(":disabled").attr("checked",false); */
	}
	function go_multidel(){
		var frm = $('#mainForm')[0];
		if($('input:checkbox[name=projectcheckbox]:checked').length>0){
	  		var retVal = confirm("정말로 삭제 하시겠습니까?");
	  		if(retVal){
	  			$('#mes').val("삭제 완료");
	  			frm.action = "/project/projectmultidelete.do";
				frm.submit();
	  		}
		}else{
			alert("삭제할 프로젝트를 한 개 이상 선택하십시오.");
		}
			
	}
</script>
<title>Code-Farm 현황판</title>
</head>
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<form id="mainForm" method="post">
		<!-- Navigation-->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
			id="mainNav">
		<div class="input-group">
			<span class="input-group-btn"> <!-- 검색 --> <select
				class="form-control" name="searchOption1" width="1000">
					<option value="1" ${params.searchOption1 eq "1" ? "selected" : ""}>프로젝트명</option>
					<option value="2" ${params.searchOption1 eq "2" ? "selected" : ""}>기관명</option>
			</select> <select class="form-control" name="searchOption2" width="1000">
					<option value="0" ${params.searchOption2 eq "0" ? "selected" : ""}>프로젝트진행상태</option>
					<option value="1" ${params.searchOption2 eq "1" ? "selected" : ""}>평소</option>
					<option value="2" ${params.searchOption2 eq "2" ? "selected" : ""}>긴급</option>
					<option value="3" ${params.searchOption2 eq "3" ? "selected" : ""}>매우긴급</option>
					<option value="4" ${params.searchOption2 eq "4" ? "selected" : ""}>완료</option>
			</select>
			</span> <span class="input-group-btn"> <input class="form-control"
				type="text" name="searchkeyword" value="${params.searchkeyword}" />
				<button class="btn btn-primary" onclick="searchProject()">
					<i class="fa fa-search"></i>
				</button> <!--  -->
			</span> <a class="navbar-brand" href="/project/main.do">&emsp;&emsp;&emsp;
				Code-Farm현황판</a> <label class="navbar-brand"><%=session.getAttribute("userName")%>(<%=session.getAttribute("userId")%>)님
			</label>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation" align="right">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
				<li class="nav-item"><a class="nav-link"
					href="/project/main.do"> <i class="fa fa-fw fa-file"></i> <span
						class="nav-link-text">프로젝트</span>
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/login/indivisualView.do"> <i class="fa fa-fw fa-file"></i>
						<span class="nav-link-text">개인</span>
				</a></li>
				<c:if test="${adminYn=='Y'}">
					<li class="nav-item"><a class="nav-link"
						href="/login/memberlist.do"> <span class="nav-link-text">회원관리</span>
					</a></li>
				</c:if>
				<li class="nav-item"><a href="#" class="nav-link"
					onclick="logout();"> <span class="nav-link-text">로그아웃</span>
				</a></li>
			</ul>
		</div>
		</nav>
		<div class="content-wrapper">
			<div class="container-fluid">
				<!-- Breadcrumbs-->
				<ol class="breadcrumb fontsize13em">
					<li class="breadcrumb-item"><a href="#">프로젝트</a></li>
					<li class="breadcrumb-item active">프로젝트 현황판</li>
					<li>
						<button class="btn btn-primary" onclick="createproject();">프로젝트
							생성</button>
					</li>
				</ol>
				<c:if test="${params.adminYn=='Y'}">
					<ol>
						전체 선택
						<input type="checkbox" name="allcheckbox" onclick="allclick()">
					</ol>
				</c:if>
				<!-- Icon Cards-->
				<div class="row">
					<table>
						<c:if test="${selectboardlistcnt>0}">
							<c:forEach var="list" items="${list}">
								<div class="col-xl-3 col-sm-6 mb-3">
									<div class="card text-white o-hidden h-5 ${list.projectState}">
										<!-- 색 치환 -->
										<div class="card-body">
											<c:if test="${params.adminYn=='Y'}">
												<input type="checkbox" name="projectcheckbox"
													value="${list.projectNo}" />
											</c:if>
											<div class="mr-3">프로젝트명[상태]:${list.projectName}
												[${list.projectStateName}]</div>
											<div class="mr-3">기관명:${list.institutionName}</div>
											<div class="mr-3">팀장: ${list.leaderName}</div>
											<div class="mr-3">팀원: ${list.memberName}</div>
											<div class="mr-3">진행률: ${list.persent} %</div>
											<div class="mr-3">개발기간 : ${list.projectStartDate} ~
												${list.projectEndDate}</div>
										</div>
										<button class="card-footer text-white clearfix small z-1"
											onclick="projectDetailView('${list.projectNo}');">
											<span class="float-left">자세히</span> <span class="float-right">
												<i class="fa fa-angle-right"></i>
											</span>
										</button>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${selectboardlistcnt<=0}">
							<div class="col-xl-3 col-sm-6 mb-3">
								<div class="card text-white o-hidden h-5 bg-info">
									<div class="card-body">검색한 결과가 없습니다.</div>
								</div>
							</div>
						</c:if>
					</table>
				</div>
				<!-- 페이징 -->
				<c:if test="${selectboardlistcnt>0}">
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<c:if test="${params.selectPage-1!=0}">
									<li class="paginate_button page-item prvious disable"><button
											name="prv" class="page-link"
											onclick="searchMember(${params.selectPage - 1})">이전</button></li>
								</c:if>
								<c:forEach var="pIndex" begin="${params.startpage}"
									end="${params.endpageNo}" step="1">
									<c:choose>
										<c:when test="${params.currentpage eq pIndex}">
											<li id="pagingNumbering"
												class="paginate_button page-item active"><a
												class="page-link" href="#" onclick="searchMember(${pIndex})">${pIndex}</a></li>
										</c:when>
										<c:otherwise>
											<li id="pagingNumbering" class="paginate_button page-item"><a
												class="page-link" href="#" onclick="searchMember(${pIndex})">${pIndex}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${params.endpage != params.currentpage}">
									<li class="paginate_button page-item next"><button
											name="next" class="page-link"
											onclick="searchMember(${params.selectPage +1})">다음</button></li>
								</c:if>
								<input type="hidden" name="selectPage"
									value="${params.selectPage}" />
								<input type="hidden" name="startpage"
									value="${params.startpage}" />
								<input type="hidden" name="endpageNo"
									value="${params.endpageNo}" />
								<input type="hidden" name="projectNo"
									value="${projectdetail.projectNo}" />
								<li class="col-md-7"><c:if test="${params.adminYn=='Y'}">
										<button type="button" name="mutiDelete"
											class="btn btn-danger" onclick="go_multidel()">삭제</button>
									</c:if></li>
							</ul>
						</div>
					</div>
				</c:if>
				<!-- 페이징 -->

			</div>
		</div>
		<input type="hidden" id="mes" name="mes"> <input
			type="hidden" name="projectNo" />
	</form>
</body>
</html>
