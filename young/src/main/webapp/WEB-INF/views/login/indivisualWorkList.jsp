<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
function searchWork1(pIndex){
	$('input[name=selectPage]').val(pIndex);
	
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
}

function allclick(){
	$('input:checkbox[name=checkbox]').not(":disabled").prop("checked",$('input:checkbox[name=allcheckbox]').is(":checked"));
}
function go_multicancel(){
	$('#mes').val("취소 완료");
	var frm =document.getElementById('userindivisualForm');
		if($('input:checkbox[name=checkbox]:checked').length>0){
 	  		var retVal = confirm("정말로 취소 하시겠습니까?");
 	  		if(retVal){
 	  			frm.action="/project/userWorkMultiCancel.do";
 	  			frm.submit();
 	  		}
		}else{
 			alert("삭제할 업무를 하나 이상 선택하십시오.");
 		}
}
function go_multicomplete(){
	$('#mes').val("업무 완료");

	var frm =document.getElementById('userindivisualForm');
		if($('input:checkbox[name=checkbox]:checked').length>0){
 	  		var retVal = confirm("정말로 완료 하시겠습니까?");
 	  		if(retVal){
 	  			frm.action="/project/userWorkMultiComplete.do";
 	  			frm.submit();
 	  		}
		}else{
 			alert("완료할 업무를 하나 이상 선택하십시오.");
 		}
}
function workCancel(workNo,projectNo){
	$('#mes').val("취소 완료");
	$('#workNo').val(workNo);
	$('#projectNo').val(projectNo);
	var frm=document.getElementById('userindivisualForm');
 		var retVal = confirm("정말로 취소 하시겠습니까?");
 		if(retVal){
 			frm.action="/project/cancelUserWorkList.do";
 			frm.submit();
 		}
}
function workComplete(workNo,projectNo){
	$('#mes').val("업무 완료");
	$('#workNo').val(workNo);
	$('#projectNo').val(projectNo);
	var frm=document.getElementById('userindivisualForm');
	var retVal = confirm("정말로 완료 하시겠습니까?");
		if(retVal){
		 	frm.action="/project/completeUserWorkList.do";
		 	frm.submit();
		}
}

function updateUserWorkListModalView(workNo,projectNo){
	$("#workNo").val(workNo);
	$("#projectNo").val(projectNo);
 	var frm =$("#userindivisualForm").serialize();/* document.getElementById('projectDetailForm'); */
 	$.ajax({
 		type:"POST",
 		url:"/project/updateUserWorkListModalView.do",
 		data: frm,
 		success: function(data){
 		 	$("#updateWorkListModalId").empty();
 		 	$("#updateWorkListModalId").append(data);
 		}
 	});
}

</script>
<div>
<div class="row">
<div class="col-md-6">
	<div class="input-group-btn">
		<span class="input-group-btn"> 
		<select class="form-control" name="searchOption1">
				<option value="1"
					${params.searchOption1 eq "1" ? "selected" : ""}>업무번호</option>
				<option value="2"
					${params.searchOption1 eq "2" ? "selected" : ""}>업무명</option>
				<option value="3"
					${params.searchOption1 eq "3" ? "selected" : ""}>프로젝트명</option>
		</select> 
		<input name="searchkeyword1" class="form-control" type="text" maxlength="30" placeholder="" value="${params.searchkeyword1}" onkeypress="if(event.keyCode==13){searchWork1();}" />
			<button class="btn btn-primary" type="button" onclick="searchWork1()">검색</button>
		</span>
	</div>
