<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

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
			<button class="btn btn-outline-danger" id="commend-up" type="button">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
			</svg> 추천 ${bvo.boardCommend}</button>
			<button class="btn btn-outline-dark" id="commend-down" type="button">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heartbreak-fill" viewBox="0 0 16 16">
			  <path d="M8.931.586 7 3l1.5 4-2 3L8 15C22.534 5.396 13.757-2.21 8.931.586ZM7.358.77 5.5 3 7 7l-1.5 3 1.815 4.537C-6.533 4.96 2.685-2.467 7.358.77Z"/>
			</svg> 비추천 ${bvo.boardNotCommend}</button>
		</div>
	</div>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.email" var="authEmail"/>
	<sec:authentication property="principal.mvo.nickName" var="authNick"/>
		<c:choose>
			<c:when test="${authEmail == bvo.writer}">
				<a href="/board/modify?bno=${bvo.bno}"><button type="button" class="btn btn-dark">Modify</button></a>
			</c:when>
		</c:choose>
	
	<br>
	<hr>
		<div class="comment-reg">
			<input type="hidden" id="authEmailValue" value="${authEmail}">
			<h1>Comment Register</h1>
			<div class="row g-3" style="margin-bottom: 15px">
				<div class="col">
					<label for="floatingEmail">E-mail</label> <input type="text"
						class="form-control" name="writer" id="floatingEmail"
						value="${authEmail}" readonly>
				</div>
				<div class="col">
					<label for="floatingNickname">Nick Name</label> <input type="text"
						class="form-control" name="writerNickname" id="floatingNickname"
						value="${authNick}" readonly>
				</div>
			</div>
			<div class="form-floating" style="margin-bottom: 10px">
				<textarea class="form-control" name="content" id="floatingTextarea2"
					style="height: 100px"></textarea>
				<label for="floatingTextarea2">Content</label>
			</div>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button class="btn btn-dark me-md-2" id="cmtRegBtn" type="button">Comment
					Register</button>
			</div>
		</div>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<div class="comment-reg">
		<input type="hidden" id="authEmailValue" value="Anonymous">
			<h1>Comment Register</h1>
			<div class="form-floating" style="margin-bottom: 10px">
				<textarea class="form-control" name="content" id="floatingTextarea2"
					style="height: 100px" disabled>로그인 후 댓글 등록이 가능합니다.</textarea>
				<label for="floatingTextarea2">Content</label>
			</div>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button class="btn btn-dark me-md-2" id="cmtRegBtn" type="button" disabled>Comment
					Register</button>
			</div>
		</div>
	</sec:authorize>
		<hr>
	<br>
	<div id="commentSpreadZone">
		여기에 댓글 흩뿌리기
		<div class="accordion accordion-flush" id="accordionFlushExample">
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
						aria-expanded="false" aria-controls="flush-collapseOne">
						Accordion Item #1</button>
				</h2>
				<div id="flush-collapseOne" class="accordion-collapse collapse"
					data-bs-parent="#accordionFlushExample">
					<div class="accordion-body">
						Content
					</div>
				</div>
			</div>
		</div>
	</div>
		<hr>
	
	
</div>

<script type="text/javascript">
	const authEmail = document.getElementById('authEmailValue').value;
</script>
<script src="/resources/JS/BoardComment.js"></script>
<script type="text/javascript">
	const bnoVal = `<c:out value="${bvo.bno}"/>`;
	const msg_mod = `<c:out value="${msg_mod}" />`;
	if(msg_mod == '1'){alert("게시글 수정 성공~")}
	spreadCommentList(bnoVal);
</script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>