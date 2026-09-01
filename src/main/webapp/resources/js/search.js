function popularGamesOnclickEvent(gameName){
	location.href = "/board/" + gameName;
}
function gameBoardPostClickEvent(gameAlias,pid){
	location.href = "/board/" + gameAlias + "/" + pid;
}
function streamingCardClick(channelId){
	location.href = "https://chzzk.naver.com/live/" + channelId;
}
function gameBoardClickEvent(gameAlias){
	location.href = "/board/" + gameAlias;
}