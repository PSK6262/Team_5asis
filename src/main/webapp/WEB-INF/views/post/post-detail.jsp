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

/* 마우스 올렸을 때 */
.btn-list-link:hover {
	color: #2F7778; /* 포인트 컬러로 변경 */
	text-decoration: underline; /* 마우스 호버 시 밑줄 표시 */
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
	white-space: pre-wrap; /* 줄바꿈 유지 */
}

/* 하단 버튼 영역 */
.button-area {
	display: flex;
	justify-content: center; /* 자식 요소를 정가운데 정렬 */
	align-items: center;
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid #eee;
}

.center-btn-group {
	display: flex;
	justify-content: center;
}

.btn-group {
	display: flex;
	gap: 10px;
}

.btn {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 14px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.btn-like {
	background-color: #fff;
	border: 1px solid #2F7778;
	color: #2F7778;
	font-weight: bold;
}

.btn-like:hover {
	background: linear-gradient(135deg, #2F7778, #E0B85A);
	color: white;
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

.reply-item {
	padding: 15px 0;
	border-bottom: 1px solid #f5f5f5;
}

.reply-writer {
	font-weight: bold;
	font-size: 14px;
	margin-bottom: 5px;
}

.reply-content {
	font-size: 15px;
	color: #444;
	margin-bottom: 5px;
}

.reply-date {
	font-size: 12px;
	color: #999;
}

.no-reply {
	color: #888;
	padding: 20px 0;
	text-align: center;
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

			<!-- 하단 버튼 영역 -->
			<div class="button-area">
				<button type="button" class="btn btn-like">
					👍 추천 ${post.likeCount}
				</button>
			</div>

			<!-- 댓글 영역 -->
			<div class="reply-section">
				<h3 class="reply-title">댓글</h3>

				<!-- 댓글 작성 폼 -->
				<form class="reply-form" action="${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}/comment" method="post">
					<input type="text" name="commentContent" class="reply-input" placeholder="댓글을 입력하세요..." required>
					<button type="submit" class="btn-reply-submit">등록</button>
				</form>

				<!-- 댓글 목록 -->
				<ul class="reply-list">
					<c:choose>
						<%-- 댓글이 있을 때 --%>
						<c:when test="${not empty post.commentList}">
							<c:forEach var="comment" items="${post.commentList}">
								<li class="reply-item">
									<div class="reply-writer">${comment.nickname}</div>
									<div class="reply-content">${comment.content}</div>
									<div class="reply-date">${comment.createdAt}</div>
								</li>
							</c:forEach>
						</c:when>
						
						<%-- 댓글이 없을 때 --%>
						<c:otherwise>
							<div class="no-reply">작성된 댓글이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>

		</div>
	</div>

</body>
</html>