<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="headerBar_container">
		<!-- 로고 + 팀명 -->
		<div class="logo_section">
			<img src="https://anpanman.choirock.com/common/img/main/character1.png" alt="Logo" width="30" height="24"> <span>5ASIS</span>
		</div>

		<form action="/board/search" method="get" class="search_section">
			<select name="type">
				<option value="all" ${param.type == 'all' ? 'selected' : ''}>전체</option>
				<option value="user" ${param.type == 'user' ? 'selected' : ''}>사용자</option>
				<option value="content" ${param.type == 'content' ? 'selected' : ''}>내용</option>
				<option value="title" ${param.type == 'title' ? 'selected' : ''}>제목</option>
				<option value="board" ${param.type == 'board' ? 'selected' : ''}>게시판</option>
			</select> <input type="text" name="keyword" placeholder="검색어 입력">
			<button type="submit">검색</button>
		</form>

		<!-- 로그인 -->
		<div>
			<button type="button" id="btn_goLogin">${empty nickname ? '로그인' : 로그아웃}</button>
		</div>
	</div>
	<script type="text/javascript" src="js/navbar.js"></script>
</body>
</html>