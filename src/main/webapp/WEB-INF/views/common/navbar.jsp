<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous"> -->
<style>
/* 헤더 전체 컨테이너 */
.headerBar_container {
	display: grid;
	grid-template-columns: auto 1fr auto; /* 로고/팀명 | 빈공간 | 검색창 */
	align-items: center;
	background-color: gray;
	height: 50px;
	padding: 0 20px;
	color: white;
}

/* 로고 + 팀명 */
.logo_section {
	display: grid;
	grid-template-columns: auto auto;
	align-items: center;
	gap: 10px;
	font-weight: bold;
}

/* 검색창 영역 */
.search_section {
	display: grid;
	grid-template-columns: 1fr auto;
	gap: 8px;
}

.search_section input {
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.search_section button {
	padding: 5px 12px;
	background-color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.search_section button:hover {
	background-color: #e0e0e0;
}
</style>
</head>
<body>
	<div class="headerBar_container">
		<!-- 로고 + 팀명 -->
		<div class="logo_section">
			<img src="https://anpanman.choirock.com/common/img/main/character1.png" alt="Logo" width="30" height="24"> <span>5ASIS</span>
		</div>

		<!-- 가운데 공간 (자동으로 비워짐) -->
		<div></div>

		<!-- 검색창 -->
		<div class="search_section">
			<input type="text" placeholder="게임, 게시글 검색..." />
			<button type="submit">Search</button>
		</div>
	</div>
	<!-- 부트스트랩 스크립트 -->
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script> -->
</body>
</html>
