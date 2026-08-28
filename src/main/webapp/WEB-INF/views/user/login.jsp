<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 테스트</title>
</head>
<body>

    <h2>로그인 화면 테스트</h2>

    <form action="/user/login" method="post">
        <div>
            <label>아이디: </label>
            <input type="text" name="userId">
        </div>
        <div style="margin-top: 10px;">
            <label>비밀번호: </label>
            <input type="password" name="userPw">
        </div>
        <div style="margin-top: 10px;">
            <button type="submit">로그인 전송</button>
        </div>
    </form>

</body>
</html>