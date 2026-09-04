<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<title>마이페이지</title> 

<style>
/* 1. 기본 설정 및 초기화 */
p {
    margin: 0;
}

body {
    min-height: 100vh;
    margin: 0;
    background-color: #ffffff;
    font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
    color: #333333;
    
    
    
}

button {
    box-sizing: border-box;
    cursor: pointer;
    font-family: inherit;
}

input {
    font-family: inherit;
}

/* 2. 상단 메인 배너 영역 */
.main {
    width: 840px;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 12px;
    gap: 20px;
    background-color: #fdfbf7;
    margin-top: 40px;
    margin-bottom: 40px;
    margin-left: 70px;
    margin-right: auto;
    padding: 40px 0;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
}

.banner {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-top: 10px;
}

/* 프로필 이미지 감싸는 박스 (따뜻한 코랄/오렌지 포인트) */
#profileDiv.profile {
    position: relative;
    padding: 4px;
    background: linear-gradient(135deg, #ff9a9e, #fad0c4);
    border-radius: 30%;
    box-shadow: 0 6px 15px rgba(255, 154, 158, 0.3);
    transition: transform 0.3s ease;
}

#profileDiv.profile:hover {
    transform: translateY(-3px);
}

#profileDiv.profile img {
    display: block;
    border-radius: 27%;
    object-fit: cover;
    background-color: #ffffff;
}

/* 파일 업로드 및 버튼 폼 영역 */
.banner form {
    margin-top: 20px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    width: 100%;
}

.banner input[type="file"] {
    font-size: 13px;
    color: #666666;
    padding: 8px;
    border: 1px dashed #dcd6cd;
    border-radius: 8px;
    background-color: #ffffff;
    width: 260px;
    cursor: pointer;
    transition: border-color 0.2s ease;
}

.banner input[type="file"]:hover {
    border-color: #ff9a9e;
}

/* 프로필 사진 적용 버튼 */
.banner button[type="submit"] {
    background: #e07a5f;
    color: white;
    border: none;
    padding: 8px 18px;
    font-size: 13px;
    font-weight: 600;
    border-radius: 6px;
    box-shadow: 0 3px 8px rgba(224, 122, 95, 0.25);
    transition: all 0.2s ease;
    margin-left: 0 !important;
}

.banner button[type="submit"]:hover {
    background: #cc6b50;
    transform: translateY(-1px);
}

.banner button[type="submit"]:active {
    transform: translateY(1px);
}

.nickname {
    display: flex;
    font-size: 20px;
    font-weight: bold;
    margin-left: 15px;
    color: #2c2c2c;
}

/* 3. 유저 정보 영역 (.middle) */
.middle {
    width: 780px;
    min-height: 450px;
    background-color: #ffffff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    flex-direction: column;
    margin-bottom: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
    overflow: hidden; /* 카테고리 둥근 모서리 맞춤 */
    border: 1px solid #f0ebe1;
}

/* 카테고리 탭 메뉴 */
.category {
    width: 100%;
    height: 60px;
    display: flex;
    background-color: #F8F6F0;
    box-sizing: border-box;
    flex-wrap: nowrap;
}

.box {
    width: 25%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    box-sizing: border-box;
    background-color: #f4f0eb;
    color: #777777;
    font-weight: 500;
    font-size: 14px;
    border-bottom: 2px solid transparent;
    transition: all 0.2s ease;
    white-space: nowrap; 
    overflow: hidden;
}

.box:hover {
    background-color: #efeae1;
    color: #333333;
}

.box.active {
    background-color: #ffffff;
    color: #e07a5f;
    font-weight: bold;
    border-bottom: 2px solid #e07a5f;
}

/* 정보 박스 및 입력창 스타일 */
.info_box {
    width: 700px;
    height: auto;
    border: 1px solid #e6dfd5;
    border-radius: 8px;
    margin-top: 25px;
    margin-bottom: 25px;
    padding: 24px;
    box-sizing: border-box;
    background-color: #ffffff;
}

input[type="text"],
input[type="password"] {
    width: 100%;
    max-width: 400px;
    min-width: 200px;
    height: 38px;
    padding: 0 12px;
    box-sizing: border-box;
    font-size: 15px;
    border: 1px solid #dcd6cd;
    border-radius: 6px;
    outline: none;
    transition: border-color 0.2s ease;
}

input[type="text"]:focus,
input[type="password"]:focus {
    border-color: #e07a5f;
}

