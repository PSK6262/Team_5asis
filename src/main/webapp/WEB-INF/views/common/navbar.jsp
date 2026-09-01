<<<<<<< HEAD
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
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar bg-body-tertiary">
	<div
		class="container-fluid d-flex justify-content-between align-items-center">
		<div id="navbarLeftMost">
			<a class="navbar-brand" href="#">5ASIS</a>
		</div>
		<form class="form-inline my-2 my-lg-0" id="centerSearchBar"
			action="/board/search" method="get">
			<div class="input-group">
				<select class="form-select flex-grow-0" name="type"
					style="width: auto; max-width: 110px; border-top-right-radius: 0; border-bottom-right-radius: 0;">
					<option value="all" ${param.type == 'all' ? 'selected' : ''}>전체</option>
					<option value="user" ${param.type == 'user' ? 'selected' : ''}>사용자</option>
					<option value="content"	${param.type == 'content' ? 'selected' : ''}>내용</option>
					<option value="title" ${param.type == 'title' ? 'selected' : ''}>제목</option>
				</select>
				<div class="position-relative d-flex align-items-center flex-grow-1">
					<svg xmlns="http://w3.org" width="16" height="16"
						fill="currentColor"
						class="bi bi-search position-absolute ms-2 text-muted"
						viewBox="0 0 16 16" style="z-index: 5;">
				      <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
				    </svg>
					<input class="form-control ps-4" type="search"
						placeholder="게임, 게시글 검색.." aria-label="Search" name="keyword"
						value="${keyword}"
						style="border-top-left-radius: 0; border-bottom-left-radius: 0;">
				</div>
			</div>
		</form>
		<button class="btn btn-info" id="navbarLoginButton">로그인</button>
	</div>
</nav>
>>>>>>> d11d0140014f782afe376ac3d4cbccb8b18b7e90
