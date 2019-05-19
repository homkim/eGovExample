<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>전자정부프레임워크 with MariaDB</title>
<meta charset="utf-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.4.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/css/bootstrap.min.js'/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
$( document ).ready(function() {
	  $("#idx").attr("readOnly", true);
	  $("#writerNm").attr("readOnly", true);
	  $("#indate").attr("readOnly", true);
	
});

function add() {
	if ($("#title").val() == '') {
		alert("제목을 입력하세요.")
		$("#title").focus();
		return;
	}

	if ($("#contents").val() == '') {
		alert("내용을 입력하세요.")
		$("#contents").focus();
		return;
	}

	if (!confirm("저장하시겠습니까?")) {
		return;
	}
	
	document.form1.action="<c:url value='/mgmt.do'/>?mode=add";
	document.form1.submit();
	
}
function mod() {
	if ($("#title").val() == '') {
		alert("제목을 입력하세요.")
		$("#title").focus();
		return;
	}

	if ($("#contents").val() == '') {
		alert("내용을 입력하세요.")
		$("#contents").focus();
		return;
	}

	if (!confirm("수정하시겠습니까?")) {
		return;
	}
	
	document.form1.action="<c:url value='/mgmt.do'/>?mode=mod";
	document.form1.submit();
	
}
function list() {
	location.href="<c:url value='/list.do'/>";
}

</script>


</head>
<body>
<div class="container">
<h1>등록/수정화면</h1>
<div class="panel panel-default">
  <div class="panel-heading">
	<label for="">등록/수정</label> 
  </div>
  <div class="panel-body">

		<form id="form1" name="form1" class="form-horizontal" method="post" action="">
		  <div class="form-group">
		   <!--  <label class="control-label col-sm-2" for="writer">등록자/등록일:</label> -->
		    <div class="col-sm-10"> 
		      <input type="hidden" class="form-control" id="writer" name="writer" maxlength="15" style="float:left;width:50%" value="${boardVO.writer}">
		      <input type="hidden" class="form-control" id="writerNm" name="writerNm" placeholder="Enter Writer" maxlength="15" style="float:left;width:50%" value="${boardVO.writerNm}">
		      <input type="hidden" class="form-control" id="indate" name="indate" placeholder="Enter Date" maxlength="15"  style="float:left;width:50%" value="${boardVO.indate}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="idx">게시물ID:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="idx" name="idx" placeholder="자동채번" value="${boardVO.idx}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="title">제목:</label>
		    <div class="col-sm-10"> 
		      <input type="text" class="form-control" id="title" name="title" placeholder="Enter Title" maxlength="100" value="${boardVO.title}">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="contents">내용:</label>
		    <div class="col-sm-10"> 
		      <textarea class="form-control" rows="5" id="contents" name="contents" maxlength="1000">${boardVO.contents}</textarea>
		    </div>
		  </div>

		  
		</form>


  </div>
  <div class="panel-footer">
	<c:if test="${!empty sessionScope.userId}">
		<c:if test="${empty boardVO.idx}">
			<button type="button" class="btn btn-default" onclick="add()">등록</button>
		</c:if>
		<c:if test="${!empty boardVO.idx}">
			<button type="button" class="btn btn-default" onclick="mod()">수정</button>
		</c:if>

	</c:if>
	<button type="button" class="btn btn-default" onclick="list()">취소</button>
  
  </div>
</div>
</div>
</body>
</html>