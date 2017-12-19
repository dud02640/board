<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

function updatecheckListModalId(){
	$('#mes').val("업무 수정 성공");
	var frm = document.getElementById('projectDetailForm');/* document.getElementById('projectDetailForm'); */

 		if(parseInt($("#startDate").val())>parseInt($("#endDate").val())){
				alert("시작일과 종료일을 확인하세요.");
				$("#startDate").focus();
			}else if($('input[name=workNum]').val().trim()==""){
					alert("업무번호을 입력하시오");
					$('input[name=workNum]').focus();
			}else if($('input[name=workSubject]').val().trim()==""){
					alert("업무명을 입력하시오");
					$('input[name=workSubject]').focus();
			}else if($('textarea[name=workContent]').val().trim()==""){
					alert("업무내용을 입력하시오");
					$('textarea[name=workContent]').focus();
			}else if($('input[name=startDate]').val().trim()==""){
					alert("시작일을 입력하시오");
					$('input[name=startDate]').focus();
			}else if($('input[name=endDate]').val().trim()==""){
					alert("종료일을 입력하시오");
					$('input[name=endDate]').focus();
			}else{	 
				frm.action="/project/updateCheckList.do";
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
 	if($('input[name=ckuserId]').val()!="" || $('input[name=leaderYn]').val()=='Y' || $('input[name=adminYn]').val()=='Y'){ 
		$("#endDate").datepicker({
			showAnimation:'slide',
		});
		$("#startDate").datepicker({
			showAnimation:'slide',
		});

		
	} 
	

});
function medo(workNo){
	$('#workNo').val(workNo);
	$('#mes').val("Do it");
	var frm =document.getElementById('projectDetailForm');
	frm.action="/project/medo.do";
	frm.submit();
}
function deletecheckListModalId(){
	$('#mes').val("삭제 완료");
	var frm =document.getElementById('projectDetailForm');
 	  		var retVal = confirm("정말로 삭제 하시겠습니까?");
 	  		if(retVal){
 	  			frm.action="/project/deletecheckListModalId.do";
 	  			frm.submit();
 	  		}
}
</script>
<!--  -->   
<div class="checkListClass"> 
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label>*업무번호</label>
                <div class="input-group-btn">
                <input name="workNum" class="form-control" type="text" maxlength="30" value="${updateListModalPage.workNum}" />
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*업무명</label>
                <div class="input-group-btn">
                <input name="workSubject" class="form-control" type="text" maxlength="30" value="${updateListModalPage.workSubject}" />
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*업무 세부내용</label>
                <div class="input-group-btn">
                <textarea name="workContent" class="form-control" maxlength="1000" rows="5">${updateListModalPage.workContent}</textarea>
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*시작일</label>
                <div class="input-group-btn">
                <input name="startDate" id="startDate" class="form-control" placeholder="시작일 선택" type="text" value="${updateListModalPage.startDate}"  readOnly/>
				</div>
              </div>
            </div>
             <div class="form-row">
              <div class="col-md-6">
                <label>*종료일</label>
                <div class="input-group-btn">
                <input name="endDate" id="endDate" class="form-control" placeholder="종료일 선택" type="text" value="${updateListModalPage.endDate}" readOnly/>
				</div>
              </div>
            </div>
      </div>
      <c:if test="${joinMemberCheck.userId!=null || joinMemberCheck.leaderYn=='Y'|| params.adminYn=='Y'}">
      <button type="button" class="btn btn-primary" onclick="updatecheckListModalId()">수정</button>
      <button type="button" class="btn btn-danger" onclick="deletecheckListModalId()">삭제</button>
      <c:if test="${params.adminYn=='N'}">
	  	<button class="btn btn-primary" type="button" onclick="medo(${updateListModalPage.workNo})">내가하기</button>
	  </c:if>
	  </c:if>
</div>   
	  <input type="hidden" name="adminYn" value="${params.adminYn}"/>
	  <input type="hidden" name="leaderYn" value="${joinMemberCheck.leaderYn}"/>
	  <input type="hidden" name="ckuserId" value="${joinMemberCheck.userId}"/>
