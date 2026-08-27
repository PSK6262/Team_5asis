<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>Insert title here</title>
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
		width:100%;
		height:100vh;
	}
	.pagebody-leftside{
		width:20%;
		height:100%;
		border:1px solid black;
		margin-right:1%;
	}
	.pagebody-rightside{
		width:80%;
		border:1px solid black;
		margin-left:1%;
	}
</style>
</head>
<body>
	<nav class="navbar bg-body-tertiary">
	  <div class="container-fluid d-flex justify-content-between align-items-center">
	    <div id="navbarLeftMost">
	      <a class="navbar-brand" href="#">5ASIS</a>
	    </div>
	    <form class="form-inline my-2 my-lg-0" id="centerSearchBar">
	      <div class="position-relative d-flex align-items-center">
	        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search position-absolute ms-2 text-muted" viewBox="0 0 16 16" style="z-index: 5;">
	          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
	        </svg>
	        <input class="form-control ps-4 mr-sm-2" type="search" placeholder="게임, 게시글 검색.." aria-label="Search">
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
		</div>
		<div class="pagebody-rightside">
			<h4>홈 > ${gameAlias} </h4> 
			<p>방송중</p>
			<p>인기 게시글</p>
			<c:forEach var="s" items="${categories}">
				<button type="button" name="categories"> ${s} </button>
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
				<c:forEach var="post" items="${selectedPost}">
				    <tr>
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
		</div>
	</div>	
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>