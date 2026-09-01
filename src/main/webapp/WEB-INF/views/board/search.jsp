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
	.chzzk-streamer-profile-img {
	    width: 36px;       /* 아이콘보다 살짝 큰 최적의 크기 */
	    height: 36px;
	    object-shrink: 0;
	    object-fit: cover;
	    border-radius: 50%;
	    border: 1px solid #e9ecef;
	}
	.streaming-card{
		width:99%;
		height:25vh;
		border:1px solid black;
		margin: 1%;
		transition: transform 0.2s ease, box-shadow 0.2s ease;
	}
	.streaming-image-wrapper {
	    width: 150px;
	    aspect-ratio: 16 / 9;
	    overflow: hidden;
	    border-radius: 6px;
	    flex-shrink: 0;
	    background-color: #f8f9fa;
	}
	.streaming-thumbnail {
	    width: 100%;
	    height: 100%;
	    object-fit: cover; /* 비율 유지하며 꽉 차게 잘라냄 */
	}
	.streaming-info {
	    min-width: 0; /* 부모 d-flex 안에서 text-truncate(말줄임)가 작동 */
	}
	#streaming-card:hover{
	    transform: translateY(-2px);
	    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
	    border-color: #00ffaa !important; /* 치지직 시그니처 네온그린 포인트 색상 */
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
	<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside">
			<c:if test="${keyword != null && keyword.trim() != '' }">
				<p><strong>${keyword}</strong> 의 검색 결과</p>
				<c:if test="${searchResult.searchedByTitle != null && not empty searchResult.searchedByTitle && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'title') } ">
					<p><strong>${keyword}</strong>를 포함하는 제목</p>
					<table class="table">
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
						      <td>${post.gameName}</td>
						      <td>${post.title}</td>
						      <td>${post.nickname}</td>
						      <td>${post.createdAt}</td>
						      <td>${post.viewCount}</td>
						      <td>${post.likeCount}</td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${searchResult.searchedByContent != null && not empty searchResult.searchedByContent && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'content') }">
					<p><strong>${keyword}</strong>를 포함하는 내용</p>
					<table class="table">
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
						      <td>${post.gameName}</td>
						      <td>${post.title}</td>
						      <td>${post.nickname}</td>
						      <td>${post.createdAt}</td>
						      <td>${post.viewCount}</td>
						      <td>${post.likeCount}</td>
						    </tr>
						</c:forEach>
					  </tbody>
					</table>
				</c:if>
				<c:if test="${searchResult.searchedByNickname != null && not empty searchResult.searchedByNickname && (searchKeywordForm.type eq 'all' || searchKeywordForm.type eq 'nickname') }">
					<p><strong>${keyword}</strong>를 포함하는 닉네임</p>
					<table class="table">
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
	<script>
	function popularGamesOnclickEvent(gameName){
		location.href = "/board/" + gameName;
	}
	function gameBoardPostClickEvent(gameAlias,pid){
		location.href = "/board/" + gameAlias + "/" + pid;
	}
	function streamingCardClick(channelId){
		location.href = "https://chzzk.naver.com/live/" + channelId;
	}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>