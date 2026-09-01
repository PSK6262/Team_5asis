<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>5ASIS</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<!-- 메인 css -->
<link href="css/main.css" rel=stylesheet type="text/css">
<!-- 네비게이션바 css -->
<link href="css/navbar.css" rel=stylesheet type="text/css">
<!-- 사이드바 css -->
<link href="css/sidebar.css" rel=stylesheet type="text/css">
</head>
<body>
	<div class="main_container">
		<header class="main_header"><jsp:include page="common/navbar.jsp" /></header>
		<aside class="main_sidebar"><jsp:include page="common/sidebar.jsp" /></aside>
		<main class="main_content"></main>
	</div>
</body>
</html>