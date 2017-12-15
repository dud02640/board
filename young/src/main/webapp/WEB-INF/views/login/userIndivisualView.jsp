<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 화면</title>
<%@ include file="/WEB-INF/views/include/design.jsp"%>
<!-- <base target="_self" />   -->
<script>

$(function(){
	  $('form').submit(function() {return false;});
	  var frm =$("#userindivisualForm").serialize();
		$.ajax({
			type:"POST",
			url:"/login/indivisualWorkList.do",
			data: frm,
			success: function(data){
				/* location.reload(); */
				$("#userworklist").empty();
				$("#userworklist").append(data);	
			}
		});
		  $("#userworklist button,#userworklist a").click(function(){
				$.ajax({
					type:"POST",
					url:"/login/indivisualWorkList.do",
					data: frm,
					success: function(data){
						$("#userworklist").empty();
						$("#userworklist").append(data);		
					}
				});
	});
});

function refresh(userId){
	$("#userId").val(userId);
	var frm = document.getElementById('userindivisualForm');
	frm.action="/login/userIndivisualView.do";
	frm.submit(); 
	//location.reload(); //alert가 새로고침시 나오므로 x
}
function logout(){
	var frm = document.getElementById('userindivisualForm');
		alert("로그아웃");
  		frm.action="/login/logout.do";
  		frm.submit();
}

	var emailregExp = /^[0-9a-zA-Z]+@[0-9a-zA-Z]+([.][a-zA-Z]{2,3})+$/i;
	var phoneregExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	var idregExp=/^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;

	function go_update(){
		var frm = $('#userindivisualForm').serialize();

		if($('input[name=userId1]').val().trim()==""){
			alert("아이디를 입력하시오");
			$('input[name=userId1]').focus();
		}
		else if(!idregExp.test($('input[name=userId1]').val().trim())){
			alert("아이디는 숫자,영어,한글만 사용가능합니다.");
			$('input[name=userId1]').focus();
		}
		else if($('input[name=userPw]').val().trim()==""){
			alert("비밀번호를 입력하시오");
			$('input[name=userPw]').focus();
		}
		else if($('input[name=userRepw]').val().trim()==""){
			alert("재비밀번호를 입력하시오");
			$('input[name=userRepw]').focus();
		}
		else if($('input[name=userPw]').val().trim()!=$('input[name=userRepw]').val().trim()){
			alert("비밀번호랑 비밀번호 재입력을 같게 입력하시오");
			$('input[name=userPw]').focus();
		}		
		else if($('input[name=userName]').val().trim()==""){
			alert("이름을 입력하시오");
			$('input[name=userName]').focus();
		}
		else if($('input[name=userRank]').val().trim()==""){
			alert("직책을 입력하시오");
			$('input[name=userRank]').focus();
		}		
		else if($('input[name=userPosition]').val().trim()==""){
			alert("소속을 입력하시오");
			$('input[name=userPosition]').focus();
		}
		else if($('input[name=userEmail]').val().trim()==""){
			alert("이메일을 입력하시오");
			$('input[name=userEmail]').focus();
		}
		else if(!emailregExp.test($('input[name=userEmail]').val().trim())){
			alert("잘못된 형식의 이메일 입니다.")
			$('input[name=userEmail]').focus();
		}
		else if($('input[name=userPhoneNumber]').val().trim()==""){
			alert("전화번호를 입력하시오");
			$('input[name=userPhoneNumber]').focus();
		}
		else if(!phoneregExp.test($('input[name=userPhoneNumber]').val().trim())){
			alert("잘못된 형식의 전화번호 입니다. ");
			$('input[name=userPhoneNumber]').focus();
		}
		else{
		$.ajax({
  			type: "POST",
  			url: "/login/checkId.do",
			data : frm,
  			success: function(data){
				$('#mes').val("수정 완료");
				var frm = document.getElementById('userindivisualForm');
				frm.action="/login/updatUserInfo.do";
				frm.submit();
/* 				$.post("/login/updatUserInfo.do",function(){
					$('#optionModal').modal("show");
					$('#updateUserInfo').modal("hide");
				}); */
  			}
  			});
			
		} 
		
		
	}
	function checkId(){	
/*   		if($('input[name=userId]').val().trim()=="")
			alert("아이디를 입력하시오");
		else{ */
  		$.ajax({
  			type:"POST",
  			url:"/login/checkId.do",
  			data: {"userId":$('input[name=userId]').val().trim()},
  			success: function(data){
  				if($('input[name=userId]').val()==$('input[name=gibonId]').val()){
  					$("#Ymessage").html("사용할 수 있는 아이디 입니다.");
  					$("#Nmessage").empty();
  				}else if(data>0){
/* 	  					$('#insertMember').attr('disabled',true);	//아이디가 이미 존재하면 버튼을 다시 disabled true */
  					$("#Nmessage").html("아이디가 중복입니다.");
  					$("#Ymessage").empty();
  				}
  				else if($('input[name=userId1]').val().trim()==""){
  					$("#Nmessage").html("*필수 입력 항목 입니다.");
  					$("#Ymessage").empty();
  				}else{
  					$("#Ymessage").html("사용할 수 있는 아이디 입니다.");
  					$("#Nmessage").empty();
  				}
  				
  			}
  		});
		/* } */ 
	}
	function check_key(){
		if(event.keyCode>=48&&event.keyCode<=57){
			return true;
		}else if(event.keyCode==45){
			return true;
		}else
			event.returnValue=false;
	}
	function checkPw(){	
	if($('input[name=userPw]').val().trim()!=$('input[name=userRepw]').val().trim()){
		$("#pwN_message").html("비밀 번호와 재입력 비밀번호가  다릅니다!");
		$("#pwY_message").empty();
	}else if($('input[name=userPw]').val().trim()==""){
		$("#pwN_message").html("*필수 입력 항목 입니다.");
		$("#pwY_message").empty();
	}else{
		$("#pwY_message").html("사용가능한 비밀번호입니다.");
		$("#pwN_message").empty();
	}
}
function checkEmail(){	
		if($('input[name=userEmail]').val().trim()==""){
			$("#emN_message").html("*필수 입력 항목 입니다.");
			$("#emY_message").empty();
		}else if(!emailregExp.test($('input[name=userEmail]').val().trim())){
			$("#emN_message").html("잘못된 형식의 이메일 입니다.");
			$("#emY_message").empty();
		}else{
			$("#emN_message").empty();
		}
}
function checkPhone(){
  		if($('input[name=userPhoneNumber]').val().trim()==""){
			$("#phN_message").html("*필수 입력 항목 입니다.");
			$("#phY_message").empty();
		}else if(!phoneregExp.test($('input[name=userPhoneNumber]').val().trim())){
			$("#phN_message").html("잘못된 형식의 전화번호 입니다.");
			$("#phY_message").empty();
		}else{
			$("#phN_message").empty();
		}
}
	function go_delete(){
		var frm = document.getElementById('userindivisualForm');
		var retVal = confirm($('input[name=gibonId]').val()+"님 탈퇴 하시겠습니까?");
		if(retVal==true){
			$('#mes').val("삭제 완료");
			frm.action="/login/deletemember.do";
		  	frm.submit();
		}
	}
	function pwCheck(){
		if($('input[name=pwcheck]').val().trim()==""){
			alert("비밀번호를 입력하시오.");
		}else{
	  		$.ajax({
	  			type:"POST",
	  			url:"/login/pwCheck.do",
	  			data: {"userPw":$('input[name=pwcheck]').val().trim(),"gibonId":$('input[name=userId]').val()},
	  			success: function(data){
	  				if(data>=1){
						$("#pwCheck").modal("hide");
						$("#updateUserInfo").modal("show");	
	  				}else{
	  					alert("비밀번호가 틀렷습니다.");
	  				}
	  			},
	  		});
		}
	}
	
	function deletePwCheck(){
		if($('input[name=deletePwCheck]').val().trim()==""){
			alert("비밀번호를 입력하시오.");
		}else{
	  		$.ajax({
	  			type:"POST",
	  			url:"/login/deletePwCheck.do",
	  			data: {"userPw":$('input[name=pwcheck]').val().trim(),"userId":$('input[name=userId]').val()},
	  			success: function(data){
	  				
	  				if(data>=1){
						$("#pwCheck").modal("hide");
						$("#updateUserInfo").modal("show");	
	  				}else{
	  					alert("비밀번호가 틀렷습니다.");
	  				}
	  			},
	  		});
		}
	}
	
 	function userHistory(){
		var frm =$("#userindivisualForm").serialize();
	  		$.ajax({
	  			type:"POST",
	  			url:"/login/userHistory.do",
	  			data: frm,
	  			success: function(data){
						$("#userHistoryId").empty();
						$("#userHistoryId").append(data);	
	  			},
	  		});
	} 
 	function saveImg(){
 		var frm = document.getElementById('userindivisualForm');
		frm.action="/login/saveImg.do";
	  	frm.submit();
 	}

