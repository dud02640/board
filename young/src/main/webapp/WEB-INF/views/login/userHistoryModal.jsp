<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	  $('form').submit(function() {return false;});
});
function searchWork(pIndex){
	$('input[name=selectPage]').val(pIndex);
	
	var frm =$("#userindivisualForm").serialize();
	$.ajax({
		type:"POST",
		url:"/login/userHistory.do",
		data: frm,
		success: function(data){
			/* location.reload(); */
			$("#userHistoryId").empty();
			$("#userHistoryId").append(data);
		}
	}); 
}
function updateHistory(workNo,projectNo){
	
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
 		 	$("#btn").hide();
 		 	$("#header").hide();
 		 	$("#updateWorkListModalId input").attr("readonly",true);
	 		$("#updateWorkListModalId textarea").attr("readonly",true);
 		}
 	});
}
function userHistoryDetailView(workNo,projectNo,projectName){
	$("#workNo").val(workNo);
	$("#projectNo").val(projectNo);
	$("#projectName").val(projectName);
 	var frm =$("#userindivisualForm").serialize();/* document.getElementById('projectDetailForm'); */
 	$.ajax({
 		type:"POST",
 		url:"/project/userHistoryDetailView.do",
 		data: frm,
 		success: function(data){
 			$("#historybtn").hide();
 		 	$("#userHistoryDetailViewId").empty();
 		 	$("#userHistoryDetailViewId").append(data); 
 		}
 	});
}

</script>
		<div class="col-md-6">
                <div class="input-group-btn">
           		<span class="input-group-btn"> 
				<select class="form-control" name="searchOption" >
						<option value="1" ${params.searchOption eq "1" ? "selected" : ""}>업무번호</option>
						<option value="2" ${params.searchOption eq "2" ? "selected" : ""}>업무명</option>
						<option value="3" ${params.searchOption eq "3" ? "selected" : ""}>프로젝트명</option>
				</select> 
                <input name="searchkeyword" class="form-control" type="text" maxlength="30" style="width: 300px;" value="${params.searchkeyword}" onkeypress="if(event.keyCode==13){searchWork()}"/>
                <button class="btn btn-primary" type="button" onclick="searchWork()">검색</button>
                </span>
				</div>	
       </div>
    <div class="col-md-12">
	<table class="table table-bordered dataTable" id="dataTable" role="grid" width="100%" cellspacing="0">
		<thead>
			<tr class="text-center">
<!-- 			<th><input type="checkbox" name="allcheckbox" onclick="allclick();"/></th> -->
			<th width="35">순번</th>
			<th>프로젝트명</th>
			<th>업무번호</th>
			<th>업무명</th>
			<th width="190">기간</th>
			<th>진행상태</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${userHistoryCnt>0}">
			<c:forEach var="userHistory" items="${userHistory}" varStatus="status">
			<tr>
<%-- 					<c:choose>
						<c:when test="${joinMemberCheck.leaderYn=='Y' || params.adminYn=='Y'}">
							<td><input type="checkbox" name="checkbox" value="${userHistory.workNo}"></td>
						</c:when>
						<c:when test="${params.adminYn=='N' && params.userId==userHistory.userId}">
							<td><input type="checkbox" name="checkbox" value="${userHistory.workNo}"></td>
						</c:when>
						<c:otherwise>
							<td><input type="checkbox" name="checkbox" value="${userHistory.workNo}" disabled="true"></td>
						</c:otherwise>
					</c:choose> --%>
					<td>${params.currentpageDB=params.currentpageDB+1}</td>
					<td>${userHistory.projectName}</td>
					<td><a href="#" data-toggle="modal" data-target="#userHistoryDetailView" onclick="userHistoryDetailView(${userHistory.workNo},${userHistory.projectNo},'${userHistory.projectName}')" data-dismiss="modal">${userHistory.workNum}</a></td>
					<td>${userHistory.workSubject}</td>
					<td>${userHistory.startDate} ~ ${userHistory.endDate}</td>
					<td>${userHistory.state}</td>
			</tr>
			</c:forEach>
			</c:if>
			<c:if test="${userHistoryCnt<=0}">
				<td colspan="6" style="text-align:center">검색한 결과가 없습니다.</td>
			</c:if>
		</tbody>
	</table>
	<div class="row">
	<c:if test="${userHistoryCnt>0}">
	<div class="col-sm-12 col-md-12">
	<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	<ul class="pagination">
		<c:if test="${params.selectPage-1!=0}">
		<li class="paginate_button page-item prvious disable"><button name="prv" class="page-link" onclick="searchWork(${params.selectPage - 1})">이전</button></li>
			</c:if>
		<c:forEach var="pIndex" begin="${params.startpage}" end="${params.endpageNo}" step="1">
			<c:choose>
				<c:when test="${params.currentpage eq pIndex}">
					<li id="pagingNumbering" class="paginate_button page-item active"><a class="page-link" href="#worklist" onclick="searchWork(${pIndex})">${pIndex}</a></li>
				</c:when>
				<c:otherwise>
					<li id="pagingNumbering" class="paginate_button page-item"><a class="page-link" href="#worklist" onclick="searchWork(${pIndex})">${pIndex}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${params.endpage != params.currentpage}">
			<li class="paginate_button page-item next"><button name="next" class="page-link" onclick="searchWork(${params.selectPage +1})">다음</button></li>
		</c:if>
	<input type="hidden" name="joinId" value=""/>
	<input type="hidden" name="selectPage" value="${params.selectPage}"/>
	<input type="hidden" name="underPaging" value=""/>
	<input type="hidden" name="projectName" />
	
	<input type="hidden" name="startpage" value="${params.startpage}"/>
	<input type="hidden" name="endpageNo" value="${params.endpageNo}"/>
	<input type="hidden" name="projectNo" value="${projectdetail.projectNo}"/>
	</ul>
	</div>
	</div>
	</c:if>
	</div>
	</div>
	</div>
