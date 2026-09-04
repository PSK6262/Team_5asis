<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>


<html>

	<head>
	
		<meta charset="UTF-8">
	
		<title>5ASIS</title>
	
	
		<!-- 부트스트랩 css CDN 연결 부분 -->
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
		
		<!-- 메인 css -->
		
		<link href="${pageContext.request.contextPath}/resources/css/main.css" rel=stylesheet type="text/css">
		
		<!-- 네비게이션바 css -->
		
		<link href="${pageContext.request.contextPath}/resources/css/navbar.css" rel=stylesheet type="text/css">
		
		<!-- 사이드바 css -->
		
		<link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel=stylesheet type="text/css">
	
	</head>
	
	
	<body>
	
		<div class="main_container">
		
			<!-- navbar 영역 -->
			
			<header class="main_header"><jsp:include page="common/navbar.jsp" /></header>
			
			
			<!-- sidebar 영역 -->
			
			<aside class="main_sidebar"><jsp:include page="common/sidebar.jsp" /></aside>
			
			
			<!-- main 영역 -->
			
			<main class="main_content">
				
				<!-- <h2>
				
					인기 게임 TOP 6
					
				</h2> -->
				
				<c:forEach var="game" items="${popularSixGames}">
				
					<div class="game-card" onclick="popularGamesOnclickEvent('${game.gameAlias}')">
					
			            <img src="${game.gameImage}" alt="${game.gameName}">
			            
			            
			            <p>${game.gameName}</p>
			            
       				</div>
					
				</c:forEach>
				
			</main>
			
		</div>
		
		
		<!-- 스크립트 영역 -->
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
		
	</body>
	
</html>