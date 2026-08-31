<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>5ASIS(오아시스라는 뜻)</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box; /* 패딩이 크기에 영향을 주지 않도록 추가 */
}

/* 1. 웹사이트 전체 아웃라인 정의 (최상위 부모) */
.main_container {
	display: grid;
	/* 가로: 사이드바 200px, 남은 우측 공간 전체(1fr) */
	grid-template-columns: 200px 1fr;
	/* 세로: 헤더는 콘텐츠 크기만큼(auto), 남은 아래 공간 전체(1fr) */
	grid-template-rows: auto 1fr;
	/* 시각적 레이아웃 지도 정의 */
	grid-template-areas: "header  header" "sidebar content";
	min-height: 100vh; /* 화면 전체 높이를 채우도록 설정 */
}

/* 각 영역 매칭 */
.main_header {
	grid-area: header;
	background-color: #ddd; /* 구별용 색상 */
}

.main_sidebar {
	grid-area: sidebar;
	background-color: #eee; /* 구별용 색상 */
}

/* 2. 우측 메인 콘텐츠 영역 내부 정렬 (부모가 되면서 동시에 자식이 됨) */
.main_content {
	grid-area: content; /* 최상위 부모 그리드의 'content' 자리에 배치 */
	display: grid;
	/* 세로: 제목은 딱 자기 크기만큼(auto), 본문 영역은 남은 공간 전부(1fr) */
	grid-template-rows: auto 1fr;
}

/* 메인 콘텐츠 내부 아이템 스타일 */
.content_title {
	font-size: 14px;
	font-weight: bold;
	padding-bottom: 10px;
}

.content_body {
	background-color: #fafafa; /* 구별용 색상 */
	border: 1px solid #e0e0e0;
}
</style>
</head>
<body>
	<div class="main_container">
		<header class="main_header"><jsp:include page="common/navbar.jsp" /></header>
		<aside class="main_sidebar"><jsp:include page="common/sidebar.jsp" /></aside>
		<main class="main_content"></main>
	</div>
</body>
</html>