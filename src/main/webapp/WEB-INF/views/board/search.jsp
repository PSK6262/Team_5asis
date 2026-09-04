<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside">
			<c:if test="${keyword != null && keyword.trim() != '' }">
				<div class="search-result-main-header mb-4">
				    <h4 class="fw-bold mb-0">🔍 <span class="text-primary">"${keyword}"</span> 의 검색 결과</h4>
				</div>
				<c:if test="${searchResult.searchedByBoardName != null && not empty searchResult.searchedByBoardName && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'board')}">
					<h5 class="search-section-title fw-semibold mt-4 mb-2">📝 <span class="keyword-highlight">"${keyword}"</span> 과 관련된 게시판</h5>
					<table class="table table-hover align-middle custom-search-table">
					  <thead>
					    <tr>
					      <th scope="col">게임</th>
					    </tr>
					  </thead>
					  <tbody>
						<c:forEach var="post" items="${searchResult.searchedByBoardName}">
						    <tr class="gameboard-post-view" onclick="gameBoardClickEvent('${post.gameAlias}')">
							  <td><span class="badge bg-secondary bg-opacity-10 text-secondary px-2 py-1 small fw-semibold">${post.gameName}</span></td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${searchResult.searchedByTitle != null && not empty searchResult.searchedByTitle && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'title')}">
					<h5 class="search-section-title fw-semibold mt-4 mb-2">📝 제목에 <span class="keyword-highlight">"${keyword}"</span>을(를) 포함하는 글</h5>
					<table class="table table-hover align-middle custom-search-table">
					  <thead>
					    <tr>
					      <th scope="col">게임</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성자</th>
					      <th scope="col">등록일</th>
					      <th scope="col">조회수</th>
					      <th scope="col">추천</th>
					    </tr>
					  </thead>
					  <tbody>
						<c:forEach var="post" items="${searchResult.searchedByTitle}">
						    <tr class="gameboard-post-view" onclick="gameBoardPostClickEvent('${post.gameAlias}',${post.pid})">
							  <td><span class="badge bg-secondary bg-opacity-10 text-secondary px-2 py-1 small fw-semibold">${post.gameName}</span></td>
						      <td><span class="search-post-title text-truncate fw-medium">${post.title}</span></td>
						      <td>${post.nickname}</td>
						      <td>${post.createdAt}</td>
						      <td>${post.viewCount}</td>
						      <td>${post.likeCount}</td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${searchResult.searchedByContent != null && not empty searchResult.searchedByContent && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'content')}">
					<h5 class="search-section-title fw-semibold mt-4 mb-2">📄 내용에 <span class="keyword-highlight">"${keyword}"</span> 을(를) 포함하는 글</h5>
					<table class="table table-hover align-middle custom-search-table">
					  <thead>
					    <tr>
					      <th scope="col">게임</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성자</th>
					      <th scope="col">등록일</th>
					      <th scope="col">조회수</th>
					      <th scope="col">추천</th>
					    </tr>
					  </thead>
					  <tbody>
						<c:forEach var="post" items="${searchResult.searchedByContent}">
						    <tr class="gameboard-post-view" onclick="gameBoardPostClickEvent('${post.gameAlias}',${post.pid})">
						      <td><span class="badge bg-secondary bg-opacity-10 text-secondary px-2 py-1 small fw-semibold"> ${post.gameName}</span></td>
						      <td><span class="search-post-title text-truncate fw-medium">${post.title}</span></td>
						      <td>${post.nickname}</td>
						      <td>${post.createdAt}</td>
						      <td>${post.viewCount}</td>
						      <td>${post.likeCount}</td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${searchResult.searchedByNickname != null && not empty searchResult.searchedByNickname && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'user')}">
					<h5 class="search-section-title fw-semibold mt-4 mb-2">👥 닉네임에 <span class="keyword-highlight">"${keyword}"</span> 을(를) 포함하는 유저</h5>
					<table class="table table-hover align-middle custom-search-table">
					  <thead>
					    <tr>
					      <th scope="col">UID</th>
					      <th scope="col">닉네임</th>
					    </tr>
					  </thead>
					  <tbody>
						<c:forEach var="userInfo" items="${searchResult.searchedByNickname}">
						    <tr class="gameboard-userInfo-view">
						    <!-- 
						    	userInfo.uId를 못 불러옴(Lombok 에러..) 일단 이름을 바꾸는게 제일 낫지만
						    	이미 사용중인 사람이 있기 때문에 억지로 이렇게 사용함
						     -->
						      <td>${userInfo.getUid()}</td>
						      <td>${userInfo.nickname}</td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${empty searchResult.searchedByTitle && empty searchResult.searchedByContent && empty searchResult.searchedByNickname}">
					<p> 검색 결과가 없습니다.
				</c:if>
			</c:if>
			<c:if test="${keyword == null || keyword.trim() == '' }">
				<p>검색 오류</p>
			</c:if>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/search.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>