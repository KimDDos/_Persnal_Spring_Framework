<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/Header.jsp"></jsp:include>
<jsp:include page="../layout/NavTab.jsp"></jsp:include>

<div class="container-md">
	<h1>Board Detail Page</h1>
	<hr>
	<br>
	<c:set value="${bdto.bvo}" var="bvo"></c:set>
	<form action="/board/modify" method="post" enctype="multipart/form-data">
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
		
		<!-- file line -->
		<c:set value="${bdto.flist}" var="flist"></c:set>
		<div class="mb-3">
			<label for="f" class="form-label">File</label>
			<ul class="list-group list-group-flush">
				<c:forEach items="${flist}" var="fvo">
	  				<li class="list-group-item">
	  					<c:choose>
	  						<c:when test="${fvo.fileType == 1 }">
	  							<div>
	  								<img alt="" src="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" style="height: 120px; width: 120px;">
	  							</div>
	  						</c:when>
	  						<c:otherwise>
	  							<div>
	  								<i class="bi bi-file-earmark-excel"></i> <span> <b>파일을 불러올수 없습니다.</b></span>
	  							</div>
	  						</c:otherwise>
	  					</c:choose>
	  					<div class="ms-2 me-auto">
	  						<div class="fw-bold">${fvo.fileName} <span class="badge text-bg-secondary"> ${fvo.fileSize} Byte</span></div>
	  						<button type="button" data-uuid="${fvo.uuid}" class="btn btn-danger btn-sm fileDel">X</button>
	  					</div>
	  				</li>
				</c:forEach>
			</ul>
		</div>
		
		<!-- file 입력 라인 추가 -->
		<div class="mb-3">
			<label for="file" class="form-label">Files....</label> <input
				type="file" class="form-control" name="files" id="files"
				multiple="multiple" style="display: none"> <br>
			<!-- 파일 버튼 트리거 사용하기 위해서 주는 버튼 -->
			<button type="button" class="btn btn-primary" id="trigger"><b>FileUpload</b></button>
		</div>
		<!-- 파일 목록 표시라인 -->
		<div class="mb-3" id="fileZone">
			
		</div>
		
		<button type="submit" class="btn btn-dark" id="regBtn">Modify</button>
		<a href="/board/delete?bno=${bvo.bno}"><button type="button" class="btn btn-dark">Delete</button></a>
	</form>
</div>
<script type="text/javascript" src="/resources/JS/BoardRegister.js"></script>
<script type="text/javascript" src="/resources/JS/BoardModify.js"></script>
<jsp:include page="../layout/Footer.jsp"></jsp:include>