<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1>Board Detail Page</h1>
	<hr>
	<br>
	<form action="/board/modify" method="post">
		<input type="hidden" name="bno" value="${bvo.bno}">
		<div class="mb-3">
			<label for="title" class="form-label">Title</label> <input type="text"
				class="form-control" name="title" id="title" value="${bvo.title}">
		</div>
		<div class="row g-3">
			<input type="hidden" name="bno" value="${bvo.bno}">
			<div class="col-sm-7">
				<label for="writer" class="form-label">writer</label> <input
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
			<label for="content" class="form-label">textarea</label>
			<textarea class="form-control" name="content" id="content" rows="3"
				>${bvo.content}</textarea>
		</div>
	
		<button type="submit" class="btn btn-dark">Modify</button>
		<a href="/board/delete?bno=${bvo.bno}"><button type="button" class="btn btn-dark">Delete</button></a>
	</form>
</div>

<jsp:include page="../layout/Footer.jsp"></jsp:include>