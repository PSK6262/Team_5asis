<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="shortcut icon" href="#">
<style>
p {
	margin: 0;
}

body {
	min-height: 100vh;
	margin: 0;
	display: flex;
	justify-content: center;
	background-color: #ffffff;
}

button {
	box-sizing: border-box;
}

/* 상단 메인 배너 */
.main {
	width: 840px;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	border-radius: 8px;
	gap: 20px;
	background: linear-gradient(to top, #417370, #c2a065);
	margin-top: 80px;
}

.banner {
	width: 800px;
	height: 200px;
	border-radius: 8px;
	display: flex;
	align-items: center;
	margin-top: 20px;
	background-color: lightgreen;
}

.profile {
	width: 100px;
	height: 100px;
	border-radius: 20%;
	background-color: lightblue;
	margin-left: 60px;
}

.nickname {
	display: flex;
	font-size: 20px;
	font-weight: bold;
	margin-left: 15px;
}

/* 유저정보 */
.middle {
	width: 800px;
	min-height: 500px;
	background-color: #ffffff;
	border-radius: 8px;
	display: flex;
	align-items: center;
	flex-direction: column;
	margin-bottom: 20px;
}

.category {
	width: 100%;
	height: 80px;
	display: flex;
	background-color: #F8F6F0;
	box-sizing: border-box;
}

.box {
	width: 25%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	box-sizing: border-box;
	background-color: #FB7185;
}

.box:last-child {
	border-right: none;
}

.box.active {
	background-color: #e9b4c3;
	font-weight: bold;
}

.info_box {
	width: 700px;
	height:auto;
	border: 1px solid black;
	border-radius: 6px;
	margin-top: 20px;
	margin-bottom: 20px;
	padding: 20px;
	box-sizing: border-box;
}

.quit_button {
	width: 80px;
	margin-left: auto;
}

.quit_button:active {
	color: red;
	border-color: red;
	border-radius: 4px;
}

input[type="text"] {
	width: 100%;
	max-width: 400px;
	min-width: 200px;
	height: 32px;
	box-sizing: border-box;
	font-size: 20px;
}

input[type="password"] {
	width: 100%;
	max-width: 400px;
	min-width: 200px;
	height: 32px;
	box-sizing: border-box;
	font-size: 20px;
}

/* 탭 전환 CSS - 기본은 전부 안보이게 설정 */
.content-item {
	display: none;
	width: 100%;
}

/* active 상태 CSS */
.content-item.active {
	display: block !important;
}

/* 내 정보 탭만 세로 배치 적용 */
#tab-info.active {
	display: flex !important;
	flex-direction: column;
	gap: 10px;
}

