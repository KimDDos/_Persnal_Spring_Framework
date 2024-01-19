<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1> Board Register Page </h1>
	<hr>
	<br>
	<sec:authentication property="principal.mvo.email" var="authEmail"/>
	<sec:authentication property="principal.mvo.nickName" var="authNick"/>
	<form action="/board/register" method="post">
		<div class="mb-3">
		  <label for="title" class="form-label">Title</label>
		  <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해주세요.">
		</div>
		<div class="mb-3">
		  <label for="writer" class="form-label">writer</label>
		  <input type="text" class="form-control" name="writer" id="writer" value="${authEmail}" readonly>
		</div>
		<div class="mb-3">
		  <label for="content" class="form-label">Example textarea</label>
		  <textarea class="form-control" name="content" id="content" rows="3">내용을 입력해주세요.</textarea>
		</div>
		<button type="submit" class="btn btn-dark">작성</button>
	</form>

</div>

<jsp:include page="../layout/Footer.jsp"></jsp:include>