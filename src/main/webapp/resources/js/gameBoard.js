function popularGamesOnclickEvent(gameName){
	location.href = "/board/" + gameName;
}
function gameBoardPostClickEvent(pid){
	location.href = window.location.pathname + "/" + pid;
}
function pageMovement(currentPage, num , category){
	let targetPage = currentPage + num;
	
    const urlParams = new URLSearchParams(window.location.search);
    let currentSize = urlParams.get('pSize'); 
	
    if (!currentSize) {
        const activeSizeBtn = document.querySelector('.btn-group .btn.active');
        if (activeSizeBtn) {
            currentSize = parseInt(activeSizeBtn.textContent.trim());
        } else {
            currentSize = 5;
        }
    }
	if(category && category.trim() === '전체') {
		location.href = window.location.pathname + "?page=" + targetPage + "&pSize=" + currentSize;
	}
	else { 
		location.href = window.location.pathname + "?page=" + targetPage + "&category=" + category + "&pSize=" + currentSize;
	}
}
function categoryBtnClick(gameAlias, categoryName) {
    const currentUrlObj = new URL(window.location.href); 
    let currentSize = currentUrlObj.searchParams.get('pSize');

    if (!currentSize) {
        const activeSizeBtn = document.querySelector('.btn-group .btn.active');
        if (activeSizeBtn) {
            currentSize = parseInt(activeSizeBtn.textContent.trim());
        }
    }
    if (!currentSize || isNaN(currentSize)) {
        currentSize = '5';
    }
    location.href = "/board/" + gameAlias + "?page=1&category=" + encodeURIComponent(categoryName) + "&pSize=" + currentSize;
}

function streamingCardClick(channelId){
	location.href = "https://chzzk.naver.com/live/" + channelId;
}
function changePageSize(size) {
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('page', '1');
    currentUrl.searchParams.set('pSize', size);

    fetch(currentUrl.toString())
        .then(response => {
            if (!response.ok) throw new Error('네트워크 응답 에러');
            return response.text();
        })
        .then(html => {
            // 가상 공간 DOM
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            // 예시) size가 10이다 -> size가 10일 때의 출력을 DOM에 저장해두고, DOM에서 바꿔야 하는 부분만 가져옴
            const newTableBody = doc.querySelector('#board-table-body').innerHTML;
            document.querySelector('#board-table-body').innerHTML = newTableBody;
            const newPagination = doc.querySelector('.pagination-div').innerHTML;
            document.querySelector('.pagination-div').innerHTML = newPagination;
            // 그리고 querySelector를 이용해서, 변경하는 방식으로 새로고침 없이 출력된다.
            
            // 새로고침 효과 없이 주소창만 바꾸기
            history.pushState(null, '', currentUrl.toString());

            // 페이지 번호 몇번인지 확인 , 표시되는 개수 바꾸면 바로 1페이지로 넘어가게.
            const urlParams = new URLSearchParams(currentUrl.search);
            const currentPage = urlParams.get('page') || '1';
            document.querySelectorAll('.page-link').forEach(link => {
                link.classList.remove('active');
                if (link.textContent.trim() === currentPage) {
                    link.classList.add('active');
                }
            });
            
            // active 효과
            updateButtonState(size);
        })
        .catch(error => {
            console.error('데이터를 불러오는 중 오류가 발생했습니다:', error);
            alert('게시글 목록을 업데이트하지 못했습니다.');
        });
}

function updateButtonState(size) {
    // .btn과 .btn-group이 포함된 모든것들을 찾아서, 각각의 클래스에 active가 붙은게 있다면 삭제한다
    const docs = document.querySelectorAll('.btn-group .btn');
    docs.forEach(btn => btn.classList.remove('active'));
    
    // 저장해둔거중에 내가 원하는 size에 해당하는 버튼을 찾아서 active 붙임
    const targetBtn = Array.from(docs).find(btn => btn.textContent.trim() === (size + '개'));
    if (targetBtn) {
        targetBtn.classList.add('active');
    }
}
document.addEventListener("DOMContentLoaded",function() {
    const urlParams = new URLSearchParams(window.location.search);
    let currentPage = urlParams.get('page'); 
    
    if (!currentPage) {
        currentPage = '1';
    }
    
    const pageLinks = document.querySelectorAll('.page-link');
    
    pageLinks.forEach(link => {
        link.classList.remove('active');
        if (link.textContent.trim() === currentPage) {
            link.classList.add('active');
        }
    });
    let currentSize = urlParams.get('pSize');
    
    if (currentSize) {
        updateButtonState(currentSize); 
    } else {
        updateButtonState(5); 
    }
})