</div>
</div>
<div class="row">
<div class="col-md-12">
<table class="table table-bordered dataTable" id="dataTable" role="grid" width="100%" cellspacing="0">
	<thead>
		<tr class="text-center">
			<th width="20">
			<c:choose>
			<c:when test="${selectMemberinfo.userId==params.userId || params.adminYn=='Y'}">
				<input type="checkbox" name="allcheckbox" onclick="allclick();" />
			</c:when>
			<c:otherwise>
				<input type="checkbox" name="checkbox" name="allcheckbox" onclick="allclick();" disabled="true">
			</c:otherwise>
			</c:choose>
			</th>
			<th width="40">순번</th>
			<th>프로젝트명</th>
			<th>업무번호</th>
			<th>업무명</th>
			<th width="300">기간</th>
			<th>진행자</th>
			<th>진행상태</th>
			<c:choose>
				<c:when test="${selectMemberinfo.userId==params.userId || params.adminYn=='Y'}">
					<th>취소</th>
					<th>완료</th>
				</c:when>
			</c:choose>
		</tr>
	</thead>
	<tbody>
	<c:if test="${userWorkListCnt>0}">
		<c:forEach var="userWorkList" items="${userWorkList}" varStatus="status">
			<tr>
				<c:choose>
					<c:when test="${params.adminYn=='Y'}">
						<td><input type="checkbox" name="checkbox" value="${userWorkList.workNo}"></td>
					</c:when>
					<c:when test="${params.adminYn=='N' && params.userId==userWorkList.userId}">
						<td><input type="checkbox" name="checkbox" value="${userWorkList.workNo}"></td>
					</c:when>
					<c:otherwise>
						<td><input type="checkbox" name="checkbox" value="${userWorkList.workNo}" disabled="true"></td>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="pN" value="${userWorkList.projectNo}"/>
				<td>${params.currentpageDB=params.currentpageDB+1}</td>
				<td>${userWorkList.projectName}</td>
				<input type="hidden" name="projectName" value="${userWorkList.projectName}"/>
				<td><a href="#" data-toggle="modal" data-target="#updateWorkListModal" onclick="updateUserWorkListModalView(${userWorkList.workNo},${userWorkList.projectNo})">${userWorkList.workNum}</a></td>
				<td>${userWorkList.workSubject}</td>
				<td>${userWorkList.startDate}~ ${userWorkList.endDate}</td>
				<td>${userWorkList.userName}</td>
				<td>${userWorkList.state}</td>
				<c:choose>
					<c:when
						test="${userWorkList.userId==params.userId || params.adminYn=='Y'}">
						<c:choose>
							<c:when
								test="${params.adminYn=='Y'}">
								<td><a href="#checklist"
									onclick="workCancel(${userWorkList.workNo},${userWorkList.projectNo})">취소하기</a></td>
								<td><a href="#checklist"
									onclick="workComplete(${userWorkList.workNo},${userWorkList.projectNo})">완료하기</a></td>
							</c:when>
							<c:when
								test="${params.adminYn=='N' && params.userId==userWorkList.userId}">
								<td><a href="#checklist"
									onclick="workCancel(${userWorkList.workNo},${userWorkList.projectNo})">취소하기</a></td>
								<td><a href="#checklist"
									onclick="workComplete(${userWorkList.workNo},${userWorkList.projectNo})">완료하기</a></td>
							</c:when>
						</c:choose>
					</c:when>
				</c:choose>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${userWorkListCnt<=0}">
			<td colspan="10" style="text-align:center">검색한 결과가 없습니다.</td>
		</c:if>
	</tbody>
</table>
</div>
</div>

<div class="row">
<c:if test="${userWorkListCnt>0}">
<div class="col-sm-12 col-md-12">
	<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
		<ul class="pagination">
			<c:if test="${params.selectPage-1!=0}">
				<li class="paginate_button page-item prvious disable"><button
						name="prv" class="page-link"
						onclick="searchWork1(${params.selectPage - 1})">이전</button></li>
			</c:if>
			<c:forEach var="pIndex" begin="${params.startpage}"
				end="${params.endpageNo}" step="1">
				<c:choose>
					<c:when test="${params.currentpage eq pIndex}">
						<li id="pagingNumbering"
							class="paginate_button page-item active"><a
							class="page-link" href="#worklist"
							onclick="searchWork1(${pIndex})">${pIndex}</a></li>
					</c:when>
					<c:otherwise>
						<li id="pagingNumbering" class="paginate_button page-item"><a
							class="page-link" href="#worklist"
							onclick="searchWork1(${pIndex})">${pIndex}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${params.endpage != params.currentpage}">
				<li class="paginate_button page-item next"><button
						name="next" class="page-link"
						onclick="searchWork1(${params.selectPage +1})">다음</button></li>
			</c:if>
			<input type="hidden" name="joinId" value="" />
			<input type="hidden" name="selectPage" value="${params.selectPage}" />
			<input type="hidden" name="underPaging" value="" />
			<input type="hidden" name="startpage" value="${params.startpage}" />
			<input type="hidden" name="endpageNo" value="${params.endpageNo}" />
		</ul>
	</div>
</div>
</c:if>
<div class="col-sm-12 col-md-12">
	<c:if test="${selectMemberinfo.userId==params.userId || params.adminYn=='Y'}">
		<button class="btn btn-primary" type="button" onclick="go_multicomplete()">완료</button>
		<button class="btn btn-danger" type="button" onclick="go_multicancel()">취소</button>
	</c:if>
</div>
</div>
</div>
</div>

<!-- updateWorkListModal -->
<div class="modal fade" id="updateWorkListModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div id="header" class="modal-header">
      	<h4 class="modal-title">업무 수정</h4>
        <button type="button" class="close" data-dismiss="modal" ><span>x</span></button>
      </div>
      <div class="modal-body">
        <div id="updateWorkListModalId">
      
		</div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" >닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- updateWorkListModal -->
<input type="hidden" name="workNo" id="workNo" />
<input type="hidden" name="projectNo" id="projectNo" />
