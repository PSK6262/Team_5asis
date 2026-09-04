<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
</head>
<body>
	<div class="sideBar_container">
		<!-- 프로필 -->
		<div class="sideBar_profileSection">
			<label id="label_profile">프로필</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_profile">
				<c:choose>
					<c:when test="${not empty loginUser}">
						<!-- 로그인 상태 -->
						<img class="sideBar_profileImg" src="${profileImage.URL_FILE_PATH}" alt="프로필 이미지">
					</c:when>
					<c:otherwise>
						<!-- 비로그인 상태 -->
						<img class="sideBar_profileImg" src="${profileImage}" alt="프로필 이미지">
					</c:otherwise>
				</c:choose>

				<div class="sideBar_profileInfo">
					<c:choose>
						<c:when test="${not empty loginUser}">
							<!-- 로그인 상태 -->
							<div class="name">${nickname}</div>
						</c:when>
						<c:otherwise>
							<!-- 비로그인 상태 -->
							<div class="name">${nickname}</div>
						</c:otherwise>
					</c:choose>

					<div class="mypage">
						<a href="/board/mypage">마이페이지</a>
					</div>
				</div>
			</div>
		</div>

		<!-- 게시판 -->
		<div class="sideBar_board">
			<label id="label_board">게시판</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_links">
				<a href="${pageContext.request.contextPath}/board/all?category=전체">통합
					게시판</a> <a
					href="${pageContext.request.contextPath}/board/all?category=자유">자유
					게시판</a> <a
					href="${pageContext.request.contextPath}/board/all?category=구인">모집
					게시판</a> <a
					href="${pageContext.request.contextPath}/board/all?category=정보">정보
					게시판</a> <a
					href="${pageContext.request.contextPath}/board/all?category=질문">질문
					게시판</a>
			</div>
		</div>

		<!-- 전체 게임 리스트 -->
		<div class="sideBar_game">
			<label id="label_game">전체 게임 목록</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_links">
				<c:forEach var="game" items="${games}">
					<p>
						<label id="label_Games"
							onclick="popularGamesOnclickEvent('${game.gameAlias}')">
							${game.gameName} </label>
					</p>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- 스크립트 -->
	<!-- 인기 게임 게시판 이동 함수 -->
	<script
		src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>