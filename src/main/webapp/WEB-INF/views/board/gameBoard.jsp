<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gameBoard.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>5ASIS</title>
</head>
<body>
	<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody d-flex align-items-stretch" style="min-height: 100vh;">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside flex-grow-1">
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
			  <tbody id="board-table-body">
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
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -5 ,'${pagingPosts.category}' )">Previous</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage - 4 > 0}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -4 ,'${pagingPosts.category}' )">${pagingPosts.currentPage - 4}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage - 3 > 0}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -3 ,'${pagingPosts.category}' )">${pagingPosts.currentPage - 3}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage - 2 > 0}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -2 ,'${pagingPosts.category}' )">${pagingPosts.currentPage - 2}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage - 1 > 0}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -1 ,'${pagingPosts.category}' )">${pagingPosts.currentPage - 1}</button></li>
				    </c:if>
				    
				    <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 0 ,'${pagingPosts.category}' )">${pagingPosts.currentPage}</button></li>
				    
				    <c:if test="${pagingPosts.currentPage + 1 <= (pagingPosts.postSize + pagingPosts.size - 1) / pagingPosts.size}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 1 ,'${pagingPosts.category}' )">${pagingPosts.currentPage + 1}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage + 2 <= (pagingPosts.postSize + pagingPosts.size - 2) / pagingPosts.size}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 2 ,'${pagingPosts.category}' )">${pagingPosts.currentPage + 2}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage + 3 <= (pagingPosts.postSize + pagingPosts.size - 3) / pagingPosts.size}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 3 ,'${pagingPosts.category}' )">${pagingPosts.currentPage + 3}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.currentPage + 4 <= (pagingPosts.postSize + pagingPosts.size - 4) / pagingPosts.size}">
				    	<li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 4 ,'${pagingPosts.category}' )">${pagingPosts.currentPage + 4}</button></li>
				    </c:if>
				    <c:if test="${pagingPosts.hasNext}">
				    <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 5 ,'${pagingPosts.category}' )">Next</button></li>
				  	</c:if>
				  </ul>
				</c:if>
				</nav>
			</div>
			<div class="d-flex justify-content-end mb-3">
			    <div class="btn-group" role="group">
			        <!-- pSize가 5(SMALL)이면 active 클래스 추가 -->
			        <button type="button" class="btn btn-outline-primary ${pSize == 5 ? 'active' : ''}" onclick="changePageSize(5)">5개</button>
			        <!-- pSize가 10(MEDIUM)이면 active 클래스 추가 -->
			        <button type="button" class="btn btn-outline-primary ${pSize == 10 ? 'active' : ''}" onclick="changePageSize(10)">10개</button>
			        <!-- pSize가 20(LARGE)이면 active 클래스 추가 -->
			        <button type="button" class="btn btn-outline-primary ${pSize == 20 ? 'active' : ''}" onclick="changePageSize(20)">20개</button>
			    </div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gameBoard.js"></script>
</body>
</html>