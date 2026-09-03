<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title}</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/navbar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/postDetail.css">
</head>
<body>

	<%@ include file="../common/navbar.jsp"%>

	<div class="pagebody d-flex align-items-stretch"
		style="min-height: 100vh;">

		<%@ include file="../common/sidebar.jsp"%>

		<div class="pagebody-rightside flex-grow-1">

			<div class="page-container">
				<div class="detail-container">

					<a href="${pageContext.request.contextPath}/board/${gameAlias}"
						class="btn-list-link"> ← 목록으로 </a>

					<!-- 게시글 제목 -->
					<h1 class="post-title">
						<span class="category-tag">[${post.category}]</span>${post.title}
					</h1>

					<!-- 메타 정보 -->
					<div class="post-meta">
						<div class="meta-item">
							작성자: <span>${post.nickname}</span>
						</div>
						<div class="meta-item">|</div>
						<div class="meta-item">
							게임: <span>${gameAlias}</span>
						</div>
						<div class="meta-item">|</div>
						<div class="meta-item">
							조회수: <span>${post.viewCount}</span>
						</div>
						<div class="meta-item">|</div>
						<div class="meta-item">
							추천: <span>${post.likeCount}</span>
						</div>
						<div class="meta-item">|</div>
						<div class="meta-item">
							작성일: <span>${post.createdAt}</span>
						</div>
						<c:if test="${not empty post.updatedAt}">
							<div class="meta-item">|</div>

							<div class="meta-item">
								수정일: <span>${post.updatedAt}</span>
							</div>
						</c:if>
					</div>

					<!-- 게시글 본문 -->
					<div class="post-content">${post.content}</div>
					
					<!-- 첨부파일 목록 부분 -->
					<c:if test="${not empty fileList}">
					    <div class="attached-files-container" style="margin: 20px 0; padding: 15px; border: 1px solid #e0e0e0; background-color: #f8f9fa; border-radius: 8px;">
					        <h4 style="margin-top: 0; margin-bottom: 10px; font-size: 15px; color: #333;">📎 첨부파일</h4>
					        <ul style="list-style: none; padding-left: 0; margin: 0;">
					            <c:forEach var="file" items="${fileList}">
					                <li style="margin-bottom: 6px;">
					                    💾 
					                    <!-- 파일명 추출 (UUID 제거) -->
					                    <c:set var="rawFileName" value="${file.mediaUrl.substring(file.mediaUrl.indexOf('_') + 1)}" />
					                    
					                    <a href="${pageContext.request.contextPath}${file.mediaUrl}" 
					                       download="${rawFileName}" 
					                       style="color: #0d6efd; text-decoration: none; font-weight: 500;">
					                        ${rawFileName}
					                    </a>
					                </li>
					            </c:forEach>
					        </ul>
					    </div>
					</c:if>

					<!-- 버튼 영역 전체 감싸기 -->
					<div class="post-action-container">
						<!-- 1. 추천 버튼 (중앙 정렬) -->
						<div class="like-button-wrapper">
							<button type="button" class="btn-like ${isLiked ? 'active' : ''}"
								id="likeBtn" onclick="likePost(${post.pid})">
								👍 추천 <span id="likeCount">${post.likeCount}</span>
							</button>
						</div>

						<!-- 2. 수정/삭제 버튼 (오른쪽 끝 정렬) -->
						<c:if
							test="${not empty sessionScope.LOGIN_USER and post.uid == sessionScope.LOGIN_USER.uid}">
							<div class="author-buttons">
								<a
									href="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/edit"
									class="btn-sm btn-edit"> 수정 </a>

								<form
									action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/delete"
									method="post" style="display: inline;"
									onsubmit="return confirm('정말 삭제하시겠습니까?');">
									<button type="submit" class="btn-sm btn-delete">삭제</button>
								</form>
							</div>
						</c:if>
					</div>

					<!-- 댓글 영역 -->
					<div class="reply-section">
						<h3 class="reply-title">댓글</h3>

						<!-- 댓글 작성 폼 -->
						<form class="reply-form"
							action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment"
							method="post">
							<input type="text" name="commentContent" class="reply-input"
								placeholder="댓글을 입력하세요..." required>
							<button type="submit" class="btn-reply-submit">등록</button>
						</form>

						<ul class="reply-list">
							<c:choose>
								<c:when test="${not empty post.commentList}">
									<c:forEach var="comment" items="${post.commentList}">

										<!-- parentCId가 있으면 대댓글 클래스(nested-reply) 추가 -->
										<li
											class="reply-item ${not empty comment.parentCId ? 'nested-reply' : ''}">

											<!-- 헤더: 작성자 및 작성일 -->
											<div class="reply-header">
												<span class="reply-writer"> <!-- 대댓글인 경우 화살표 아이콘 표시 -->
													<c:if test="${not empty comment.parentCId}">
														<span class="nested-icon">↳</span>
													</c:if> ${comment.nickname}
												</span> <span class="reply-date"> <c:choose>
														<c:when test="${not empty comment.updatedAt}">
									            ${comment.updatedAt} (수정됨)
									        </c:when>
														<c:otherwise>
									            ${comment.createdAt}
									        </c:otherwise>
													</c:choose>
												</span>
											</div> <!-- 1. 일반 조회용 영역 -->
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

												<!-- 삭제되지 않은 댓글만 추천 수 및 수정/삭제 표시 -->
												<c:if test="${comment.content != '삭제된 댓글입니다.'}">
													<div class="reply-actions">
														<!-- DB에 저장된 댓글 추천수(likeCount) 표시 -->
														<button type="button" class="btn-reply-like"
															id="comment-like-btn-${comment.cid}"
															onclick="likeComment(${comment.cid})">
															👍 <span id="comment-like-count-${comment.cid}">${comment.likeCount}</span>
														</button>

														<c:if
															test="${not empty sessionScope.LOGIN_USER and comment.uid == sessionScope.LOGIN_USER.uid}">
															<button type="button" class="btn-reply-sm"
																onclick="showEditForm(${comment.cid})">수정</button>

															<form
																action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/delete"
																method="post" style="display: inline;"
																onsubmit="return confirm('댓글을 삭제하시겠습니까?');">
																<button type="submit"
																	class="btn-reply-sm btn-reply-delete">삭제</button>
															</form>
														</c:if>
													</div>
												</c:if>
											</div> <!-- 2. 수정 입력 폼 --> <c:if
												test="${not empty sessionScope.LOGIN_USER and comment.uid == sessionScope.LOGIN_USER.uid}">
												<form id="reply-edit-form-${comment.cid}"
													action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/edit"
													method="post" class="reply-edit-form">
													<input type="text" name="commentContent"
														class="reply-edit-input" value="${comment.content}"
														required>
													<div class="reply-edit-buttons">
														<button type="submit" class="btn-reply-edit-save">완료</button>
														<button type="button" class="btn-reply-edit-cancel"
															onclick="hideEditForm(${comment.cid})">취소</button>
													</div>
												</form>
											</c:if> <!-- 최상위 댓글이면서 + '삭제된 댓글'이 아닌 경우에만 답글 버튼 노출 --> <c:if
												test="${empty comment.parentCId and comment.content != '삭제된 댓글입니다.'}">
												<button type="button" class="btn-nested-reply"
													onclick="showReplyForm(${comment.cid})">답글</button>

												<!-- 대댓글 작성 폼 -->
												<form id="reply-form-${comment.cid}"
													action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment/${comment.cid}/reply"
													method="post" class="nested-reply-form reply-edit-form">

													<input type="text" name="commentContent"
														class="reply-edit-input" placeholder="답글을 입력하세요..."
														required>
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

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    window.PAGE_CONFIG = {
	        contextPath: "${pageContext.request.contextPath}",
	        gameAlias: "${gameAlias}",
	        pId: "${post.pid}",
	        isLoggedIn: ${not empty sessionScope.LOGIN_USER ? 'true' : 'false'}
	    };
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/js/postDetail.js"></script>

</body>
</html>