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
	<c:if test="${not empty msg}">
		alert("${msg}");
	</c:if>
	
});

function add() {
	location.href="<c:url value='/mgmt.do'/>";
}
function view(idx) {
	
	location.href="<c:url value='/view.do'/>?idx="+idx;
}
function setPwd(user_id) {
	if( user_id == "admin"){
		$('#password').val('manager');
	}
	else if( user_id == "guest"){
		$('#password').val('guest');
	}
	else {
		$('#password').val('guest2');
	
	}

}
function check() {
	if( $('#user_id').val() == ''){
		alert("아이디를 입력하세요");
		return false;
	}
	if( $('#password').val() == ''){
		alert("패스워드를 입력하세요");
		return false;
	}
	return true;
}
function out() {
	location.href="<c:url value='/logout.do'/>";
}

</script>
</head>
<body>
<div class="container">
<h1>메인화면</h1>
<div class="panel panel-default">
  <div class="panel-heading">
  
  	<c:if test="${sessionScope.userId == null || sessionScope.userId == '' }">
  
		<form class="form-inline" method="post" action="<c:url value='/login.do'/>">
		  <div class="form-group">
		    <label for="user_id">ID:</label>
			  <select class="form-control" id="user_id" name="user_id" onchange="setPwd(this.value);">
			    <option value="">사용자를 선택하세요</option>
			    <option value="admin">admin</option>
			    <option value="guest">사용자</option>
			    <option value="guest2">사용자2</option>
			  </select>	    
		    
		  </div>
		  <div class="form-group">
		    <label for="password">Password:</label>
		    <input type="password" class="form-control" id="password" name="password">
		  </div>
		  <button type="submit" class="btn btn-default" onclick="return check()">login</button>
		</form>  

  
   	</c:if>

   	<c:if test="${sessionScope.userId != null && sessionScope.userId != '' }">
   		${sessionScope.userName}님 환영합니다.
   		
   		<button type="button" class="btn btn-default" onclick="out()">로그아웃</button>
   	</c:if>

  
  </div>
  <div class="panel-body">


	<form class="form-inline" method="post" action="<c:url value='/list.do'/>">
	  <div class="form-group">
	    <label for="searchKeyword">제목/내용:</label>
	    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword">
	  </div>
	  <button type="submit" class="btn btn-default">검색</button>
	</form>  


	<div class="table-responsive">
	  <table class="table table-hover">
		    <thead>
		      <tr>
		        <th>No.</th>
		        <th>Title</th>
		        <th>Hit</th>
		        <th>Created By</th>
		        <th>Created On</th>
		      </tr>
		    </thead>
		    <tbody>
		    	<c:forEach var="result" items="${resultList}" varStatus="status">
		    
			      <tr>
			        <td><a href="javascript:view(${result.idx});"><c:out value="${result.idx}"/>&nbsp;</td>
			        <td><a href="javascript:view(${result.idx});"><c:out value="${result.title}"/>&nbsp;</a></td>
			        <td><c:out value="${result.count}"/>&nbsp;</td>
			        <td><c:out value="${result.writerNm}"/>&nbsp;</td>
			        <td><c:out value="${result.indate}"/>&nbsp;</td>
			      </tr>

				</c:forEach>



		    </tbody>
	  </table>
	</div>


  </div>
  <div class="panel-footer">

	<c:if test="${!empty sessionScope.userId}">
		<button type="button" class="btn btn-default" onclick="add()">등록</button>
    </c:if>
  </div>
</div>
</div>
</body>
</html>