</script>
</head>
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<form name="userindivisualForm" id="userindivisualForm" method="post" enctype="multipart/form-data">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
		<div class="input-group">
			<a class="navbar-brand" href="/project/main.do">Code-Farm 현황판</a> <label
				class="navbar-brand"><%=session.getAttribute("userName")%>(<%=session.getAttribute("userId")%>)님
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
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="logout()"> <span class="nav-link-text">로그아웃</span>
				</a></li>
			</ul>
		</div>
		</nav>
		<div class="content-wrapper">
			<div class="container-fluid">		
				<ol class="breadcrumb fontsize13em">
						<li class="breadcrumb-item active">${userInfo.userRank}</li>
						<li class="breadcrumb-item">${userInfo.userName}</li>
					<c:if test="${params.adminYn=='Y' || params.userId eq userInfo.userId }">
						<!-- 관리자인지 아닌지 자기자신인지 아닌지 -->
						<li class="col">
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#optionModal">설정</button>
						</li>
					</c:if>
				</ol>
				
				<div class="card mb-3">
					<div class="card-body bg-faded">
						<div class="row">
							<div class="media">
								<div class="media-header col">
									<img whidth="200" height="200" src="${userInfo.userImage}">
								</div>
								<div class="media-body">
									<ul class="list-inline mb-0">>개인정보	</ul>
									<ul class="list-inline mb-0">이름 : ${userInfo.userName}</ul>
									<ul class="list-inline mb-0">직책 : ${userInfo.userRank}</ul>
									<ul class="list-inline mb-0">소속 : ${userInfo.userPosition}</ul>
									<ul class="list-inline mb-0">이메일 : ${userInfo.userEmail}</ul>
									<ul class="list-inline mb-0">전화번호:	${userInfo.userPhoneNumber}</ul>
									<ul class="list-inline mb-0"></ul>							
								</div>
								<div class="media-footer col">
								<ul class="list-inline mb-0">>진행중인 프로젝트</ul>	
								<c:forEach var="userProjectInfo" items="${userProjectInfo}" >
									<li>${userProjectInfo.projectName}</li>
								</c:forEach>
								<!-- <input type="file" name="userImage" accept=".gif, .jpg, .png"/><button type="button" onclick="saveImg()">저장</button> -->
								</div>
							</div>
						</div>
						<div class="row">
						
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-7"></div>
						</div>
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body bg-faded">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<h5>개인 업무 진행 리스트</h5>
							</div>
						</div>
						<div id="userworklist">


						</div>
					</div>
				</div>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#userHistory" onclick="userHistory()">내 히스토리</button>
			</div>
		</div>
		<input type="hidden" name="userId" id="userId" value="${userInfo.userId}" />
		<input type="hidden" name="gibonId" value="${userInfo.userId}" />
		<!-- optionModal -->
		<div class="modal fade" id="optionModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">설정</h4>
						<button type="button" class="close" data-dismiss="modal"
							onclick="refresh('${userInfo.userId}')">
							<span>x</span>
						</button>
					</div>
					<div class="modal-body">
					<c:choose>
					<c:when test="${params.adminYn=='Y'}">
						<button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#updateUserInfo"  data-dismiss="modal">정보 수정하기</button>
