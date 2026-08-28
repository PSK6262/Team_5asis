<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>5ASIS(오아시스라는 뜻)</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<style>
* {
	margin: 0;
	padding: 0;
}

.main_container {
	width: 100%;
	height: auto;
	min-height: 100vh;
}
</style>
</head>
<body>
	<div class="main_container"><jsp:include page="headerBar.jsp" />
		<jsp:include page="sideBar.jsp" />
		<%-- <jsp:include page="${contentPage}" /> --%>
	</div>
</body>
</html>