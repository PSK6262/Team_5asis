<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/postDetail.css">
</head>
<body>

	<div class="page-container">
		<div class="detail-container">
		
			<a href="${pageContext.request.contextPath}/board/${gameAlias}" class="btn-list-link">
				← 목록으로
			</a>

			<!-- 게시글 제목 -->
			<h1 class="post-title">
				<span class="category-tag">[${post.category}]</span>${post.title}
			</h1>

			<!-- 메타 정보 -->
			<div class="post-meta">
				<div class="meta-item">작성자: <span>${post.nickname}</span></div>
				<div class="meta-item">|</div>
				<div class="meta-item">게임: <span>${gameAlias}</span></div>
				<div class="meta-item">|</div>
				<div class="meta-item">조회수: <span>${post.viewCount}</span></div>
				<div class="meta-item">|</div>
				<div class="meta-item">추천: <span>${post.likeCount}</span></div>
				<div class="meta-item">|</div>
				<div class="meta-item">작성일: <span>${post.createdAt}</span></div>
			</div>

			<!-- 게시글 본문 -->
			<div class="post-content">${post.content}</div>

			<!-- 버튼 영역 전체 감싸기 -->
			<div class="post-action-container">
			    <!-- 1. 추천 버튼 (중앙 정렬) -->
			    <div class="like-button-wrapper">
			        <button type="button" class="btn-like ${isLiked ? 'active' : ''}" id="likeBtn" onclick="likePost(${post.pid})">
			            👍 추천 <span id="likeCount">${post.likeCount}</span>
			        </button>
			    </div>
			
			    <!-- 2. 수정/삭제 버튼 (오른쪽 끝 정렬) -->
			    <c:if test="${post.uid == 1}">
			        <div class="author-buttons">
			            <a href="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/edit"
			               class="btn-sm btn-edit">
			                수정
			            </a>
			
			            <form action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/delete"
			                  method="post"
			                  style="display:inline;"
			                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
			                <button type="submit" class="btn-sm btn-delete">
			                    삭제
			                </button>
			            </form>
			        </div>
			    </c:if>
			</div>

			<!-- 댓글 영역 -->
			<div class="reply-section">
				<h3 class="reply-title">댓글</h3>

				<!-- 댓글 작성 폼 -->
				<form class="reply-form" action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment" method="post">
					<input type="text" name="commentContent" class="reply-input" placeholder="댓글을 입력하세요..." required>
					<button type="submit" class="btn-reply-submit">등록</button>
				</form>
			
				<ul class="reply-list">
			    <c:choose>
			        <c:when test="${not empty post.commentList}">
			            <c:forEach var="comment" items="${post.commentList}">
			                
			                <!-- parentCId가 있으면 대댓글 클래스(nested-reply) 추가 -->
			                <li class="reply-item ${not empty comment.parentCId ? 'nested-reply' : ''}">
			                    
			                    <!-- 헤더: 작성자 및 작성일 -->
			                    <div class="reply-header">
			                        <span class="reply-writer">
			                            <!-- 대댓글인 경우 화살표 아이콘 표시 -->
			                            <c:if test="${not empty comment.parentCId}">
			                                <span class="nested-icon">↳</span>
			                            </c:if>
			                            ${comment.nickname}
			                        </span>
			                        <span class="reply-date">${comment.createdAt}</span>
			                    </div>
			
			                    <!-- 1. 일반 조회용 영역 -->
			                    <div class="reply-body" id="reply-body-${comment.cid}">
			                        <div class="reply-content">
			                            <c:choose>
			                                <c:when test="${comment.content == '삭제된 댓글입니다.'}">
			                                    <span class="deleted-comment">삭제된 댓글입니다.</span>
			                                </c:when>
			                                <c:otherwise>
			                                    ${comment.content}
			                                </c:otherwise>
			                            </c:choose>
			                        </div>
			                        
			                        <c:if test="${comment.uid == 1}">
			                            <div class="reply-actions">
			                                <button type="button" class="btn-reply-sm" onclick="showEditForm(${comment.cid})">수정</button>
			                                
			                                <form action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/delete" 
			                                      method="post" 
			                                      style="display:inline;" 
			                                      onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
			                                    <button type="submit" class="btn-reply-sm btn-reply-delete">삭제</button>
			                                </form>
			                            </div>
			                        </c:if>
			                    </div>
			
			                    <!-- 2. 수정 입력 폼 -->
			                    <c:if test="${comment.uid == 1}">
			                        <form id="reply-edit-form-${comment.cid}" 
			                              action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/edit" 
			                              method="post" 
			                              class="reply-edit-form">
			                            <input type="text" name="commentContent" class="reply-edit-input" value="${comment.content}" required>
			                            <div class="reply-edit-buttons">
			                                <button type="submit" class="btn-reply-edit-save">완료</button>
			                                <button type="button" class="btn-reply-edit-cancel" onclick="hideEditForm(${comment.cid})">취소</button>
			                            </div>
			                        </form>
			                    </c:if>
			                    
			                    <!-- 최상위 댓글이면서 + '삭제된 댓글'이 아닌 경우에만 답글 버튼 노출 -->
								<c:if test="${empty comment.parentCId and comment.content != '삭제된 댓글입니다.'}">
								    <button type="button" class="btn-nested-reply" onclick="showReplyForm(${comment.cid})">
								        답글
								    </button>
								
								    <!-- 대댓글 작성 폼 -->
								    <form id="reply-form-${comment.cid}"
								          action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/reply"
								          method="post"
								          class="nested-reply-form reply-edit-form">
								
								        <input type="text" name="commentContent" class="reply-edit-input" placeholder="답글을 입력하세요..." required>
								        <div class="reply-edit-buttons">
								            <button type="submit" class="btn-reply-edit-save">등록</button>
								        </div>
								    </form>
								</c:if>
			
			                </li>
			            </c:forEach>
			        </c:when>
			        
			        <c:otherwise>
			            <div class="no-reply">작성된 댓글이 없습니다.</div>
			        </c:otherwise>
			    </c:choose>
			</ul>
			</div>

		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    window.PAGE_CONFIG = {
	        contextPath: "${pageContext.request.contextPath}",
	        gameAlias: "${gameAlias}"
	    };
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/postDetail.js"></script>

</body>
</html>