/* 버튼 및 기타 공통 클래스 */
.quit_button {
    width: 84px;
    height: 32px;
    margin-left: auto;
    background: transparent;
    border: 1px solid #dcd6cd;
    border-radius: 6px;
    color: #666666;
    transition: all 0.2s ease;
}

.quit_button:hover {
    border-color: #e63946;
    color: #e63946;
}

.quit_button:active {
    background-color: #ffe5e7;
}

.updateBtn {
    width: 150px;
    height: 38px;
    background-color: #3d405b;
    color: white;
    border: none;
    border-rem: 6px;
    border-radius: 6px;
    font-weight: 600;
    transition: background-color 0.2s ease;
}

.updateBtn:hover {
    background-color: #2f3248;
}

/* 탭 전환 시스템 */
.content-item {
    display: none;
    width: 100%;
}

.content-item.active {
    display: block !important;
}

#tab-info.active {
    display: flex !important;
    flex-direction: column;
    gap: 15px;
    align-items: center;
}

.is-hidden {
    display: none !important;
}

table {
    width: 100%;
    table-layout: fixed; /* [핵심] 셀 안의 내용에 따라 테이블이 지멋대로 늘어나거나 깨지는 현상 방지 */
    border-collapse: collapse;
    border-spacing: 10px 0px;
}
td {
	white-space: nowrap;
	overflow: hidden;
    text-overflow: ellipsis;
}
</style>

</head>

<body>
<%@ include file="../common/navbar.jsp" %>
	<div class="pagebody d-flex align-items-stretch" style="min-height: 100vh;">
		<%@ include file="../common/sidebar.jsp" %>
		<div class="pagebody-rightside flex-grow-1">
			<div class="content-header-nav mb-3">
			    <nav aria-label="breadcrumb">
			        <ol class="breadcrumb mb-0">
			            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/main">홈</a></li>
			            <li class="breadcrumb-item active" aria-current="page">${gameName}</li>
			        </ol>
			    </nav>
			</div>
	<!-- 상단 프로필 배너 -->
	<div class="main">
		<div class="banner">
			<div id="profileDiv" class="profile">
        <c:choose>
            <%-- 1. 등록된 프로필 사진이 없을 때 기본 이미지 출력 --%>
            <c:when test="${empty profileImage}">
                <img src="${pageContext.request.contextPath}/resources/img/default_profile.png" width="100" height="100" style="border-radius: 20%; object-fit: cover;">
            </c:when>
            <%-- 2. 등록된 프로필 사진이 있을 때 해당 경로 이미지 출력 --%>
            <c:otherwise>
                <img src="${profileImage.URL_FILE_PATH}" width="100" height="100" style="border-radius: 20%; object-fit: cover;">
            </c:otherwise>
        </c:choose>
    </div>
    <form action="${pageContext.request.contextPath}/board/mypage/update-profile-img" method="post" enctype="multipart/form-data" style="margin-top: 15px; text-align: center;">
    <input type="file" name="uploadFile" accept="img/*" required>
    <button type="submit" style="margin-left: 5px;">프로필 사진 적용하기</button>
