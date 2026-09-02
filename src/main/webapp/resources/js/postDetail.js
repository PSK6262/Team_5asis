// 게시글 추천 기능
function likePost(pId) {
    const contextPath = window.PAGE_CONFIG ? window.PAGE_CONFIG.contextPath : '';

    $.ajax({
        url: contextPath + '/board/' + pId + '/like',
        type: 'POST',
        success: function(response) {
            // 1. 비로그인 상태 체크
            if (response.status === 'require_login') {
                alert('로그인 후 이용 가능합니다.');
                location.href = contextPath + '/user/login'; // 로그인 페이지로 이동
                return;
            }

            // 2. 추천 성공 처리
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

// 히스토리 더미 상태 추가
history.pushState(null, null, location.href);

// 답글 폼 토글
function showReplyForm(cid) {
    const form = document.getElementById("reply-form-" + cid);
    if (!form) return;

    const currentDisplay = window.getComputedStyle(form).display;

    if (currentDisplay === "none") {
        form.style.display = "flex";
    } else {
        form.style.display = "none";
    }
}

// 댓글 추천 기능
function likeComment(cId) {
    const contextPath = window.PAGE_CONFIG ? window.PAGE_CONFIG.contextPath : '';
    const gameAlias = window.PAGE_CONFIG ? window.PAGE_CONFIG.gameAlias : '';

    $.ajax({
        url: contextPath + '/board/' + gameAlias + '/' + window.PAGE_CONFIG.pId + '/comment/' + cId + '/like',
        type: 'POST',
        success: function(response) {
            // 1. 비로그인 상태 체크
            if (response.status === 'require_login') {
                alert('로그인 후 이용 가능합니다.');
                location.href = contextPath + '/user/login'; // 로그인 페이지로 이동
                return;
            }

            // 2. 추천 성공 처리
            if (response.status === 'success') {
                $('#comment-like-count-' + cId).text(response.updatedLikeCount);

                const $likeBtn = $('#comment-like-btn-' + cId);
                
                if (response.isLiked) {
                    $likeBtn.addClass('active');
                    alert('댓글을 추천했습니다.');
                } else {
                    $likeBtn.removeClass('active');
                    alert('댓글 추천을 취소했습니다.');
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

// 페이지 로드 시 이벤트 등록
document.addEventListener('DOMContentLoaded', function() {
    const replyForm = document.querySelector('.reply-form');
    
    if (replyForm) {
        replyForm.addEventListener('submit', function(e) {
            // 비로그인 상태일 때
            if (!window.PAGE_CONFIG || !window.PAGE_CONFIG.isLoggedIn) {
                e.preventDefault(); // 폼 제출 중단
                alert('로그인 후 이용 가능합니다.');
                location.href = window.PAGE_CONFIG.contextPath + '/user/login';
            }
        });
    }
});