.is-hidden{
	display:none;
}
.updateBtn{
	width:150px;
}
</style>
</head>
<body>

	<!-- 상단 프로필 배너 -->
	<div class="main">
		<div class="banner">
			<div id="profileDiv" class="profile"></div>
			<div class="nickname">
				<p>${user.nickname}</p>

			</div>
		</div>

		<div class="middle">
			<div class="category">
				<div class="box active" data-tab="info">
					<p>내 정보</p>
				</div>
				<div class="box" data-tab="posts">
					<p>작성 글</p>
				</div>
				<div class="box" data-tab="comments">
					<p>작성 댓글</p>
				</div>
				<div class="box" data-tab="likes">
					<p>좋아요한 글</p>
				</div>
			</div>

			<div class="info_box">
				<div id="tab-info" class="content-item active">
					<p style="font-size: 15px; font-weight: bold;">이메일</p>
					<input type="text" value="${user.email}" disabled>

					<p style="font-size: 15px; font-weight: bold;">비밀번호</p>
					<input type="password" value="${user.password}" id="viewPassword" disabled>
					<div>
				    <input type="checkbox" id="showPasswordCheck">
				    <label for="showPasswordCheck">비밀번호 보기</label>
					</div>
					
					
						<button type="button" id="toggleBtnPw" class="updateBtn">비밀번호 변경하기</button>
						

					<form action="/board/mypage/update-password" method="post" id="pwUpdateForm" class="is-hidden">

						<div>
							<label for="password">새로운 비밀번호:</label> 
							<input type="text" name="password" id="password" required style="width:285px;">
						</div>

						<br>

						<div>
							<button type="submit">변경 완료</button>
						</div>

					</form>

					<p style="font-size: 15px; font-weight: bold;">닉네임</p>
					<input type="text" value="${user.nickname}" disabled>

					
						<button type="button" id="toggleBtnNickname" class="updateBtn">닉네임 변경하기</button>
						

					<form action="/board/mypage/update-nickname" method="post" id="nicknameUpdateForm" class="is-hidden">

						<div>
							<label for="nickname">새로운 닉네임:</label> 
							<input type="text" name="nickname" id="nickname" required style="width:285px;">
						</div>

						<br>

						<div>
							<button type="submit">변경 완료</button>
						</div>

					</form>
					
					
					
					<button class="quit_button">회원탈퇴</button>


				</div>
				<div id="tab-posts" class="content-item">
					<h3>📝 내 작성글 목록</h3>
					<ul>
						<li>[공략] 초보자를 위한 1~50레벨 가이드 (2026.05.10)</li>
						<li>[질문] 이번 업데이트 아이템 드랍률 질문입니다 (2026.05.02)</li>
					</ul>
				</div>
				<div id="tab-comments" class="content-item">
					<h3>💬 내 댓글 목록</h3>
					<ul>
						<li>"저도 그 아이템 얻으려고 3시간 돌았습니다 ㅠㅠ"</li>
						<li>"좋은 정보 감사합니다! 많은 도움이 되었어요."</li>
					</ul>
				</div>
				<div id="tab-likes" class="content-item">
					<h3>❤️ 좋아요한 글</h3>
					<ul>
						<li>[뉴스] 5월 대규모 패치 노트 미리보기</li>
						<li>[팬아트] 직접 그린 캐릭터 4등신 일러스트</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 스크립트 실행 타이밍 문제를 완전히 방지하기 위해 window.onload 사용
		window.onload = function() {
			const boxes = document.querySelectorAll('.box');
			const contentItems = document.querySelectorAll('.content-item');

			boxes.forEach(box => {
				box.addEventListener('click', function() {
					const targetTab = this.getAttribute('data-tab');

					// 1. 모든 탭 버튼 상단의 active 제거 후 클릭한 것에만 부여
					boxes.forEach(b => b.classList.remove('active'));
					this.classList.add('active');

					// 2. 모든 컨텐츠 영역 상단의 active 제거
					contentItems.forEach(item => {
						item.classList.remove('active');
					});

					// 3. 해당 id를 가진 컨텐츠 상단에 active 추가
					const targetElement = document.getElementById('tab-' + targetTab);
					if (targetElement) {
						targetElement.classList.add('active');
					}
				});
			});
		};
		
		document.getElementById('toggleBtnPw').addEventListener('click', function() {
		    const form = document.getElementById('pwUpdateForm');
		    
		    
		    form.classList.toggle('is-hidden');
		});
		
		document.addEventListener('DOMContentLoaded', function() {
		    const passwordInput = document.getElementById('viewPassword');
		    const showPasswordCheck = document.getElementById('showPasswordCheck');

		    // 체크박스 상태가 바뀔 때마다 실행
		    showPasswordCheck.addEventListener('change', function() {
		        if (this.checked) {
		            // 체크되면 글자가 보이도록 text로 변경
		            passwordInput.type = 'text';
		        } else {
		            // 체크 해제되면 다시 숨김 처리(password)로 변경
		            passwordInput.type = 'password';
		        }
		    });
		});
		
		document.getElementById('toggleBtnNickname').addEventListener('click', function() {
		    const form = document.getElementById('nicknameUpdateForm');
		    
		    
		    form.classList.toggle('is-hidden');
		});
		
	</script>
</body>
</html>