<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
	pageContext.setAttribute("br", "<br/>"); //<br/>
%>

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
	  $("#writerNm").attr("readOnly", true);
	  $("#indate").attr("readOnly", true);
	
});
function list() {
	location.href="<c:url value='/list.do'/>";
}
function add() {
	
	if ($("#reply").val() == '') {
		alert("댓글을 입력하세요.")
		$("#reply").focus();
		return;
	}

	if (!confirm("댓글을 저장하시겠습니까?")) {
		return;
	}
	
	document.form2.action="<c:url value='/reply.do'/>";
	document.form2.submit();

}
function mod() {
	
	location.href="<c:url value='/mgmt.do'/>?idx=+${boardVO.idx}";
}
function del() {
	if (!confirm("삭제하시겠습니까?")) {
		return;
	}
	
	document.form1.action="<c:url value='/mgmt.do'/>?idx=+${boardVO.idx}&mode=del";
	document.form1.submit();
	
}

</script>
</head>
<body>
<div class="container">
<h1>상세화면</h1>
<div class="panel panel-default">
  <div class="panel-heading">
	<label for="">${sessionScope.userName}님 안녕하세요</label> 
  </div>
  <div class="panel-body">

	<form id="form1" name="form1" class="form-horizontal" method="post" action="">
	  <div class="form-group">
	    <label class="control-label col-sm-2" for="idx">게시물ID:</label>
	    <div class="col-sm-10">
	      <c:out value="${boardVO.idx}"/>
	    </div>
	  </div>

	  <div class="form-group">
	    <label class="control-label col-sm-2" for="title">제목:</label>
	    <div class="col-sm-10"> 
	      <c:out value="${boardVO.title}"/>
	    </div>
	  </div>
 
	  <div class="form-group">
	    <label class="control-label col-sm-2" for="contents">내용:</label>
	    <div class="col-sm-10"> 
	      <c:out value="${fn:replace(boardVO.contents, crcn, br)}" escapeXml="false"/>
	    </div>
	  </div>

	  <div class="form-group">
	    <label class="control-label col-sm-2" for="writer">등록일:</label>
	    <div class="col-sm-10"> 
	      <c:out value="${boardVO.indate}"/>
	    </div>
	  </div>

	  <div class="form-group">
	    <label class="control-label col-sm-2" for="writer">등록자:</label>
	    <div class="col-sm-10"> 
	      <c:out value="${boardVO.writerNm}"/>
	    </div>
	  </div>
	  
	</form>

  </div>
  <div class="panel-footer">
	<c:if test="${!empty sessionScope.userId && sessionScope.userId == boardVO.writer}">
		<button type="button" class="btn btn-default" onclick="mod();">수정</button>
		<button type="button" class="btn btn-default" onclick="del();">삭제</button>
	</c:if>
	<button type="button" class="btn btn-default" onclick="list();">목록</button>
  
  </div>
</div>
<div class="well well-sm">작성자/댓글</div>
<div class="well well-lg">
		<form id="form2" name="form2" class="form-horizontal" method="post" action="">
			<div class="form-group">
			    <label class="control-label col-sm-2" for="writer">등록자:</label>
			    <div class="col-sm-10"> 
			      <input type="hidden" class="form-control" id="writer" name="writer" maxlength="15" style="float:left;width:50%" value="${sessionScope.userId}">
			      <input type="text" class="form-control" id="writerNm" name="writerNm" placeholder="Enter Writer" maxlength="15" style="float:left;width:50%" value="${sessionScope.userName}">
			    </div>	
		    </div>
	    
			  <div class="form-group">
			    <label class="control-label col-sm-2" for="reply">댓글:</label>
			    <div class="col-sm-10"> 
			      <textarea class="form-control" rows="3" id="reply" name="reply" maxlength="300"></textarea>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    	<label class="control-label col-sm-2" for=""></label>
			    	<div class="col-sm-10" align="left">
		          		<button type="button" class="btn btn-default" onclick="add();">작성</button>
		          		&nbsp&nbsp;(댓글은 수정이나 삭제가 안됩니다.)
	          		
				 	</div>
			  </div>
		</form>
</div>

</div>
</body>
</html>