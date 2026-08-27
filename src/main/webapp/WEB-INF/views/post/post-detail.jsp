<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title}</title>
</head>
<body>
	<!-- 게시글 상세 정보 -->
	<h2>[${post.category}] ${post.title}</h2>
	<p>작성자: ${post.nickname} | 게임: ${post.gameName} | 조회수:
		${post.viewCount} | 좋아요: ${post.likeCount} | 작성일: ${post.createdAt}</p>
	<hr>

	<!-- 게시글 본문 -->
	<div>${post.content}</div>
	<hr>

	<!-- 댓글 목록 -->
	<h3>댓글 목록</h3>

	<c:choose>
		<%-- 댓글 목록이 비어있거나 null인 경우 --%>
		<c:when test="${empty post.commentList}">
			<p>작성된 댓글이 없습니다.</p>
		</c:when>

		<%-- 댓글이 존재할 때만 실행 --%>
		<c:otherwise>
			<c:forEach var="comment" items="${post.commentList}">
				<div style="border-bottom: 1px solid #ccc; padding: 5px 0;">
					<strong>${comment.nickname}</strong> : ${comment.content} <small>(${comment.createdAt})
						[좋아요 ${comment.likeCount}]</small>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>

</body>
</html>