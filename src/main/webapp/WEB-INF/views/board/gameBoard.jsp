<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gameBoard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<title>5ASIS</title>
</head>
<body>
	<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody d-flex align-items-stretch" style="min-height: 100vh;">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside flex-grow-1">
			<div class="content-header-nav mb-3">
			    <nav aria-label="breadcrumb">
			        <ol class="breadcrumb mb-0">
			            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/main">홈</a></li>
			            <li class="breadcrumb-item active" aria-current="page">${gameName}</li>
			        </ol>
			    </nav>
			</div>
			<c:if test="${gameName != '전체'}">
				<div class="section-title-wrapper d-flex align-items-center mb-3">
				    <h5 class="section-main-title fw-bold mb-0">라이브 방송</h5>
				    <span class="badge bg-success ms-2 d-inline-flex align-items-center live-pulse-badge">
				        <span class="live-dot me-1"></span> LIVE
				    </span>
				</div>
				<div class="row row-cols-1 row-cols-md-2 g-4 mb-4">
					<c:if test="${not empty chzzkApiResponse}">
						<c:forEach var="live" items="${chzzkApiResponse}">
							<div class="col" id="streaming-card" onclick="streamingCardClick(${live.channelId})">
								<div class="col">
									<div class="streaming-card d-flex border rounded p-3 h-100 align-items-center bg-white position-relative" style="cursor: pointer;" onclick="streamingCardClick('${live.channelId}')">
										<div class="streaming-image-wrapper me-3">
											<img src="${live.previewImageUrl}" alt="Thumbnail" class="streaming-thumbnail">
										</div>
										<div class="streaming-info flex-grow-1 d-flex flex-column justify-content-between h-100" style="min-width: 0;">
											<div>
												<h5 class="card-title text-truncate mb-1" style="font-size: 0.95rem; font-weight: 600;" title="${live.liveTitle}">${live.liveTitle}</h5>
											</div>
											<div class="d-flex align-items-center justify-content-between mt-2">
												<div class="d-flex align-items-center flex-grow-1 me-2" style="min-width: 0;">
													<img class="chzzk-streamer-profile-img me-2" src="${live.profileImageUrl}" alt="Profile" /> <span class="card-text text-muted small text-truncate fw-semibold">${live.streamerName}</span>
												</div>
												<span class="badge bg-danger bg-opacity-10 text-danger small px-2 py-1 flex-shrink-0" style="font-size: 0.75rem;"> • ${live.concurrentUserCount}명 </span>
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
				<div class="trend-post-container mb-4">
					<div class="trend-post-header d-flex align-items-center mb-3">
						<h5 class="trend-post-title fw-bold mb-0">🔥 이번 주 인기 게시글</h5>
					</div>
	
					<div class="trend-post-list">
						<c:forEach var="post" items="${selectedTrendPost}">
							<c:if test="${not empty post.rownum}">
								<div
									class="trend-post-item gameboard-post-view d-flex align-items-center justify-content-between"
									onclick="gameBoardPostClickEvent(${post.pid})">
									<div class="d-flex align-items-center flex-grow-1 text-truncate">
										<!-- 인기 순위 배지 -->
										<span class="trend-rank rank-${post.rownum}">${post.rownum}</span>
										<!-- 게시글 제목 -->
										<span class="trend-item-title text-truncate fw-medium ms-2">${post.title}</span>
									</div>
	
									<!-- 작성자 및 메타 정보 (조회수, 좋아요) -->
									<div
										class="trend-meta-info d-flex align-items-center flex-shrink-0 ms-3">
										<span
											class="trend-nickname text-muted small me-3 d-none d-md-inline">${post.nickname}</span>
										<span class="trend-stat me-2 small text-secondary"> 조회수
											${post.viewCount} </span> <span
											class="trend-stat small text-danger fw-semibold"> 좋아요
											${post.likeCount} </span>
									</div>
								</div>
							</c:if>
							<c:if test="${empty post.rownum}">
								<div class="trend-post-empty py-3 text-center text-muted small">
									인기 게시글이 없습니다.</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${gameName != '전체'}">
				<div class="d-flex justify-content-between align-items-center mb-3 mt-4">
				    <div class="category-btn-wrapper">
				        <button type="button" class="btn-category-item" onclick="categoryBtnClick('${gameAlias}','전체')"> 전체 </button>
				        <c:forEach var="category" items="${categories}">
				            <button type="button" class="btn-category-item" onclick="categoryBtnClick('${gameAlias}' ,'${category}')"> ${category} </button>
				        </c:forEach>
			    	</div>
				    <div class="write-btn-wrapper">
				    <c:if test="${loginUser != null}">
				        <button type="button" class="btn-board-write" onclick="location.href='${pageContext.request.contextPath}/board/${gameAlias}/write' ">
				            글쓰기
				        </button>
				    </c:if>
				    </div>
				</div>	
			</c:if>
			<table class="table small">
			  <thead>
			  <c:if test="${gameName != '전체'}">
			    <tr>
			      <th scope="col">번호</th>
			      <th scope="col">태그</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">등록일</th>
			      <th scope="col">조회수</th>
			      <th scope="col">추천</th>
			    </tr>
			  </c:if>
			  <c:if test="${gameName == '전체'}">
			    <tr>
				    <th scope="col" class="col-1 text-center">번호</th>
				    <th scope="col" class="col-1 text-center">게임</th>
				    <th scope="col" class="col-1 text-center">태그</th>
				    <th scope="col" class="col-5">제목</th>
				    <th scope="col" class="col-1 text-center">작성자</th>
				    <th scope="col" class="col-1 text-center">등록일</th>
				    <th scope="col" class="col-1 text-center">조회수</th>
				    <th scope="col" class="col-1 text-center">추천</th>
			    </tr>
			  </c:if>
			  </thead>
				<tbody id="board-table-body">
				    <c:forEach var="post" items="${pagingPosts.posts}">
				        <tr class="gameboard-post-row gameboard-post-view" onclick="gameBoardPostClickEvent(${post.pid})">
				            <!-- 번호 -->
				            <td class="post-id-cell">${post.pid}</td>

				            <!-- 게임명 (전체일때만) -->
				            <c:if test="${gameName == '전체' }">
				            	<td class="post-id-cell small lh-1">${post.gameName}</td>
				        	</c:if>
				            <!-- 태그 -->
				            <td class="post-tag-cell">
				                <span class="custom-tag-badge tag-${post.category}">${post.category}</span>
				            </td>
				            
				            <!-- 제목 -->
				            <td class="post-title-cell text-truncate">
				                <span class="post-title-text">${post.title}</span>
				            </td>
				            
				            <!-- 작성자 -->
				            <td class="post-author-cell">
				                <span class="post-author-text">${post.nickname}</span>
				            </td>
				            
				            <!-- 등록일 -->
				            <td class="post-date-cell">${post.createdAt}</td>
				            
				            <!-- 조회수 -->
				            <td class="post-count-cell">${post.viewCount}</td>
				            
				            <!-- 추천 -->
				            <td class="post-like-cell">${post.likeCount}</td>
				        </tr>
				    </c:forEach>
				</tbody>
			</table>
			<!-- 페이지네이션 -->
			<div class="pagination-div my-4">
			    <nav aria-label="Page-navigation">
			    <c:if test="${pagingPosts.size != 0}">
			        <ul class="pagination custom-pagination mb-0">
			            <!-- Previous 버튼 -->
			            <c:if test="${pagingPosts.hasPrev}">
			                <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , -5 ,'${pagingPosts.category}' )">&lt;</button></li>
			            </c:if>
			            
			            <!-- 앞 번호 버튼들 -->
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
			            
			            <!-- 현재 활성화된 페이지 번호 (active 클래스 부여) -->
			            <li class="page-item active"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 0 ,'${pagingPosts.category}' )">${pagingPosts.currentPage}</button></li>
			            
			            <!-- 뒷 번호 버튼들 -->
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
			            
			            <!-- Next 버튼 -->
			            <c:if test="${pagingPosts.hasNext}">
			                <li class="page-item"><button type="button" class="page-link" onclick="pageMovement(${pagingPosts.currentPage} , 5 ,'${pagingPosts.category}' )">&gt;</button></li>
			            </c:if>
			        </ul>
			    </c:if>
			    </nav>
			</div>
			
			<!-- 게시글 노출 개수 설정 영역 (정돈된 버튼 그룹) -->
			<div class="d-flex justify-content-end align-items-center mb-4 post-size-selector-wrapper">
			    <span class="text-muted small me-2"><i class="bi bi-list-stars"></i> 보기 설정:</span>
			    <div class="btn-group custom-size-btn-group" role="group" aria-label="Page size selector">
			        <c:if test="${gameName != '전체'}">
				        <button type="button" class="btn btn-size-select ${pSize == 5 ? 'active' : ''}" onclick="changePageSize(5)">5개</button>
				        <button type="button" class="btn btn-size-select ${pSize == 10 ? 'active' : ''}" onclick="changePageSize(10)">10개</button>
				        <button type="button" class="btn btn-size-select ${pSize == 20 ? 'active' : ''}" onclick="changePageSize(20)">20개</button>
			    	</c:if>
			    	<c:if test="${gameName == '전체'}">
			    	    <button type="button" class="btn btn-size-select ${pSize == 10 ? 'active' : ''}" onclick="changePageSize(10)">10개</button>
				        <button type="button" class="btn btn-size-select ${pSize == 20 ? 'active' : ''}" onclick="changePageSize(20)">20개</button>
				        <button type="button" class="btn btn-size-select ${pSize == 40 ? 'active' : ''}" onclick="changePageSize(40)">40개</button>
			    	</c:if>
			    </div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/gameBoard.js"></script>
</body>
</html>