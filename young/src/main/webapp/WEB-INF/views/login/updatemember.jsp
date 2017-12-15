<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정/삭제 페이지</title>
<%@ include file ="/WEB-INF/views/include/design.jsp" %>
  <script>
  $(function(){
	  $('form').submit(function() {return false;});
  });
	var emailregExp = /^[0-9a-zA-Z]+@[0-9a-zA-Z]+([.][a-zA-Z]{2,3})+$/i;
	var phoneregExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	var idregExp=/^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;
	
  	function go_update(){
  		var frm = document.getElementById('memberForm');

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
	  			type:"POST",
	  			url:"/login/checkId.do",
	  			data: {"userId":$('input[name=userId1]').val().trim()},
	  			success: function(data){

	  				if($('input[name=userId1]').val()==$('input[name=gibonId]').val()){
	  					$('#mes').val("수정 완료");
	  			  		frm.action="/login/updatemember.do";
	  			  		frm.submit();
	  				}else if(data>0){
	  					alert("아이디가 중복입니다.");
	  		  			$('input[name=userId1]').focus();
	  				}
	  				else{
	  					$('#mes').val("수정 완료");
	  			  		frm.action="/login/updatemember.do";
	  			  		frm.submit();
	  				}
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
	  			data: {"userId":$('input[name=userId1]').val().trim()},
	  			success: function(data){
	  				if($('input[name=userId1]').val()==$('input[name=gibonId]').val()){
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
  		var frm = document.getElementById('memberForm');
  		var retVal = confirm($('input[name=gibonId]').val()+"님을 삭제 하시겠습니까?");
  		if(retVal==true){
  			$('#mes').val("삭제 완료");
  			frm.action="/login/deletemember.do";
  		  	frm.submit();
  		}
  	}
  	
  	function go_memberlist(){
  		var frm = $('#memberForm')[0];
  		frm.action="/login/memberlist.do";
  		frm.submit();
  	}
  </script>
</head>
<body class="bg-dark">
<form name="memberForm" id="memberForm" method="post" enctype="multipart/form-data">
  <div class="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header">수정/삭제</div>
      <div class="card-body">
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
          		<input type="hidden" id="mes" name="mes">
                <label>*아이디</label>
                <div class="input-group-btn">
                <input name="userId1" id="userId1" class="form-control" type="text" value="${memberinfo.userId}" maxlength="8" oninput="checkId()" disabled>
				<input type="hidden" name="gibonId" value="${memberinfo.userId}">
				</div>
				<label style="color:green" id="Ymessage"></label>
				<label style="color:red" id="Nmessage"></label>
              </div>
            </div>
             <div class="form-row">
              <div class="col-md-6">
                <label>*비밀번호</label>
                <input name="userPw" class="form-control" type="password" value="${memberinfo.userPw}"  oninput="checkPw()">
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*비밀번호 재입력</label>
                <input name="userRepw" class="form-control" type="password" value="${repw}" oninput="checkPw()">
              </div>
            </div>
            <label style="color:green" id="pwY_message"></label>
			<label style="color:red" id="pwN_message"></label>
            <div class="form-row">
              <div class="col-md-6">
                <label>*이름</label>
                <input name="userName" class="form-control"  maxlength="8" type="text" value="${memberinfo.userName}" >
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*직책</label>
                <input name="userRank" class="form-control" maxlength="8" type="text" value="${memberinfo.userRank}">
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*소속</label>
                <input name="userPosition" class="form-control" maxlength="8" type="text" placeholder="ex) 개발팀" value="${memberinfo.userPosition}">
              </div>
            </div>
            <div class="form-row">
            	<div class="col-md-6">
		            <label for="exampleInputEmail1">*이메일</label>
		            <input class="form-control" name="userEmail" maxlength="24" type="email" placeholder="ex) dudo200@codefarm.co.kr" value="${memberinfo.userEmail}" oninput="checkEmail()">
		        </div>
          	</div>
          	<label style="color:green" id="emY_message"></label>
			<label style="color:red" id="emN_message"></label>
          	<div class="form-row">
              <div class="col-md-6">
                <label>*전화번호</label>
                <input name="userPhoneNumber" class="form-control" maxlength="24" type="text" placeholder="ex) 010-1111-1111" value="${memberinfo.userPhoneNumber}" onkeypress="check_key()" oninput="checkPhone()">
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*전화번호</label>
                <input type="file" name="userImage" accept=".gif, .jpg, .png"/>
              </div>
            </div>
          </div>
          <label style="color:green" id="phY_message"></label>
		  <label style="color:red" id="phN_message"></label>
		  <div class="form-row">
          <div class="btn-group">
          <button name="updateMember" id="insertMember" class="btn btn-primary " onclick="go_update()" >
         	수정
          </button>
          <c:if test="${memberinfo.adminYn=='N'}">
          <button name="deleteMember" id="deleteMember" class="btn btn-danger" onclick="go_delete()" >
         	삭제
          </button>
          </c:if>
          <button onclick="go_memberlist()" class="btn btn-default" >
         	뒤로
          </button>
          </div>
          </div>
      </div>
    </div>
  </div>
  </form>
</body>
</html>