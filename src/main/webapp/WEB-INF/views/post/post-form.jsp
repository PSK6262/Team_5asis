<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${isEdit ? '게시글 수정' : '게시글 작성'}</title>
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

.page-container {
	width: 100%;
	min-height: 100vh;
	display: flex;
	justify-content: center;
}

.write-container {
	width: 900px;
	min-height: 700px;
	margin: 50px 0;
	padding: 40px 50px;
	background-color: white;
	border-radius: 8px;
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

.page-title {
	margin-bottom: 35px;
	font-size: 28px;
	font-weight: bold;
}

.form-group {
	margin-bottom: 25px;
}

.form-label {
	display: block;
	margin-bottom: 10px;
	font-size: 16px;
	font-weight: bold;
}

.category-select {
	width: 220px;
	height: 42px;
	padding: 0 12px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 14px;
	background-color: white;
}

.title-input {
	width: 100%;
	height: 48px;
	padding: 0 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
}

.title-input:focus, .content-textarea:focus, .category-select:focus {
	border-color: #999;
}

.content-textarea {
	width: 100%;
	height: 350px;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	resize: none;
	font-size: 15px;
	line-height: 1.6;
	outline: none;
}

.button-area {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 35px;
}

.btn {
	width: 110px;
	height: 45px;
	border: none;
	border-radius: 5px;
	font-size: 15px;
	cursor: pointer;
}

.btn-cancel {
	background-color: #e9e9e9;
	color: #555;
	transition: all 0.4s ease;
}

.btn-cancel:hover {
	background-color: #b1b3b1;
	transform: translateY(-2px);
}

.btn-cancel:active {
	transform: translateY(2px);
	box-shadow: 0 3px 8px rgba(79, 70, 229, 0.4);
}

.btn-submit {
	background-color: #333;
	color: white;
	transition: all 0.5s ease;
}

.btn-submit:hover {
	background: linear-gradient(135deg, #2F7778, #E0B85A);
	transform: translateY(-2px);
}

.btn-submit:active {
	transform: translateY(2px);
	box-shadow: 0 3px 8px rgba(79, 70, 229, 0.4);
}
</style>

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

<script>
    function cancelForm() {
        var isEdit = ${isEdit};
        var msg = isEdit ? "수정을 취소하시겠습니까?\n입력한 내용은 저장되지 않습니다." 
                         : "작성을 취소하시겠습니까?\n입력한 내용은 저장되지 않습니다.";
        
        if (confirm(msg)) {
            if (isEdit) {
                location.href = "${pageContext.request.contextPath}/board/${gameAlias}/${post.pid}";
            } else {
                location.href = "${pageContext.request.contextPath}/board/${gameAlias}";
            }
        }
    }
</script>

</body>
</html>