<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1> Board List Page </h1>
	<hr>
	<table class="table table-striped">
	  <thead>
	    <tr>
	      <th scope="col">Bno</th>
	      <th scope="col">Title(Comment Count)</th>
	      <th scope="col">Writer</th>
	      <th scope="col">Reg At</th>
	      <th scope="col">Read Count</th>
	      <th scope="col">file Count</th>
	      <th scope="col">Commend Count</th>
	      <th scope="col">Not Commend Count</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${list }" var="bvo">
	    <tr>
	      <th scope="row">${bvo.bno}</th>
	      <td><a href="/board/detail?bno=${bvo.bno}">${bvo.title}<span class="badge text-bg-secondary">${bvo.commentCnt}</span></a></td>
	      <td>${bvo.writer}</td>
	      <c:if test="${bvo.modAt eq bvo.regAt}">
	      <td>${bvo.regAt}</td>
	      </c:if>
	      <c:if test="${bvo.modAt ne bvo.regAt}">
	      <td> ${bvo.regAt} <span class="badge text-bg-info">수정 : ${bvo.modAt}</span></td>
	      </c:if>
	      <td>${bvo.readCount}</td>
	      <td>${bvo.fileQty}</td>
	      <td>${bvo.boardCommend}</td>
	      <td>${bvo.boardNotCommend}</td>
	    </tr>
	    </c:forEach>
	</table>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${ph.prev}">
				<li class="page-item"><a class="page-link" href="/board/list?pageNo=${ph.startPage-1}&qty=${ph.pgvo.qty}">
					<i class="bi bi-caret-left-fill"></i></a></li>
			</c:if>
			<c:forEach begin="${ph.startPage}" end="${ph.endPage}" var="i">
				<li class="page-item"><a class="page-link" 
					href="/board/list?pageNo=${i}&qty=${ph.pgvo.qty}">${i}</a></li>
			</c:forEach>
			<c:if test="${ph.next}">
			<li class="page-item"><a class="page-link" href="/board/list?pageNo=${ph.endPage+1}&qty=${ph.pgvo.qty}">
			<i class="bi bi-caret-right-fill"></i></a></li>
			</c:if>
		</ul>
	</nav>

	<form class="d-flex" action="/board/list">
		<div class="input-group mb-3">
			<select class="form-select" name="type">
				<c:set value="${ph.pgvo.type }" var="typed"></c:set>
				<option ${typed eq null ? 'selected' : '' }>Choose...</option>
				<option value="t" ${typed eq 't' ? 'selected' : '' }>Title</option>
				<option value="w" ${typed eq 'w' ? 'selected' : '' }>Writer</option>
				<option value="c" ${typed eq 'c' ? 'selected' : '' }>Content</option>
				<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>Title
					+ Writer</option>
				<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>Title
					+ Content</option>
				<option value="wc" ${typed eq 'wc' ? 'selected' : '' }>Writer
					+ Content</option>
				<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>Title
					+ Writer + Content</option>
			</select> 
			<input type="hidden" name="pageNo" value="1"> 
			<input type="hidden" name="qty" value="${ph.pgvo.qty}"> 
			<input class="form-control me-2" type="text" name="keyword" value="${ph.pgvo.keyword}" placeholder="Search" aria-label="Search">
			<button class="btn btn-dark" type="submit">
				Search<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${ph.totalcount }</span>
			</button>
		</div>
	</form>

</div>

<script type="text/javascript">
	const msg_reg = `<c:out value="${msg_reg}"/>`;
	const msg_del = `<c:out value="${msg_del}"/>`;
	if(msg_reg == '1'){ alert("게시글 작성 성공~!") }
	if(msg_del == '1'){ alert("게시글 삭제 성공~!") }
</script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>