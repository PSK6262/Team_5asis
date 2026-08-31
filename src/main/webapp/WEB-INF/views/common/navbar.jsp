<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar bg-body-tertiary">
	<div
		class="container-fluid d-flex justify-content-between align-items-center">
		<div id="navbarLeftMost">
			<a class="navbar-brand" href="#">5ASIS</a>
		</div>
		<form class="form-inline my-2 my-lg-0" id="centerSearchBar"
			action="/board/search" method="get">
			<div class="input-group">
				<select class="form-select flex-grow-0" name="type"
					style="width: auto; max-width: 110px; border-top-right-radius: 0; border-bottom-right-radius: 0;">
					<option value="all" ${param.type == 'all' ? 'selected' : ''}>전체</option>
					<option value="user" ${param.type == 'user' ? 'selected' : ''}>사용자</option>
					<option value="content"	${param.type == 'content' ? 'selected' : ''}>내용</option>
					<option value="title" ${param.type == 'title' ? 'selected' : ''}>제목</option>
				</select>
				<div class="position-relative d-flex align-items-center flex-grow-1">
					<svg xmlns="http://w3.org" width="16" height="16"
						fill="currentColor"
						class="bi bi-search position-absolute ms-2 text-muted"
						viewBox="0 0 16 16" style="z-index: 5;">
				      <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
				    </svg>
					<input class="form-control ps-4" type="search"
						placeholder="게임, 게시글 검색.." aria-label="Search" name="keyword"
						value="${keyword}"
						style="border-top-left-radius: 0; border-bottom-left-radius: 0;">
				</div>
			</div>
		</form>
		<button class="btn btn-info" id="navbarLoginButton">로그인</button>
	</div>
</nav>