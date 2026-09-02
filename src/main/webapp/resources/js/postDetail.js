function likePost(pId) {
    // JSP 전역 변수에서 contextPath 가져오기
    const contextPath = window.PAGE_CONFIG ? window.PAGE_CONFIG.contextPath : '';

    $.ajax({
        url: contextPath + '/board/' + pId + '/like',
        type: 'POST',
        success: function(response) {
            if (response.status === 'success') {
                $('#likeCount').text(response.updatedLikeCount);

                if (response.isLiked) {
                    $('#likeBtn').addClass('active');
                    alert('추천되었습니다.');
                } else {
                    $('#likeBtn').removeClass('active');
                    alert('추천이 취소되었습니다.');
                }
            } else {
                alert('처리에 실패했습니다.');
            }
        },
        error: function() {
            alert('서버 통신 중 오류가 발생했습니다.');
        }
    });
}

// 댓글 수정 폼 열기
function showEditForm(cid) {
    document.getElementById('reply-body-' + cid).style.display = 'none';
    document.getElementById('reply-edit-form-' + cid).style.display = 'flex';
}

// 댓글 수정 폼 취소
function hideEditForm(cid) {
    document.getElementById('reply-body-' + cid).style.display = 'flex';
    document.getElementById('reply-edit-form-' + cid).style.display = 'none';
}

// 뒤로가기 감지 시 이전 상세페이지 대신 게시판 목록으로 이동
window.addEventListener('popstate', function(event) {
    const contextPath = window.PAGE_CONFIG ? window.PAGE_CONFIG.contextPath : '';
    const gameAlias = window.PAGE_CONFIG ? window.PAGE_CONFIG.gameAlias : '';
    
    location.replace(contextPath + "/board/" + gameAlias);
});

// 히스토리 더미 상태 추가 (popstate 이벤트를 발생시키기 위함)
history.pushState(null, null, location.href);

// 답글
function showReplyForm(cid) {
    const form = document.getElementById("reply-form-" + cid);
    if (!form) return;

    // computedStyle을 확인하여 display 상태 검사
    const currentDisplay = window.getComputedStyle(form).display;

    if (currentDisplay === "none") {
        form.style.display = "flex";
    } else {
        form.style.display = "none";
    }
}

// 댓글 추천 클릭 함수 (이후 백엔드 API 연동 시 구현)
function likeComment(cId) {
    console.log("댓글 추천 클릭 - 댓글 ID:", cId);
    // 추후 AJAX 연동 예정
}