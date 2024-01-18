<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1> Member Register Page </h1>
	<hr>
	<br>
	<form action="/member/register" method="post">
		<div class="mb-3">
			<label for="email" class="form-label">E-Mail</label> 
			<input type="text" class="form-control" name="email" id="email"	placeholder="E-mail을 입력해주세요.">
		</div>
		<div id="emailChekResult">
			<button type="button" class="btn btn-dark EmailBtn" id="isEmailBtn">이메일 중복 확인</button>
				<!-- 성공하면 success disable / 실패하면 danger로 -->
			<span id="emailcheckResultText"> 
				<!-- boolean으로 된다 안된다 체크 출력 -->
				<!-- <span class="badge text-bg-danger">Danger</span> / <span class="badge text-bg-success">Success</span> -->
			</span>
		</div>
		<br>
		<br>
		<div class="mb-3">
			<label for="pwdcheck" class="form-label">Password</label> 
			<input type="text" class="form-control" id="pwdcheck" placeholder="Password 를 입력해주세요">
		</div>
		<div class="mb-3">
			<label for="pwd" class="form-label">Password 확인</label> 
			<input type="text" class="form-control" name="pwd" id="pwd"	placeholder="Password 를 입력해주세요">
			<div id="pwdChekResult">
				<span id="pwdCheckResult"> dddddd </span>
				<!-- boolean으로 된다 안된다 체크 출력 -->
				<!-- <span class="badge text-bg-danger">Danger</span> / <span class="badge text-bg-success">Success</span> -->
			</div>
		</div>
		<div class="mb-3">
			<label for="nickName" class="form-label">Nick Name</label> 
			<input type="text" class="form-control" name="nickName" id="nickName" placeholder="Nickname을 입력해주세요">
		</div>
		<button type="submit" class="btn btn-dark submitBtn">회원가입</button>
	</form>

</div>

<script src="/resources/JS/MemberRegister.js"></script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>