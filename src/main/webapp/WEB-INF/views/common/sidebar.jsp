<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagebody-leftside">
	<form class="p-4">
		<div class="form-group">
			<label for="leftside-login-id">아이디</label> <input type="email"
				class="form-control" id="leftside-login-id"
				placeholder="email@example.com">
		</div>
		<div class="form-group">
			<label for="leftside-login-pw">비밀번호</label> <input type="password"
				class="form-control" id="leftside-login-pw" placeholder="Password">
		</div>
		<div class="form-check">
			<input type="checkbox" class="form-check-input" id="dropdownCheck2">
			<label class="form-check-label" for="dropdownCheck2"> 아이디 기억
			</label>
		</div>
		<button type="submit" class="btn btn-primary" id="leftside-login-btn">로그인</button>
	</form>
	<div class="pagebody-leftside-gameboard-list">
		<div class="popular-games-header">
			<h5>인기 게시판 TOP 6</h5>
		</div>
		<c:forEach var="game" items="${popularSixGames}">
			<p>
				<label class="popular-games-label"
					onclick="popularGamesOnclickEvent('${game.gameAlias}')">${game.gameName}</label>
			</p>
		</c:forEach>
	</div>
</div>