<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 css CDN 연결 부분 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
</head>
<style>
.sideBar_container {
	width: 200px;
	height: auto;
	min-height: 100vh;
	border: 1px solid black;
	padding-left: 5px;
	padding-top: 5px;
	padding-right:5px;
}

.bg-body-tertiary {
	padding: 0px;
}

.sideBar_login {
	border: 1px solid black;
	border-radius: 5px;
	width:100%;
	padding:5px;
	margin-bottom:5px;
}
.sideBar_input{
	margin-top:5px;
	width:90%;
}
.sideBar_btn{
	margin-top:5px;
	margin-left:10px;
	border-radius:5px;
	border:1px solid black;
	font-size:15px;
	padding:5px;
}
.sideBar_board{
	/* border: 1px solid black; */
	border-radius: 5px;
	width:100%;
	padding:5px;
	margin-bottom:5px;
}
.sideBar_board_btn{
	margin-bottom:10px;
	border-radius:5px;
	border:1px solid black;
	margin-top:10px;
}
.sideBar_game{
	/* border: 1px solid black; */
	border-radius: 5px;
	width:100%;
	padding:5px;
	margin-bottom:5px;
}
.sideBar_line{
	width:100%;
	border:1px solid black;
	margin-top:5px;
	margin-bottom:10px;
}
#p_findId{
	font-size:15px;
	color:gray;
	margin-top:10px;
}
#label_board{
	margin-bottom:10px;
}
#label_game{
	margin-bottom:10px;
}
</style>
<body>
	<div class="sideBar_container">
		<div class="sideBar_login">
			<label id="label_login">로그인</label>
			<div class="sideBar_line"></div>
			<input class="sideBar_input" type="email" placeholder="E-Mail">
			<input class="sideBar_input" type="password" placeholder="password">
			<button class="sideBar_btn" type="submit">로그인</button>
			<button class="sideBar_btn" type="submit">회원가입</button>
			<p id="p_findId">아이디를 모르겠어요ㅠ</p>
		</div>
		<div class="sideBar_board">
			<div>
				<label id="label_board">게시판</label>
			</div>
			<div class="sideBar_line"></div>
			<button class="sideBar_board_btn">파티모집게시판</button>
			<br>
			<button class="sideBar_board_btn">자유게시판</button>
			<br>
			<button class="sideBar_board_btn">정보/공략</button>
			<br>
			<button class="sideBar_board_btn">질문게시판</button>
			<br>
			<button class="sideBar_board_btn">건의게시판</button>
		</div>
		<div class="sideBar_game">
			<div>
				<label id="label_game">게임</label>
			</div>
			<div class="sideBar_line"></div>
			<p>리그오브레전드</p>
			<p>배틀그라운드</p>
			<p>메이플스토리</p>
			<p>발로란트</p>
			<p>팰월드</p>
			<p>레이디버그</p>
		</div>
	</div>
	<!-- 부트스트랩 스크립트 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
	<script>
		
	</script>
</body>
</html>