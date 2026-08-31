function popularGamesOnclickEvent(gameName){
	location.href = "/board/" + gameName;
}
function gameBoardPostClickEvent(pid){
	location.href = window.location.pathname + "/" + pid;
}
function pageMovement(currentPage, num){
	let targetPage = currentPage + num;
	location.href = window.location.pathname + "?page=" + targetPage;
}
function categoryBtnClick(gameAlias, categoryName) {
    location.href = "/board/" + gameAlias + "?page=1&category=" + encodeURIComponent(categoryName);
}
function streamingCardClick(channelId){
	location.href = "https://chzzk.naver.com/live/" + channelId;
}