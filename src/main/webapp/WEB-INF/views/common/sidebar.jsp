<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<<<<<<< HEAD:src/main/webapp/WEB-INF/views/common/sidebar.jsp
<<<<<<< HEAD
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
>>>>>>> feature/common/sidebar-view:src/main/webapp/WEB-INF/views/sideBar.jsp
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
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
				<a href="/board/party">파티모집게시판</a> <a href="/board/free">자유게시판</a> <a href="/board/info">정보/공략</a> <a href="/board/question">질문게시판</a> <a href="/board/suggestion">건의게시판</a>
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
	<script type="text/javascript" src="js/sidebar.js"></script>
</body>
</html>
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagebody-leftside">
	<form class="p-4">
		<div class="form-group">
			<label for="leftside-login-id">아이디</label> <input type="email"
				class="form-control" id="leftside-login-id"
				placeholder="email@example.com">
		</div>
		<div class="form-group">
			<label for="leftside-login-pw">비밀번호</label> <input type="password"
				class="form-control" id="leftside-login-pw" placeholder="Password">
		</div>
		<div class="form-check">
			<input type="checkbox" class="form-check-input" id="dropdownCheck2">
			<label class="form-check-label" for="dropdownCheck2"> 아이디 기억
			</label>
		</div>
		<button type="submit" class="btn btn-primary" id="leftside-login-btn">로그인</button>
	</form>
	<div class="pagebody-leftside-gameboard-list">
		<div class="popular-games-header">
			<h5>인기 게시판 TOP 6</h5>
		</div>
		<c:forEach var="game" items="${popularSixGames}">
			<p>
				<label class="popular-games-label"
					onclick="popularGamesOnclickEvent('${game.gameAlias}')">${game.gameName}</label>
			</p>
		</c:forEach>
	</div>
</div>
>>>>>>> d11d0140014f782afe376ac3d4cbccb8b18b7e90
