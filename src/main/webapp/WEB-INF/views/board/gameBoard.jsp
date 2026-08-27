<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게임보드 페이지</h1>
	<p>현재 어떤 게시판 ? : ${gameName}</p>
	<c:forEach var="post" items="${selectedPost}">
		<p>게시글 번호 : ${post.pid} 
		<p>게시글 제목 : ${post.title}
		<p>게시글 내용 : ${post.content}</p>
	</c:forEach>
</body>
</html>