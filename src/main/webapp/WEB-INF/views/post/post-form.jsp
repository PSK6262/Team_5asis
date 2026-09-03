<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${isEdit ? '게시글 수정' : '게시글 작성'}</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/navbar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/postForm.css">
</head>
<body>

	<%@ include file="../common/navbar.jsp"%>

	<div class="pagebody d-flex align-items-stretch"
		style="min-height: 100vh;">

		<%@ include file="../common/sidebar.jsp"%>

		<div class="pagebody-rightside flex-grow-1">

			<div class="page-container">
				<div class="write-container">

					<h1 class="page-title">${isEdit ? '게시글 수정' : '게시글 작성'}</h1>

					<form id="postForm"
				      action="${pageContext.request.contextPath}/board/${gameAlias}/${isEdit ? post.pid : ''}${isEdit ? '/edit' : '/write'}"
				      method="post"
				      enctype="multipart/form-data">

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
							<input type="text" name="title" class="title-input" value="${post.title}" placeholder="제목을 입력하세요" required>
						</div>

						<!-- 이미지 첨부 (본문 삽입용) -->
						<div class="form-group">
							<label for="imageInput" class="upload-label">📷 이미지 첨부 (본문 자동 삽입)</label>
							<input type="file" name="imageFiles" id="imageInput" class="file-input-hidden" accept="image/*" multiple>
						</div>

						<!-- 내용 입력 -->
						<div class="form-group">
							<label class="form-label">내용</label>
							<div id="editor" class="content-editor" contenteditable="true" placeholder="내용을 입력하세요">${post.content}</div>
							<input type="hidden" name="content" id="hiddenContent">
						</div>

						<!-- 일반 파일 첨부 -->
						<div class="form-group">
						    <label for="fileInput" class="upload-label">📎 일반 파일 첨부</label>
						    
							<c:if test="${isEdit and not empty existingFiles}">
							    <div class="existing-files-wrapper" style="margin-bottom: 12px; padding: 10px; background-color: #f1f3f5; border-radius: 6px;">
							        <p style="margin: 0 0 8px 0; font-weight: bold; font-size: 13px; color: #495057;">기존 첨부파일 (삭제할 파일 체크):</p>
							        <ul style="list-style: none; padding-left: 0; margin: 0;">
							            <c:forEach var="exFile" items="${existingFiles}">
							                <c:set var="exFileName" value="${exFile.mediaUrl.substring(exFile.mediaUrl.indexOf('_') + 1)}" />
							                <li style="margin-bottom: 4px;">
							                    <label style="cursor: pointer; font-size: 14px; color: #333;">
							                        <input type="checkbox" name="deleteFileMids" value="${exFile.mid}" class="file-delete-chk" style="margin-right: 6px;">
							                        <span class="delete-label" style="color: #dc3545; font-weight: bold;">[삭제]</span> ${exFileName}
							                    </label>
							                </li>
							            </c:forEach>
							        </ul>
							    </div>
							</c:if>
						
						    <input type="file" name="attachedFiles" id="fileInput" class="file-input-hidden" multiple>
						    <ul id="fileList" class="file-list"></ul>
						</div>

						<!-- 버튼 영역 -->
						<div class="button-area">
							<button type="button" class="btn btn-cancel" onclick="cancelForm()">취소</button>
							<button type="submit" class="btn btn-submit">${isEdit ? '수정' : '등록'}</button>
						</div>

					</form>
				</div>
			</div>

		</div>
	</div>

	<script>
		window.PAGE_CONFIG = {
		    isEdit: ${isEdit ? true : false},
		    gameAlias: "${gameAlias}",
		    pid: "${not empty post.pid ? post.pid : 0}",
		    contextPath: "${pageContext.request.contextPath}"
		};
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/postForm.js"></script>
</body>
</html>