<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	$('form').submit(function() {return false;});	
});
function searchWork2(pIndex){

	$('input[name=selectPage]').val(pIndex);
	
	var frm =$("#projectDetailForm").serialize();
	$.ajax({
		type:"POST",
		url:"/project/checkListPage.do",
		data: frm,
		success: function(data){
			/* location.reload(); */

			$("#checklist").empty();
			$("#checklist").append(data);	
		}
	}); 
}
function searchkeyCode2(){
	if(window.event.keyCode==13){
		searchWork2();
	}
}
function allclick2(){
		$('input:checkbox[name=checkbox2]').not(":disabled").prop("checked",$('input:checkbox[name=allcheckbox2]').is(":checked"));
}
function go_multidel2(){
	$('#mes').val("삭제 완료");
	var frm =document.getElementById('projectDetailForm');
		if($('input:checkbox[name=checkbox2]:checked').length>0){
 	  		var retVal = confirm("정말로 삭제 하시겠습니까?");
 	  		if(retVal){
 	  			frm.action="/project/workMultiDelete.do";
 	  			frm.submit();
 	  		}
		}else{
 			alert("삭제할 업무를 하나 이상 선택하십시오.");
 		}
}
function medo(workNo){
	$('#workNo').val(workNo);
	$('#mes').val("Do it");
	var frm =document.getElementById('projectDetailForm');
	frm.action="/project/medo.do";
	frm.submit();
}

