<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/navbar.css">
</head>
<body>
	<div class="headerBar_container">
		<!-- 로고 + 팀명 -->
		<div class="logo_section">
			<img id="img_logo"
				src="${pageContext.request.contextPath}/resources/image/teamLogo.png"
				alt="Logo" width=50px height=30px>
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
			<button type="button" id="btn_goLogin">
				<c:choose>
					<c:when test="${not empty loginUser}">
						<!-- 로그인 상태 -->
						로그아웃
					</c:when>
					<c:otherwise>
						<!-- 비로그인 상태 -->
						로그인
					</c:otherwise>
				</c:choose>
			</button>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/navbar.js"></script>
</body>
</html>