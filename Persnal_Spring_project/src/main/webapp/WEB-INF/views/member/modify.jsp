<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1> Member Modify Page </h1>
	<hr>
	<br>
	<sec:authentication property="principal.mvo.email" var="authEmail"/>
	<sec:authentication property="principal.mvo.nickName" var="authNcik"/>
	<form action="/member/modify" method="post">
		<div class="mb-3">
			<label for="email" class="form-label">E-Mail</label> 
			<input type="text" class="form-control" name="email" id="email" value="${authEmail}" readonly>
		</div>
		<div class="mb-3">
			<label for="pwdcheck" class="form-label">Password</label> 
			<input type="password" class="form-control" id="pwdcheck" placeholder="Password 를 입력해주세요">
		</div>
		<div class="mb-3">
			<label for="pwd" class="form-label">Password 확인</label> 
			<input type="password" class="form-control" name="pwd" id="pwd"	placeholder="Password 를 입력해주세요">
			<div id="pwdChekResult">
				<span class="badge rounded-pill text-bg-dark" id="pwdCheckResult"> 비밀번호 일치 여부 </span>
				<!-- boolean으로 된다 안된다 체크 출력 -->
				<!-- <span class="badge text-bg-danger">Danger</span> / <span class="badge text-bg-success">Success</span> -->
			</div>
		</div>
		<div class="mb-3">
			<label for="nickName" class="form-label">Nick Name</label> 
			<input type="text" class="form-control" name="nickName" id="nickName" value="${authNick}">
		</div>
		<button type="submit" class="btn btn-dark" id="modBtn" style="display: none"></button>
		<button type="button" class="btn btn-dark" id="submitModBtn">회원정보수정</button>
		<button type="button" class="btn btn-dark" id="memberDelete">회원탈퇴하기</button>
	</form>
	<form action="/member/delete" method="post" id="memberDeleteForm">
					<!-- 인증 된 이메일 -->
		<input type="hidden" name="email" value="${authEmail }">
	</form>
		

</div>

<script type="text/javascript">
	document.getElementById('memberDelete').addEventListener('click', (e) => {
	  e.preventDefault();
	  document.getElementById('memberDeleteForm').submit();
	});
</script>
<script src="/resources/JS/MemberMod.js"></script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>