function mutiDo(){

	$('#mes').val("내가 하기");
	var frm =document.getElementById('projectDetailForm');
		if($('input:checkbox[name=checkbox2]:checked').length>0){
 	  			frm.action="/project/mutiDo.do";
 	  			frm.submit();
		}else{
 			alert("하고 싶은 업무를 하나 이상 선택하십시오.");
 		}
}
 function giveWork(){
/* 	var checkboxValue=[];
	$("input[name='checkbox2']:checked").each(function(i){
		checkboxValue.push($(this).val());
	});
	$("#checkArray").val(checkboxValue); */
	$("#workNo").val(workNo);
 	if($('input:checkbox[name=checkbox2]:checked').length>0){
 		$("#giveWork").modal("show");
	 	var frm =$("#projectDetailForm").serialize();
		 	$.ajax({
		 		type:"POST",
		 		url:"/project/giveWork.do",
		 		data: frm,
		 		success: function(data){
		 		 	$("#giveWorkId").empty();
		 		 	$("#giveWorkId").append(data);
		 		},	
		 	});
 	}
 	else{
		alert("업무를 주기 위해서는 1개 이상의 업무를 선택해야합니다.");
	}	
} 
</script>
            <div class="row col-sm-12 col-md-12">
                <div class="input-group-btn">
           		<span class="input-group-btn"> 
				<select class="form-control" name="searchOption1">
						<option value="1" ${params.searchOption1 eq "1" ? "selected" : ""}>업무번호</option>
						<option value="2" ${params.searchOption1 eq "2" ? "selected" : ""}>업무명</option>
				</select> 
				<select class="form-control" name="searchOption2">
						<option value="0" ${params.searchOption2 eq "0" ? "selected" : ""}>진행상태</option>
						<option value="1" ${params.searchOption2 eq "1" ? "selected" : ""}>신규</option>
						<option value="2" ${params.searchOption2 eq "2" ? "selected" : ""}>진행완료</option>
				</select> 
                <input name="searchkeyword2" id="searchkeyword2" class="form-control" type="text" maxlength="30" placeholder="" value="${params.searchkeyword2}" onkeypress="searchkeyCode2()"/>
                <button class="btn btn-primary" type="button" onclick="searchWork2()"><i class="fa fa-search"></i></button>
                </span>
				</div>	
              </div>
            
            <div class="form-row">
              <div class="col-md-12">
                <table class="table table-bordered dataTable" id="dataTable" role="grid" width="100%" cellspacing="0">
                	<thead>
                		<tr class="text-center">
                			<th width="20"><input type="checkbox" name="allcheckbox2" onclick="allclick2()"/></th>
                			<th width="40">순번</th>
                			<th>업무번호</th>
                			<th>업무명</th>
                			<th width="300">기간</th>
                			<th>진행상태</th>
                			<th>작성자</th>
                			<c:choose>
                			<c:when test="${params.adminYn=='Y' || joinMemberCheck.userId==null}"><!-- 관리자가 보이게끔 설정해놓음 나중에 사용자한테는 Y로 해서 사용자가 보이도록  -->
							</c:when>
							<c:otherwise>
							<th>하기</th>
							</c:otherwise>
							</c:choose>
                		</tr>
                	</thead>
                	<tbody>
                	<c:if test="${selectCheckListAllCnt>0}">
                	<c:forEach var="selectCheckListAll" items="${selectCheckListAll}" varStatus="status">
                		<tr>
                			<td><input type="checkbox" name="checkbox2" value="${selectCheckListAll.workNo}" /></td>
							<td>${params.currentpageDB=params.currentpageDB+1}</td>
							<td><a href="#" data-toggle="modal" data-target="#updateCheckListModal" onclick="updateCheckListModalView(${selectCheckListAll.workNo})" >${selectCheckListAll.workNum}</a></td>
							<td>${selectCheckListAll.workSubject}</td>
							<td>${selectCheckListAll.startDate} ~ ${selectCheckListAll.endDate}</td>
							<td>${selectCheckListAll.state}</td>
							<td>${selectCheckListAll.updateUserName}</td>
							<c:choose>
								<c:when test="${joinMemberCheck.userId!=null || joinMemberCheck.leaderYn=='Y'|| params.adminYn=='Y'}">
									<c:choose>
									<c:when test="${params.adminYn=='Y'}">		<!-- 사용자는 업무진행 X 나중에  Y로 바꾸기 -->
									</c:when>
									<c:when test="${selectCheckListAll.state=='신규'}">
									<td><a href="#" onclick="medo(${selectCheckListAll.workNo})">내가하기</a></td>
									</c:when>
									<c:otherwise>
									<td><a href="#" onclick="medo(${selectCheckListAll.workNo})">다시하기</a></td>
									</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
                		</tr>
                	</c:forEach>
                	</c:if>
                	<c:if test="${selectCheckListAllCnt<=0}">
                	<td colspan="8" style="text-align:center">검색한 결과가 없습니다.</td>
                	</c:if>
             		</tbody>
                </table>
				</div>
				</div>
            </div>
       <div class="row">    
      <!-- 페이징 -->
      <c:if test="${selectCheckListAllCnt>0}">
		<div class="col-sm-12 col-md-7">
		<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
		<ul class="pagination">
			<c:if test="${params.selectPage-1!=0}">
			<li class="paginate_button page-item prvious disable"><button name="prv" class="page-link" onclick="searchWork2(${params.selectPage - 1})">이전</button></li>
				</c:if>
			<c:forEach var="pIndex" begin="${params.startpage}" end="${params.endpageNo}" step="1">
				<c:choose>
					<c:when test="${params.currentpage eq pIndex}">
						<li id="pagingNumbering" class="paginate_button page-item active"><a class="page-link" href="#" onclick="searchWork2(${pIndex})">${pIndex}</a></li>
					</c:when>
					<c:otherwise>
						<li id="pagingNumbering" class="paginate_button page-item"><a class="page-link" href="#" onclick="searchWork2(${pIndex})">${pIndex}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${params.endpage != params.currentpage}">
				<li class="paginate_button page-item next"><button name="next" class="page-link" onclick="searchWork2(${params.selectPage +1})">다음</button></li>
			</c:if>
		
		<input type="hidden" name="joinId" value="${joinMemberCheck.userId}"/>
		<input type="hidden" name="selectPage" value="${params.selectPage}"/>
		<input type="hidden" name="underPaging" value=""/>
		<input type="hidden" name="startpage" value="${params.startpage}"/>
		<input type="hidden" name="endpageNo" value="${params.endpageNo}"/>
		<input type="hidden" name="projectNo" value="${projectdetail.projectNo}"/>
		</ul>
		</div>
		</div>
		</c:if>
		<div class="col-sm-12">
			<c:if test="${joinMemberCheck.userId!=null || joinMemberCheck.leaderYn=='Y'|| params.adminYn=='Y'}">
				<c:if test="${params.adminYn=='N'}">
					<button class="btn btn-primary" type="button" onclick="mutiDo()">내가하기</button>
				</c:if>
				<c:if test="${joinMemberCheck.leaderYn=='Y' || params.adminYn=='Y'}">
					<button class="btn btn-primary" type="button" onclick="giveWork()">업무부여</button>
				</c:if>
				<button class="btn btn-danger" type="button" onclick="go_multidel2()">삭제</button>
			</c:if>
		</div>
		</div>
		<input type="hidden" name="workNo" id="workNo"/>
<!-- 		<input type="hidden" name="checkArray" id="checkArray"/> -->