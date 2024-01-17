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

</div>

<script type="text/javascript">
	const msg_reg = `<c:out value="${msg_reg}"/>`;
	const msg_del = `<c:out value="${msg_del}"/>`;
	if(msg_reg == '1'){ alert("게시글 작성 성공~!") }
	if(msg_del == '1'){ alert("게시글 삭제 성공~!") }
</script>

<jsp:include page="../layout/Footer.jsp"></jsp:include>