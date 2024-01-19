<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1>Board Detail Page</h1>
	<hr>
	<br>
	<div class="mb-3">
		<label for="title" class="form-label">Title</label> <input type="text"
			class="form-control" name="title" id="title" value="${bvo.title}" disabled>
	</div>
	<div class="row g-3">
		<input type="hidden" name="bno" value="${bvo.bno}">
		<div class="col-sm-7">
			<label for="writer" class="form-label">Writer</label> <input
				type="text" class="form-control" name="writer" id="writer"
				value="${bvo.writer}" disabled>
		</div>
		<div class="col-sm">
			<label for="readCount" class="form-label">Read Count</label> <input
				type="text" class="form-control" name="readCount" id="readCount"
				value="${bvo.readCount}" disabled>
		</div>
		<div class="col-sm">
			<c:if test="${bvo.modAt eq bvo.regAt}">
				<label for="regAt" class="form-label">Reg at</label>
				<input type="text" class="form-control" name="regAt" id="regAt"
					value="${bvo.regAt}" disabled>
			</c:if>
			<c:if test="${bvo.modAt ne bvo.regAt}">
				<label for="modAt" class="form-label">Mod at</label>
				<input type="text" class="form-control" name="modAt" id="modAt"
					value="${bvo.modAt}" disabled>
			</c:if>
		</div>
	</div>
	<div class="mb-3">
		<label for="content" class="form-label">Textarea</label>
		<textarea class="form-control" name="content" id="content" rows="3"
			disabled>${bvo.content}</textarea>
	</div>
	<div class="mb-3">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button class="btn btn-outline-danger" type="button">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
			</svg> 추천 ${bvo.boardCommend}</button>
			<button class="btn btn-outline-dark" type="button">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heartbreak-fill" viewBox="0 0 16 16">
			  <path d="M8.931.586 7 3l1.5 4-2 3L8 15C22.534 5.396 13.757-2.21 8.931.586ZM7.358.77 5.5 3 7 7l-1.5 3 1.815 4.537C-6.533 4.96 2.685-2.467 7.358.77Z"/>
			</svg> 비추천 ${bvo.boardNotCommend}</button>
		</div>
	</div>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.email" var="authEmail"/>
		<c:choose>
			<c:when test="${authEmail == bvo.writer}">
				<a href="/board/modify?bno=${bvo.bno}"><button type="button" class="btn btn-dark">Modify</button></a>
			</c:when>
		</c:choose>
	</sec:authorize>
</div>

<script type="text/javascript">
	const msg_mod = `<c:out value="${msg_mod}" />`;
	if(msg_mod == '1'){alert("게시글 수정 성공~")}
</script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>