<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<style>
.sideBar_container {
	display: grid;
	grid-template-rows: auto auto auto; /* 로그인, 게시판, 게임 */
	gap: 20px;
	background-color: #f5f5f5;
	padding: 15px;
	width: 200px;
}

/* 공통 라벨 */
.sideBar_container label {
	font-weight: bold;
	font-size: 14px;
}

/* 구분선 */
.sideBar_line {
	border-bottom: 1px solid #ccc;
	margin: 8px 0;
}

/* 로그인 영역 */
.sideBar_login {
	display: grid;
	grid-template-rows: auto;
	gap: 10px;
}

.sideBar_input {
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 5px;
}

.sideBar_btn {
	padding: 6px;
	border: none;
	background-color: #3e726f;
	color: white;
	border-radius: 4px;
	cursor: pointer;
	margin-bottom: 5px;
}

.sideBar_btn:hover {
	background-color: #2f5a56;
}

#p_findId:hover {
	cursor: pointer;
	font-weight: bold;
}

/* 게시판/게임 링크 */
.sideBar_links {
	display: grid;
	grid-template-rows: repeat(auto-fill, minmax(20px, auto));
	gap: 6px;
}

.sideBar_links a {
	text-decoration: none;
	color: #333;
	font-size: 13px;
	padding: 4px 0;
}

.sideBar_links a:hover {
	color: #3e726f;
	font-weight: bold;
}
</style>
<body>
	<div class="sideBar_container">
		<!-- 로그인 -->
		<div class="sideBar_login">
			<form>
				<label id="label_login">로그인</label>
				<div class="sideBar_line"></div>
				<input class="sideBar_input" type="email" placeholder="E-Mail" required> <input class="sideBar_input" type="password" placeholder="Password" required>
				<button class="sideBar_btn" type="submit">로그인</button>
				<button class="sideBar_btn" type="button">회원가입</button>
				<p id="p_findId">아이디를 모르겠어요ㅠ</p>
			</form>
		</div>

		<!-- 게시판 -->
		<div class="sideBar_board">
			<label id="label_board">게시판</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_links">
				<a href="/board/party">파티모집게시판</a> <a href="/board/free">자유게시판</a> <a href="/board/info">정보/공략</a> <a href="/board/question">질문게시판</a> <a href="/board/suggestion">건의게시판</a>
			</div>
		</div>

		<!-- 게임 -->
		<div class="sideBar_game">
			<label id="label_game">게임</label>
			<div class="sideBar_line"></div>
			<div class="sideBar_links">
				<a href="/board/lol">리그오브레전드</a> <a href="/board/pubg">배틀그라운드</a> <a href="/board/maple">메이플스토리</a> <a href="/board/val">발로란트</a> <a href="/board/ow2">오버워치2</a> <a href="/board/lostark">로스트아크</a>
			</div>
		</div>
	</div>
	<!-- 부트스트랩 스크립트 -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script> -->
	<script>
		document.getElementById("p_findId").addEventListener('click', ()=>{
			location.href="https://naver.com";
		})
	</script>
</body>
</html>
