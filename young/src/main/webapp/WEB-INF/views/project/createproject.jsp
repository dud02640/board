<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file ="/WEB-INF/views/include/design.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 생성 페이지</title>
<script>
$(function(){
	  $('form').submit(function() {return false;});
});
function insertProject(){
	var frm = document.getElementById('projectForm');

	if(parseInt($("#start").val())>parseInt($("#end").val())){
			alert("시작일과 종료일을 확인하세요.");
			$('input[name=projectStartDate]').focus();
	}else if($('input[name=projectName]').val().trim()==""){
  			alert("프로젝트명을 입력하시오");
  			$('input[name=projectName]').focus();
  	}else if($('input[name=institutionName]').val().trim()==""){
  			alert("기관명을 입력하시오");
  			$('input[name=institutionName]').focus();
  	}else if($('input[name=projectStartDate]').val().trim()==""){
  			alert("시작일을 입력하시오");
  			$('input[name=projectStartDate]').focus();
  	}else if($('input[name=projectEndDate]').val().trim()==""){
  			alert("종료일을 입력하시오");
  			$('input[name=projectEndDate]').focus();
  	}else if($('input[name=leaderId]').val().trim()==""){
  	  		alert("팀장을 선택하시오");
  	  		$('input[name=leaderId]').focus();
  	}else{
		$('#mes').val("프로젝트 생성 완료");
		frm.action="/project/insertProject.do";
		frm.submit();
	}
}
$(function(){
	$.datepicker.setDefaults({
		dateFormat: 'yymmdd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames:['일','월','화','수','목','금','토'],
		dayNamesShort:['일','월','화','수','목','금','토'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		showOtherMonths:true,
		selectOtherMonths:true,
		
	});
	$("#start").datepicker({
		showAnimation:'slide',
	});
	$("#end").datepicker({
		showAnimation:'slide',
	});
});
/* 	function nocheck(){
  		if(event){
  			event.returnValue=false;
  	} */

function searchMember(pIndex){
	$('input[name=selectPage]').val(pIndex);
	var frm =$("#projectForm").serialize();/* document.getElementById('projectDetailForm'); */

 	$.ajax({
		type:"POST",
		url:"/project/createProjectModal.do",
		data: frm,
		success: function(data){
			/* location.reload(); */
			$("#choiceLeaderId").empty();
			$("#choiceLeaderId").append(data);	
		}
	}); 
}
function go_main(){
	var frm = $('#projectForm')[0];
	frm.action="/project/main.do";
	frm.submit();
}
</script>
</head>
<body class="bg-dark">
<form name="projectForm" id="projectForm" method="post" enctype="multipart/form-data">
  <div class="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header">프로젝트 생성</div>
      <div class="card-body">
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label>*프로젝트명</label>
                <input type="hidden" id="mes" name="mes"/>
                <div class="input-group-btn">
                <input name="projectName" class="form-control" type="text" maxlength="30">
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*기관명</label>
                <div class="input-group-btn">
                <input name="institutionName" class="form-control" type="text" maxlength="30" >
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*시작일</label>
                <div class="input-group-btn">
                <input id="start" name="projectStartDate" class="form-control" placeholder="시작일 선택" type="text" readOnly/>
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*종료일</label>
                <div class="input-group-btn">
                <input id="end" name="projectEndDate" class="form-control" placeholder="종료일 선택" type="text" readOnly/>
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*상태</label>
                <div class="input-group-btn">
                <select class="form-control" name="projectState">
					<option value="1" ${params.projectState eq "1" ? "selected" : ""}>평소</option>
					<option value="2" ${params.projectState eq "2" ? "selected" : ""}>긴급</option>
					<option value="3" ${params.projectState eq "3" ? "selected" : ""}>매우긴급</option>
				</select> 
				</div>
              </div>
            </div>
            <c:if test="${params.adminYn=='Y'}">
            <div class="form-row">
              <div class="col-md-6">
                <label>*팀장 지정</label>
                 <input name="leaderName" data-toggle="modal" data-target="#choiceLeader" onclick="searchMember()" class="form-control" placeholder="팀장 선택" type="text" readOnly/>
                 <input type="hidden" name="leaderId" id="leaderId"/>
                </div>
            </div>
            </c:if>
            <div class="form-row">
              <div class="col-md-6">
                <label>프로젝트 사진 등록</label>
                <input type="file" class="label" name="projectImage" accept=".gif, .jpg, .png"/>
                </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>내용</label>
                </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <textarea  name="projectContent" class="col-md-12"  maxlength="1000" rows="5"></textarea>
 				</div>
            </div>
			<button name="insert1" type="button" class="btn btn-primary btn-block" onclick="insertProject()" >
         	 프로젝트생성
            </button>
        <div class="text-center">
          <button class="btn btn-default btn-block" type="button" onclick="go_main()">뒤로</button>
        </div>									
      </div>
    </div>
  </div>
  
<!-- 팀장선택 modal -->
<div class="modal fade" id="choiceLeader">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h4 class="modal-title">팀장 지정</h4>
        <button type="button" class="close" data-dismiss="modal"><span>x</span></button>
      </div>
      <div class="modal-body">
		<div id="choiceLeaderId">

   		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 팀장선택 modal -->


  </form>
</body>
</html>

