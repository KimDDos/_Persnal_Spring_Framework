<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="./layout/Header.jsp"></jsp:include>
<jsp:include page="./layout/NavTab.jsp"></jsp:include>

<h1>
	Hello! Welcome to my Spring Project Home!  
</h1>

<script type="text/javascript">
	const msg_MemReg = `<c:out value="${msg_MemReg}"/>`;
	if(msg_MemReg == '1'){alert("회원가입 성공~!")}
</script>

<jsp:include page="./layout/Footer.jsp"></jsp:include>