<!-- 						<button tpye="button" class="btn btn-primary btn-block" onclick="go_delete()">회원 탈퇴</button> -->
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#pwCheck"  data-dismiss="modal">정보 수정하기</button>
						<!-- <button tpye="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#deletePwCheck" data-dismiss="modal">회원 탈퇴</button> -->
					</c:otherwise>	
					</c:choose>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="refresh('${userInfo.userId}')">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- optionModal -->

		<!-- pwCheckModal -->
		<div class="modal fade" id="pwCheck" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">비밀번호 확인</h4>
						<button type="button" class="close" data-dismiss="modal"
							onclick="refresh('${userInfo.userId}')">
							<span>x</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-row">
							<div class="col-md-6">
								<label>*비밀번호 입력</label>
								<div class="input-group-btn">
									<input class="form-control" type="password" name="pwcheck" />
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="btn-group">
								<button type="button" class="btn btn-primary" onclick="pwCheck()">확인</button>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal" data-target="#optionModal">뒤로</button>
					</div>
				</div>
			</div>
		</div>
		<!-- pwChecktModal -->
		
		<!-- pwCheckModal -->
		<div class="modal fade" id="deletePwCheck">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">비밀번호 확인</h4>
						<button type="button" class="close" data-dismiss="modal"
							onclick="refresh('${userInfo.userId}')">
							<span>x</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-row">
							<div class="col-md-6">
								<label>*비밀번호 입력</label>
								<div class="input-group-btn">
									<input class="form-control" type="text" name="deletePwCheck" />
								</div>
							</div>
						</div>
						<div class="form-row">
							<div class="btn-group">
								<button type="button" class="btn btn-primary" onclick="deletePwCheck()">확인</button>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal" data-target="#optionModal">뒤로</button>
					</div>
				</div>
			</div>
		</div>
		<!-- pwChecktModal -->

		<!-- updateUserInfoModal -->
		<div class="modal fade" id="updateUserInfo">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">회원정보 수정</h4>
						<button type="button" class="close" data-dismiss="modal" onclick="refresh('${userInfo.userId}')">
							<span>x</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="updateUserInfo">
							<div class="form-group">
								<div class="form-row">
									<div class="col-md-6">
										<input type="hidden" id="mes" name="mes"> <label>*아이디</label>
										<div class="input-group-btn">
											<input name="userId1" id="userId1" class="form-control"
												type="text" value="${userInfo.userId}" maxlength="8"
												oninput="checkId()" disabled> <input type="hidden"
												name="gibonId" value="${userInfo.userId}">
										</div>
										<label style="color: green" id="Ymessage"></label> <label
											style="color: red" id="Nmessage"></label>
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<label>*비밀번호</label> <input name="userPw" class="form-control"
											type="password" value="${userInfo.userPw}"
											oninput="checkPw()">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<label>*비밀번호 재입력</label> <input name="userRepw"
											class="form-control" type="password" value="${repw}"
											oninput="checkPw()">
									</div>
								</div>
								<label style="color: green" id="pwY_message"></label> <label
									style="color: red" id="pwN_message"></label>
								<div class="form-row">
									<div class="col-md-6">
										<label>*이름</label> <input name="userName" class="form-control"
											maxlength="8" type="text" value="${userInfo.userName}">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<label>*직책</label> <input name="userRank" class="form-control"
											maxlength="8" type="text" value="${userInfo.userRank}">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<label>*소속</label> <input name="userPosition"
											class="form-control" maxlength="8" type="text"
											placeholder="ex) 개발팀" value="${userInfo.userPosition}">
									</div>
								</div>
								<div class="form-row">
									<div class="col-md-6">
										<label for="exampleInputEmail1">*이메일</label> <input
											class="form-control" name="userEmail" maxlength="24"
											type="email" placeholder="ex) dudo200@codefarm.co.kr"
											value="${userInfo.userEmail}" oninput="checkEmail()">
									</div>
								</div>
								<label style="color: green" id="emY_message"></label> <label
									style="color: red" id="emN_message"></label>
								<div class="form-row">
									<div class="col-md-6">
										<label>*전화번호</label> <input name="userPhoneNumber"
											class="form-control" maxlength="24" type="text"
											placeholder="ex) 010-1111-1111"
											value="${userInfo.userPhoneNumber}" onkeypress="check_key()"
											oninput="checkPhone()">
									</div>
								</div>
								<label style="color: green" id="phY_message"></label> 
								<label style="color: red" id="phN_message"></label>
								<div class="form-row">
									<div class="col-md-6">
										<label">*프로젝트 사진 등록</label> 
										 <input type="file" name="userImage" accept=".gif, .jpg, .png"/>
									</div>
								</div>
							</div>
							<div class="row">
							<div class="col-sm-12 col-md-12">
									<button type="button" name="updateMember" id="insertMember" class="btn btn-primary " onclick="go_update()">수정</button>
									<button type="button" name="deleteMember" id="deleteMember" class="btn btn-danger" onclick="go_delete()">탈퇴</button>
							</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" data-toggle="modal"
									data-target="#optionModal">뒤로</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- updateUserInfoModal -->	
		</div>
		
		
		
		<!-- userHistory -->
		<div class="modal fade" id="userHistory">
		  <div class="modal-dialog modal-lg" >
		    <div class="modal-content">
		      <div class="modal-header">
		      	<h4 class="modal-title">내 히스토리</h4>
		        <button type="button" class="close" data-dismiss="modal" ><span>x</span></button>
		      </div>
		      <div class="modal-body">
		        <div id="userHistoryId">
		      
				</div>    
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal" >닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- userHistory -->
		
		
	<!-- updateWorkListModal -->
	<div class="modal fade" id="userHistoryDetailView">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div id="header" class="modal-header">
	      	<h4 class="modal-title">히스토리 상세</h4>
	        <button type="button" class="close" data-dismiss="modal" ><span>x</span></button>
	      </div>
	      <div class="modal-body">
	        <div id="userHistoryDetailViewId">
	      
			</div>    
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#userHistory" data-dismiss="modal">뒤로</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- updateWorkListModal -->
	</form>
</body>
</html>
		
