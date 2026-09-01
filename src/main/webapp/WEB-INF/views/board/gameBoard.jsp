<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>5ASIS</title>
<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	
	.pagebody {
		display: flex;
		width: 100vw;
		height: 100vh;
	}
	
	.pagebody-rightside {
		width: 80%;
		height: 100%;
		border: 1px solid black;
		margin-left: 0.2%;
		padding: 1%;
	}
	
	.chzzk-streamer-profile-img {
		width: 36px; /* 아이콘보다 살짝 큰 최적의 크기 */
		height: 36px;
		object-shrink: 0;
		object-fit: cover;
		border-radius: 50%;
		border: 1px solid #e9ecef;
	}
	
	.streaming-card {
		width: 99%;
		height: 25vh;
		border: 1px solid black;
		margin: 1%;
		transition: transform 0.2s ease, box-shadow 0.2s ease;
	}
	
	.streaming-image-wrapper {
		width: 150px;
		aspect-ratio: 16/9;
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
	
	#streaming-card:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		border-color: #00ffaa !important; /* 치지직 시그니처 네온그린 포인트 색상 */
	}
	
	.gameboard-post-view:hover {
		background-color: gray;
		cursor: pointer;
	}
	
	.pagination-div {
		width: 100%;
	}
	#centerSearchBar{
		width:30%;
	}
	.popular-games-label {
		margin: 1%;
	}
	
	.popular-games-label:hover {
		background-color: gray;
	}
	
	#leftside-login-btn {
		width: 100%;
	}
	
	.pagebody-leftside {
		width: 20%;
		height: 100%;
		border: 1px solid black;
		margin-left: 0.2%;
		margin-right: 0.2%;
		padding: 1%;
	}
</style>
</head>
<body>
	<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside">
			<h4 class="">홈 > ${gameName} </h4> 
			<p>방송중</p>
			<div class="row row-cols-1 row-cols-md-2 g-4 mb-4">
			<c:if test="${not empty chzzkApiResponse}">
				<c:forEach var="live" items="${chzzkApiResponse}">
				<div class="col" id="streaming-card" onclick="streamingCardClick(${live.channelId})">
					<div class="col">
					    <div class="streaming-card d-flex border rounded p-3 h-100 align-items-center bg-white position-relative" 
					         style="cursor: pointer;" 
					         onclick="streamingCardClick('${live.channelId}')">
					        <div class="streaming-image-wrapper me-3">
					            <img src="${live.previewImageUrl}" alt="Thumbnail" class="streaming-thumbnail">
					        </div>
					        <div class="streaming-info flex-grow-1 d-flex flex-column justify-content-between h-100" style="min-width: 0;">
					            <div>
					                <h5 class="card-title text-truncate mb-1" style="font-size: 0.95rem; font-weight: 600;" title="${live.liveTitle}">
					                    ${live.liveTitle}
					                </h5>
					            </div>
					            <div class="d-flex align-items-center justify-content-between mt-2">
					                <div class="d-flex align-items-center flex-grow-1 me-2" style="min-width: 0;">
					                    <img class="chzzk-streamer-profile-img me-2" src="${live.profileImageUrl}" alt="Profile" />
					                    <span class="card-text text-muted small text-truncate fw-semibold">${live.streamerName}</span>
					                </div>
					                <span class="badge bg-danger bg-opacity-10 text-danger small px-2 py-1 flex-shrink-0" style="font-size: 0.75rem;">
					                    • ${live.concurrentUserCount}명
					                </span>
					            </div>
					        </div>
					    </div>
					</div>
		        </div>
				</c:forEach>
			</c:if>
			<c:if test="${empty chzzkApiResponse}">
				<p>진행중인 방송이 없습니다.</p>
			</c:if>
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
				<button type="button" name="categories" onclick="categoryBtnClick('${gameAlias}','전체')"> 전체 </button>
			<c:forEach var="category" items="${categories}">
				<button type="button" name="categories" onclick="categoryBtnClick('${gameAlias}' ,'${category}')"> ${category} </button>
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
	function categoryBtnClick(gameAlias, categoryName) {
	    location.href = "/board/" + gameAlias + "?page=1&category=" + encodeURIComponent(categoryName);
	}
	function streamingCardClick(channelId){
		location.href = "https://chzzk.naver.com/live/" + channelId;
	}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>