$(document).ready(function() {
        $(".product__filter .mix").not(".sale").hide();
});

const url = new URL(window.location.href);

const message = url.searchParams.get("message");
const alertType = url.searchParams.get("alert");

if (message && alertType) {
    if(message==="not_permission_access"){
    alert("Không được phép truy cập");
}
    // Xóa các tham số từ URL
    url.searchParams.delete("message");
    url.searchParams.delete("alert");

    // Chuyển hướng đến URL mới (không có tham số)
    window.history.replaceState({}, document.title, url.pathname);

}

// static/js/web/home/home.js
document.addEventListener('DOMContentLoaded', () => {
    // Xử lý background cho product__item__pic
    document.querySelectorAll('.product__item__pic').forEach(element => {
        const bgUrl = element.dataset.bgUrl;
        element.style.setProperty('--bg-image', `url(${bgUrl})`);
    });

    // Xử lý sự kiện add-cart
    document.querySelectorAll('.add-cart').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            window.location.href = link.href;
        });
    });
});


