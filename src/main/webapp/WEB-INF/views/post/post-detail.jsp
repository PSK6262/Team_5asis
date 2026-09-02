<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title}</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

body {
	background-color: #f5f5f5;
	color: #333;
}

/* 전체 영역 */
.page-container {
	width: 100%;
	min-height: 100vh;
	display: flex;
	justify-content: center;
}

/* 가운데 본문 영역 */
.detail-container {
	width: 900px;
	min-height: 700px;
	margin: 50px 0;
	padding: 40px 50px;
	background-color: white;
	border-radius: 8px;
	/* 고급스러운 그라데이션 테두리 */
	border: 2px solid transparent;
	background:
		linear-gradient(white, white) padding-box,
		linear-gradient(
			135deg,
			#2F7778 0%,
			#4E8580 35%,
			#C5A052 70%,
			#E0B85A 100%
		) border-box;

	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
}

/* 목록으로 링크 스타일 */
.btn-list-link {
	color: #666;
	text-decoration: none; /* 밑줄 제거 */
	font-size: 14px;
	font-weight: 500;
	transition: color 0.2s ease;
	display: inline-block;
	margin-bottom: 20px;
}

.btn-list-link:hover {
	color: #2F7778;
	text-decoration: underline;
}

/* 게시글 제목 */
.post-title {
	font-size: 26px;
	font-weight: bold;
	margin-bottom: 20px;
	word-break: break-all;
}

.category-tag {
	color: #2F7778;
	margin-right: 8px;
}

/* 메타 정보 (작성자, 게임, 조회수 등) */
.post-meta {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	font-size: 14px;
	color: #666;
	padding-bottom: 20px;
	border-bottom: 1px solid #eee;
	margin-bottom: 30px;
}

.meta-item span {
	font-weight: bold;
	color: #333;
}

/* 게시글 본문 내용 */
.post-content {
	min-height: 250px;
	font-size: 16px;
	line-height: 1.8;
	color: #222;
	padding: 10px 0;
	white-space: pre-wrap;
}

/* 전체 버튼 컨테이너 (relative 기준점) */
.post-action-container {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 30px 0 20px 0;
}

/* 추천 버튼 감싸는 div */
.like-button-wrapper {
    display: flex;
    justify-content: center;
}

