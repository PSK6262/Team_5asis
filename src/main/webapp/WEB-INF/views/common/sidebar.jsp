<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
	<div class="sideBar_container">
		<!-- 프로필 -->
		<div class="sideBar_profileSection">
			<label id="label_profile">프로필</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_profile">
				<img class="sideBar_profileImg" src="${empty profileImg ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhhyGGwgPL45lqvy3D15y74Heh7azl2cOLI7CPnHb6jw&s=10' : profileImg}" alt="프로필 이미지">
				<div class="sideBar_profileInfo">
					<div class="name">${empty nickname ? '게스트' : nickname}</div>
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
				<a href="${pageContext.request.contextPath}/board/all?category=구인">통합 게시판</a> 
				<a href="${pageContext.request.contextPath}/board/all?category=자유">자유 게시판</a> 
				<a href="${pageContext.request.contextPath}/board/all?category=구인">모집 게시판</a> 
				<a href="${pageContext.request.contextPath}/board/all?category=정보">정보 게시판</a> 
				<a href="${pageContext.request.contextPath}/board/all?category=질문">질문 게시판</a>
			</div>
		</div>

		<!-- 게임 인기 Top6 -->
		<div class="sideBar_game">
			<label id="label_game">게임 인기 Top6</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_links">
				<c:forEach var="game" items="${popularSixGames}">
					<p>
						<label id="label_popularGame" onclick="popularGamesOnclickEvent('${game.gameAlias}')"> ${game.gameName} </label>
					</p>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- 스크립트 -->
	<!-- 인기 게임 게시판 이동 함수 -->
	<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
