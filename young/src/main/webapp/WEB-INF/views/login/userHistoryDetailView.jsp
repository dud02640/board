<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function goProject(){
	var frm = document.getElementById('userindivisualForm');
	frm.action="/project/projectDetailView.do";
	frm.submit();
}
/* function openMemo(){
	var div = document.createElement('div');
	div.innerHTML=document.getElementById('memoDiv').innerHTML;
	document.getElementById('memofield').appendChild(div);
}
function removeMemo(obj){
	document.getElementById('memofield').removeChild(obj);
} */
</script>
<!--  -->   

          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label>프로젝트명 : ${params.projectName}</label>
               </div>
              </div>
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label>*업무번호</label>
                <div class="input-group-btn">
                <input name="workNum" class="form-control" type="text" maxlength="30" value="${updateWorkListModalView.workNum}" readOnly />
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*업무명</label>
                <div class="input-group-btn">
                <input name="workSubject" class="form-control" type="text" maxlength="30" value="${updateWorkListModalView.workSubject}" readOnly/>
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-12">
                <label>*업무 세부내용</label>
                <div class="input-group-btn">
                <textarea name="workContent" class="form-control" maxlength="1000" readOnly>${updateWorkListModalView.workContent}</textarea>
				</div>
              </div>
            </div>
            <div class="form-row">
              <div class="col-md-6">
                <label>*시작일</label>
                <div class="input-group-btn">
                <input name="startDate" id="startDate" class="form-control" type="text" value="${updateWorkListModalView.startDate}"  readOnly/>
				</div>
              </div>
            </div>
             <div class="form-row">
              <div class="col-md-6">
                <label>*종료일</label>
                <div class="input-group-btn">
                <input name="endDate" id="endDate" class="form-control" type="text" value="${updateWorkListModalView.endDate}" readOnly/>
				</div>
              </div>
            </div>
            
<!-- 			<div class="form-row" style="display:none">
              <div class="col-md-6">
                <label>*메모</label>
                <div id="memoDiv" class="input-group-btn">
                	<input type="text" class="form-control">
                	<button type="button" class="btn btn-default" onclick="">입력완료</button>
                	<button type="button" class="btn btn-default" onclick="removeMemo(this)">삭제</button>
				</div>
              </div>
            </div> 
            <div id="memofield">
            </div> -->
      </div>
	  
	  <input type="hidden" name="adminYn" value="${params.adminYn}"/>
	  <input type="hidden" name="ckuserId" value="${selectMemberinfo.userId}"/>
	  <input type="hidden" id="userId" name="userId" value="${params.userId}"/>