/* 추천 버튼 스타일 */
.btn-like {
    background-color: #fff;
    border: 1px solid #2F7778;
	color: #2F7778;
	font-weight: bold;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-like:hover,
.btn-like.active {
    background: linear-gradient(135deg, #2F7778, #E0B85A);
    color: #ffffff;
}

/* 오른쪽 끝 수정/삭제 버튼 묶음 (absolute 처리) */
.author-buttons {
    position: absolute;
    right: 0;
    display: flex;
    gap: 6px;
}

/* 수정(a) 및 삭제(button) 공통 소형 통일 디자인 */
.btn-sm {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 46px;
    height: 30px;
    font-size: 13px;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #555;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-edit:hover {
    background-color: #e9e9e9;
    color: #333;
}

.btn-delete:hover {
    background-color: #fee2e2;
    border-color: #fca5a5;
    color: #dc2626;
}

/* 댓글 영역 */
.reply-section {
	margin-top: 50px;
	padding-top: 30px;
	border-top: 2px solid #f0f0f0;
}

.reply-title {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 20px;
}

/* 댓글 입력 Form */
.reply-form {
	display: flex;
	gap: 10px;
	margin-bottom: 30px;
}

.reply-input {
	flex: 1;
	height: 50px;
	padding: 10px 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 14px;
	outline: none;
}

.reply-input:focus {
	border-color: #2F7778;
}

.btn-reply-submit {
	width: 100px;
	height: 50px;
	background: #e9e9e9;
	border: 1px solid #2F7778;
	color: #2F7778;
	border-radius: 8px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s ease;
}

.btn-reply-submit:hover {
	background: linear-gradient(135deg, #2F7778, #E0B85A);
	color: white;
}

/* 댓글 목록 */
.reply-list {
	list-style: none;
}

.no-reply {
	color: #888;
	font-size: 14px;
	padding: 20px 0;
	text-align: center;
}

.reply-item {
	padding: 15px 0;
	border-bottom: 1px solid #f5f5f5;
}

.reply-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 6px;
}

.reply-writer {
	font-weight: bold;
	font-size: 14px;
}

.reply-date {
	font-size: 12px;
	color: #999;
}

.reply-body {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 15px;
}

.reply-content {
	font-size: 15px;
	color: #444;
	line-height: 1.5;
	word-break: break-all;
	flex: 1;
}

.reply-actions {
	display: flex;
	gap: 4px;
	flex-shrink: 0;
}

.btn-reply-sm {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	padding: 3px 8px;
	font-size: 12px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 4px;
	color: #666;
	cursor: pointer;
	transition: all 0.2s ease;
}

.btn-reply-sm:hover {
	background-color: #e9e9e9;
	color: #333;
}

.btn-reply-delete:hover {
	background-color: #fee2e2;
	border-color: #fca5a5;
	color: #dc2626;
}

/* 댓글 수정 폼 */
.reply-edit-form {
	display: none;
	gap: 8px;
	margin-top: 8px;
}

.reply-edit-input {
	flex: 1;
	height: 38px;
	padding: 0 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 14px;
	outline: none;
}

.reply-edit-input:focus {
	border-color: #2F7778;
}

.reply-edit-buttons {
	display: flex;
	gap: 4px;
}

.btn-reply-edit-save {
	height: 38px;
	padding: 0 12px;
	background-color: #2F7778;
	border: none;
	border-radius: 6px;
	color: white;
	font-size: 13px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

.btn-reply-edit-save:hover {
	background-color: #235a5b;
}

.btn-reply-edit-cancel {
	height: 38px;
	padding: 0 10px;
	background-color: #e9e9e9;
	border: none;
	border-radius: 6px;
	color: #555;
	font-size: 13px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}

.btn-reply-edit-cancel:hover {
	background-color: #d8d8d8;
}

.deleted-comment {
    color: #999;
    font-style: italic;
}

/* 대댓글 버튼 및 폼 스타일 */
.btn-nested-reply {
    margin-top: 8px;
    font-size: 12px;
    color: #2F7778;
    background: none;
    border: none;
    cursor: pointer;
    font-weight: bold;
    padding: 0;
}

.btn-nested-reply:hover {
    text-decoration: underline;
}

.nested-reply-form {
    display: none;
    margin-top: 10px;
    padding-left: 20px;
    gap: 8px;
}

.nested-reply-form.active {
    display: flex !important;
}

/* 대댓글 아이템 스타일 */
.reply-item.nested-reply {
    margin-left: 35px; /* 왼쪽 들여쓰기 */
    padding-left: 15px;
    background-color: #fafafa; /* 배경색을 약간 다르게 구분 */
    border-left: 2px solid #2F7778; /* 왼쪽에 구분선 추가 */
    border-bottom: 1px solid #eee;
    border-radius: 0 6px 6px 0;
}

/* 대댓글 화살표 표시 */
.nested-icon {
    color: #2F7778;
    font-weight: bold;
    margin-right: 5px;
}

</style>
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
		function likePost(pId) {
		    $.ajax({
		        url: '${pageContext.request.contextPath}/board/' + pId + '/like',
		        type: 'POST',
		        success: function(response) {
		            if (response.status === 'success') {
		                $('#likeCount').text(response.updatedLikeCount);
		                
		                if (response.isLiked) {
		                    $('#likeBtn').addClass('active');
		                    alert('추천되었습니다.');
		                } else {
		                    $('#likeBtn').removeClass('active');
		                    alert('추천이 취소되었습니다.');
		                }
		            } else {
		                alert('처리에 실패했습니다.');
		            }
		        },
		        error: function() {
		            alert('서버 통신 중 오류가 발생했습니다.');
		        }
		    });
		}
		
		// 댓글 수정 폼 열기
		function showEditForm(cid) {
		    document.getElementById('reply-body-' + cid).style.display = 'none';
		    document.getElementById('reply-edit-form-' + cid).style.display = 'flex';
		}

		// 댓글 수정 폼 취소
		function hideEditForm(cid) {
		    document.getElementById('reply-body-' + cid).style.display = 'flex';
		    document.getElementById('reply-edit-form-' + cid).style.display = 'none';
		}
		
		// 뒤로가기 감지 시 이전 상세페이지 대신 게시판 목록으로 이동
		window.addEventListener('popstate', function(event) {
		    location.replace("${pageContext.request.contextPath}/board/${gameAlias}");
		});

		// 히스토리 더미 상태 추가 (popstate 이벤트를 발생시키기 위함)
		history.pushState(null, null, location.href);
		
		//답글
		function showReplyForm(cid) {
		    const form = document.getElementById("reply-form-" + cid);
		    if (!form) return;

		    // computedStyle을 확인하여 display 상태 검사
		    const currentDisplay = window.getComputedStyle(form).display;

		    if (currentDisplay === "none") {
		        form.style.display = "flex";
		    } else {
		        form.style.display = "none";
		    }
		}
	</script>

</body>
</html>