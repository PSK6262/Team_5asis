<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<style>
.container-fluid {
	background: linear-gradient(to top, #3e726f, #bf9f66);
	height: 50px;
}

.bg-body-tertiary {
	padding: 0px;
}
</style>
</head>
<body>
	<div class="headerBar_container">
		<nav class="navbar bg-body-tertiary">
			<div class="container-fluid">
				<a class="navbar-brand" href="/5asis"> <img
					src="https://anpanman.choirock.com/common/img/main/character1.png"
					alt="Logo" width="30" height="24"
					class="d-inline-block align-text-top"> 5ASIS
				</a>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search"
						placeholder="게임,게시글 검색..." aria-label="Search" />
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</nav>
	</div>
	<!-- 부트스트랩 스크립트 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
</body>
</html>