</form>
    
   
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
					<input type="password" value="${user.password}" id="viewPassword"
						disabled>
					<div>
						<input type="checkbox" id="showPasswordCheck"> <label
							for="showPasswordCheck">비밀번호 보기</label>
					</div>


					<button type="button" id="toggleBtnPw" class="updateBtn">비밀번호
						변경하기</button>


					<form action="/board/mypage/update-password" method="post"
						id="pwUpdateForm" class="is-hidden">

						<div>
							<label for="password">새로운 비밀번호:</label> <input type="text"
								name="password" id="password" required style="width: 285px;">
						</div>

						<br>

						<div>
							<button type="submit" class="updateBtn">변경 완료</button>
						</div>

					</form>

					<p style="font-size: 15px; font-weight: bold;">닉네임</p>
					<input type="text" value="${user.nickname}" disabled>


					<button type="button" id="toggleBtnNickname" class="updateBtn">닉네임
						변경하기</button>


					<form action="/board/mypage/update-nickname" method="post"
						id="nicknameUpdateForm" class="is-hidden">

						<div>
							<label for="nickname">새로운 닉네임:</label> <input type="text"
								name="nickname" id="nickname" required style="width: 285px;">
						</div>

						<br>

						<div>
							<button type="submit" class="updateBtn">변경 완료</button>
						</div>

					</form>



					<button class="quit_button">회원탈퇴</button>


				</div>
				<div id="tab-posts" class="content-item">


					<h3>📝 내 작성글 목록</h3>
					
					<table >
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">카테고리</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
								<th scope="col">조회수</th>
								<th scope="col">추천</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>

								<c:when test="${empty myPostList}">
									<tr>
										<td colspan="6" class="text-center">작성한 게시글이 없습니다.</td>
									</tr>
								</c:when>


								<c:otherwise>
									<c:forEach var="post" items="${myPostList}">

										<tr style="cursor: pointer;"
											onclick="location.href='/board/${post.gameAlias}/${post.pid}'">
											<th scope="row">${post.pid}</th>
											<td>${post.category}</td>
											<td>${post.title}</td>
											<td>${post.createdAt}</td>
											<td>${post.viewCount}</td>
											<td>${post.likeCount}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<div id="tab-comments" class="content-item">
					<h3>💬 내 댓글 목록</h3>

					<table class="comment-table">
						<thead>
							<tr>
								<th>게임</th>
								<th>댓글 내용</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<%-- 댓글 리스트가 비어있거나 없는 경우 --%>
								<c:when test="${empty commentList}">
									<tr>
										<td colspan="4" class="no-data">작성한 댓글이 없습니다.</td>
									</tr>
								</c:when>

								<%-- 댓글 리스트가 있는 경우 반복문 출력 --%>
								<c:otherwise>
									<c:forEach var="comment" items="${commentList}">
										<tr>

											<td class="game-alias"><span>${comment.gameAlias}</span>
											</td>


											<td class="comment-content"><a style="cursor: pointer;"
												onclick="location.href='/board/${comment.gameAlias}/${comment.pid} '">
													${comment.content} </a></td>

											<!-- 조회 수 -->
											<td class="view-count">${comment.viewCount}</td>

											<!-- 작성일  -->
											<td class="created-at"><c:out
													value="${comment.createdAt}" /></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>


				</div>
				<div id="tab-likes" class="content-item">
					<h3>❤️ 추천한 글</h3>
					<table class="post-table">
						<thead>
							<tr>
								<th>카테고리</th>
								<th>제목</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty postList}">
									<tr>
										<td colspan="4">추천한 게시글이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="post" items="${postList}">
										<tr>
											<td><span>${post.gameAlias}</span></td>
											<td><a href="/board/${post.gameAlias}/${post.pid}">${post.title}</a></td>
											<td>${post.viewCount}</td>
											<td>${post.createdAt}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</div>	

	<script>
		// 스크립트 실행 타이밍 문제를 완전히 방지하기 위해 window.onload 사용
		document.addEventListener('DOMContentLoaded', function() {
    // 1. 탭 전환 기능
    const boxes = document.querySelectorAll('.box');
    const contentItems = document.querySelectorAll('.content-item');

    boxes.forEach(box => {
        box.addEventListener('click', function() {
            const targetTab = this.getAttribute('data-tab');

            boxes.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            contentItems.forEach(item => {
                item.classList.remove('active');
            });

            const targetElement = document.getElementById('tab-' + targetTab);
            if (targetElement) {
                targetElement.classList.add('active');
            }
        });
    });

    // 2. 비밀번호 변경 토글 버튼
    const toggleBtnPw = document.getElementById('toggleBtnPw');
    if (toggleBtnPw) {
        toggleBtnPw.addEventListener('click', function() {
            const form = document.getElementById('pwUpdateForm');
            if (form) form.classList.toggle('is-hidden');
        });
    }

    // 3. 비밀번호 보기 체크박스
    const passwordInput = document.getElementById('viewPassword');
    const showPasswordCheck = document.getElementById('showPasswordCheck');
    if (showPasswordCheck && passwordInput) {
        showPasswordCheck.addEventListener('change', function() {
            passwordInput.type = this.checked ? 'text' : 'password';
        });
    }

    // 4. 닉네임 변경 토글 버튼
    const toggleBtnNickname = document.getElementById('toggleBtnNickname');
    if (toggleBtnNickname) {
        toggleBtnNickname.addEventListener('click', function() {
            const form = document.getElementById('nicknameUpdateForm');
            if (form) form.classList.toggle('is-hidden');
        });
    }
});
		
		function moveBoard(gameAlias, pId) {
		    if (!gameAlias || gameAlias === 'null' || !pId || pId === 'null') {
		        alert('올바르지 않은 게시글 정보입니다.');
		        return;
		    }
		    location.href = '/board/' + gameAlias + '/' + pId;
		}
	</script>
</body>
</html>