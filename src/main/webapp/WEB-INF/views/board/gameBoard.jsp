<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>Insert title here</title>
<!-- 이후 gameboard-style.css 로 빼기-->
<style>
	*{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
	}
	#centerSearchBar{
		width:30%;
	}
	.pagebody{ 
		display:flex;
		width:100vw;
		height:100vh;
	}
	.pagebody-leftside{
		width:20%;
		height:100%;
		border:1px solid black;
		margin-left: 0.2%;
		margin-right:0.2%;
		padding : 1%;
	}
	.pagebody-rightside{
		width:80%;
		height:100%;
		border:1px solid black;
		margin-left:0.2%;
		padding: 1%;
	}
	.streaming-card{
		width:99%;
		height:25vh;
		border:1px solid black;
		margin: 1%;
	}
	#leftside-login-btn{
		width:100%;
	}
	.popular-games-label{
		margin:1%;
	}
	.popular-games-label:hover{
		background-color:gray;
	}
	.gameboard-post-view:hover{
		background-color:gray;
		cursor:pointer;
	}
	.pagination-div{
		width:100%;
	}
</style>
</head>
<body>
	<nav class="navbar bg-body-tertiary">
		<div
			class="container-fluid d-flex justify-content-between align-items-center">
			<div id="navbarLeftMost">
				<a class="navbar-brand" href="#">5ASIS</a>
			</div>
			<form class="form-inline my-2 my-lg-0" id="centerSearchBar">
				<div class="position-relative d-flex align-items-center">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor"
						class="bi bi-search position-absolute ms-2 text-muted"
						viewBox="0 0 16 16" style="z-index: 5;">
		          <path	d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
		        </svg>
					<input class="form-control ps-4 mr-sm-2" type="search"
						placeholder="게임, 게시글 검색.." aria-label="Search">
				</div>
			</form>
			<button class="btn btn-info" id="navbarLoginButton">로그인</button>
		</div>
	</nav>
	<div class="pagebody">
		<div class="pagebody-leftside">
			<form class="p-4">
			  <div class="form-group">
			    <label for="leftside-login-id">아이디</label>
			    <input type="email" class="form-control" id="leftside-login-id" placeholder="email@example.com">
			  </div>
			  <div class="form-group">
			    <label for="leftside-login-pw">비밀번호</label>
			    <input type="password" class="form-control" id="leftside-login-pw" placeholder="Password">
			  </div>
			  <div class="form-check">
			    <input type="checkbox" class="form-check-input" id="dropdownCheck2">
			    <label class="form-check-label" for="dropdownCheck2">
			      아이디 기억
			    </label>
			  </div>
			  <button type="submit" class="btn btn-primary" id="leftside-login-btn">로그인</button>
			</form>
			<div class="pagebody-leftside-gameboard-list">
				<div class="popular-games-header">
					<h5>인기 게시판 TOP 6</h5>
				</div>
				<c:forEach var="game" items="${popularSixGames}">
					<p><label class="popular-games-label" onclick="popularGamesOnclickEvent('${game.gameAlias}')">${game.gameName}</label></p>
				</c:forEach>
			</div>
		</div>
		<div class="pagebody-rightside">
			<h4 class="">홈 > ${gameName} </h4> 
			<p>방송중</p>
			<div class="streaming-card d-flex border rounded p-3 mb-4">
				<div class="streaming-left me-3 bg-light p-2 h-100" style="flex: 1;">1</div>
				<div class="streaming-right bg-light p-2 h-100" style="flex: 1;">2</div>
			</div>
			<div>
				<p>인기 게시글</p>
				<c:forEach var="post" items="${selectedTrendPost}">
					<c:if test="${not empty post.rownum}">
						<p><label class="gameboard-post-view" onclick="gameBoardPostClickEvent(${post.pid})"> ${post.rownum} 제목: ${post.title} 이름 : ${post.nickname} 조회수 : ${post.viewCount} 좋아요수 : ${post.likeCount} </label></p>
					</c:if>
					<c:if test="${empty post.rownum}">
						<label> 글이 없습니다 </label>
					</c:if>
				</c:forEach>
			</div>
				<button type="button" name="categories" onclick="categoryBtnClick('전체')"> 전체 </button>
			<c:forEach var="category" items="${categories}">
				<button type="button" name="categories" onclick="categoryBtnClick('${category}')"> ${category} </button>
			</c:forEach>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">번호</th>
			      <th scope="col">태그</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">등록일</th>
			      <th scope="col">조회수</th>
			      <th scope="col">추천</th>
			    </tr>
			  </thead>
			  <tbody>
				<c:forEach var="post" items="${pagingPosts.posts}">
				    <tr class="gameboard-post-view" onclick="gameBoardPostClickEvent(${post.pid})">
				      <th scope="row">${post.pid}</th>
				      <td>${post.category}</td>
				      <td>${post.title}</td>
				      <td>${post.nickname}</td>
				      <td>${post.createdAt}</td>
				      <td>${post.viewCount}</td>
				      <td>${post.likeCount}</td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
			<div class="pagination-div">
				<nav aria-label="Page-navigation">
				<c:if test="${pagingPosts.size != 0}">
				  <ul class="pagination">
				  	<c:if test="${pagingPosts.hasPrev}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -2)">Previous</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage - 1 > 0}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -1)">${pagingPosts.currentPage - 1}</button></li>
				    </c:if>
				    <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 0)">${pagingPosts.currentPage}</button></li>
				    <c:if test="${pagingPosts.currentPage + 1 <= (pagingPosts.postSize + pagingPosts.size - 1) / pagingPosts.size}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 1)">${pagingPosts.currentPage + 1}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.hasNext}">
				    <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 2)">Next</button></li>
				  	</c:if>
				  </ul>
				</c:if>
				</nav>
			</div>
		</div>
	</div>	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
	<!-- 스크립트는 이후 새로운 파일로 뺄 것 -->
	<script>
		function popularGamesOnclickEvent(gameName){
			location.href = "/board/" + gameName;
		}
		function gameBoardPostClickEvent(pid){
			location.href = window.location.pathname + "/" + pid;
		}
		function pageMovement(currentPage, num){
			let targetPage = currentPage + num;
			location.href = window.location.pathname + "?page=" + targetPage;
		}
		function categoryBtnClick(categoryName) {
			let gameAlias = '${gameAlias}';
		    location.href = "/board/" + gameAlias + "?page=1&category=" + encodeURIComponent(categoryName);
		}
	</script>
</body>
</html>