<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1>Member Login Page</h1>
	<hr>
	<br>
	<form action="/member/login" method="post">
		<div class="mb-3">
			<label for="email" class="form-label">E-Mail</label> 
			<input type="text" class="form-control" name="email" id="email" placeholder="E-mail을 입력해주세요.">
		</div>
		<div class="mb-3">
			<label for="pwd" class="form-label">Password</label> 
			<input type="password" class="form-control" name="pwd" id="pwd" placeholder="Password 를 입력해주세요">
		</div>
		<button type="submit" class="btn btn-dark">Login</button>
	</form>
	<br>
	<div>
		<p class="forgot-pass">Forgot password?</p>
		<a href="/member/register"><button type="button" class="btn btn-dark">Sign In</button></a>
	</div>
</div>

<c:if test="${ not empty param.errMsg }">
	<div class="mb-3">
		<c:choose>
			<c:when test="${errMsg eq 'Bad credentials'}">
				<c:set value="이메일 또는 비밀번호가 일치하지 않습니다." var="errText"></c:set>
			</c:when>
			<c:otherwise>
				<c:set value="관리자에게 문의해주세요." var="errText"></c:set>
			</c:otherwise>
		</c:choose>
		${errText }
	</div>
</c:if>

<jsp:include page="../layout/Footer.jsp"></jsp:include>