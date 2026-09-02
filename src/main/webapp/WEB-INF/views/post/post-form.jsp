<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${isEdit ? '게시글 수정' : '게시글 작성'}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/postForm.css">
</head>
<body>

	<div class="page-container">
    <div class="write-container">

        <!-- 1. 페이지 제목 분기 -->
        <h1 class="page-title">${isEdit ? '게시글 수정' : '게시글 작성'}</h1>

		<!-- Form Action URL 분기 -->
		<form id="postForm" 
		      action="${pageContext.request.contextPath}/board/${gameAlias}/${isEdit ? post.pid : ''}${isEdit ? '/edit' : '/write'}"
		      method="post">

            <!-- 카테고리 선택 -->
            <div class="form-group">
                <label class="form-label">카테고리</label>
                <select name="category" class="category-select" required>
                    <option value="" disabled ${empty post.category ? 'selected' : ''}>카테고리 선택</option>
                    <option value="파티모집" ${post.category == '파티모집' ? 'selected' : ''}>파티모집</option>
                    <option value="정보" ${post.category == '정보' ? 'selected' : ''}>정보</option>
                    <option value="공략" ${post.category == '공략' ? 'selected' : ''}>공략</option>
                    <option value="질문" ${post.category == '질문' ? 'selected' : ''}>질문</option>
                    <option value="자유" ${post.category == '자유' ? 'selected' : ''}>자유</option>
                </select>
            </div>

            <!-- 제목 입력 -->
            <div class="form-group">
                <label class="form-label">제목</label>
                <input type="text" name="title" class="title-input" 
                       value="${post.title}" placeholder="제목을 입력하세요" required>
            </div>

            <!-- 내용 입력 -->
            <div class="form-group">
                <label class="form-label">내용</label>
                <textarea name="content" class="content-textarea" 
                          placeholder="내용을 입력하세요" required>${post.content}</textarea>
            </div>

            <!-- 버튼 영역 -->
            <div class="button-area">
                <button type="button" class="btn btn-cancel" onclick="cancelForm()">취소</button>
                <button type="submit" class="btn btn-submit">${isEdit ? '수정' : '등록'}</button>
            </div>

        </form>

    </div>
</div>

<!-- JS 파일 로드 전에 JSP 변수를 window 객체에 할당 -->
<script>
    window.PAGE_CONFIG = {
        isEdit: ${isEdit},
        gameAlias: "${gameAlias}",
        pid: "${post.pid}",
        contextPath: "${pageContext.request.contextPath}"
    };
</script>

<!-- 외부 JS 파일 로드 -->
<script src="${pageContext.request.contextPath}/resources/js/postForm.js"></script>


</body>
</html>