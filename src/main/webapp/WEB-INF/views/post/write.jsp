<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

body {
	background-color: #f5f5f5;
	font-family: Arial, sans-serif;
	color: #333;
}

/* 전체 영역 */
.page-container {
	width: 100%;
	min-height: 100vh;
	display: flex;
	justify-content: center;
}

/* 가운데 작성 영역 */
.write-container {
	width: 900px;
	min-height: 700px;
	margin: 50px 0;
	padding: 40px 50px;
	background-color: white;
	border-radius: 8px;
	/* 그라데이션 테두리 */
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

/* 제목 */
.page-title {
	margin-bottom: 35px;
	font-size: 28px;
	font-weight: bold;
}

/* 입력 영역 */
.form-group {
	margin-bottom: 25px;
}

.form-label {
	display: block;
	margin-bottom: 10px;
	font-size: 16px;
	font-weight: bold;
}

/* 카테고리 */
.category-select {
	width: 220px;
	height: 42px;
	padding: 0 12px;
	border: 0.5px solid #ddd;
	border-radius: 8px;
	font-size: 14px;
	background-color: white;
}

/* 제목 입력 */
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

/* 내용 */
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

/* 버튼 영역 */
.button-area {
	display: flex;
	justify-content: flex-end; /* 오른쪽 배치 */
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

/* 등록 버튼 기본 설정 */
.btn-submit {
	background-color: #333;
	color: white;
	transition: all 0.5s ease;
}

/* 등록 버튼 Hover 효과 */
.btn-submit:hover {
	/* 2색 그라데이션 */
	background: linear-gradient(135deg, #2F7778, #E0B85A);
	/* 위로 2px 이동 (입체감) */
	transform: translateY(-2px);
	opacity: 1;
}

/* 클릭했을 때 살짝 눌리는 효과*/
.btn-submit:active {
	transform: translateY(2px);
	box-shadow: 0 3px 8px rgba(79, 70, 229, 0.4);
}
</style>
</head>

<body>

	<div class="page-container">

		<div class="write-container">

			<h1 class="page-title">게시글 작성</h1>

			<div class="form-group">
				<label class="form-label">카테고리</label> <select class="category-select">
					<option value="파티모집">파티모집</option>
					<option value="정보">정보</option>
					<option value="공략">공략</option>
					<option value="질문">질문</option>
					<option value="자유">자유</option>
				</select>
			</div>

			<div class="form-group">
				<label class="form-label">제목</label> <input type="text"
					class="title-input" placeholder="제목을 입력하세요.">
			</div>

			<div class="form-group">
				<label class="form-label">내용</label>

				<textarea class="content-textarea" placeholder="내용을 입력하세요."></textarea>
			</div>

			<div class="button-area">
				<button type="button" class="btn btn-cancel">취소</button>

				<button type="button" class="btn btn-submit">등록</button>
			</div>

		</div>

	</div>

</body>
</html>