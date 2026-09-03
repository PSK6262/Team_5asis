document.getElementById('btn_goLogin').addEventListener('click', () => {
    if (document.getElementById('btn_goLogin').textContent.trim() == "로그인") {
        location.href = "/user/login";
    } else {
        location.href = "/user/logout";
    }
})

document.getElementById('img_logo').addEventListener('click', () => {
    location.href = "/main";
})