
    document.addEventListener("DOMContentLoaded", () => {
    const chatButton = document.getElementById("chat-button");
    const chatBox = document.getElementById("chat-box");
    const closeChat = document.getElementById("close-chat");
    const messages = document.getElementById('messages');

    function showWelcomeMessage() {
    var messageContainer = document.createElement('div');
    messageContainer.classList.add('message-container');
    var avatar = document.createElement('img');
    avatar.src = '/static/img/avatar/chatbot.png';
    avatar.classList.add('avatar');
    var messageText = document.createElement('p');
    messageText.textContent = "Chào bạn! Bạn muốn hỏi về vấn đề gì? (ví dụ: sản phẩm, vận chuyển, hỗ trợ, một mặt hàng cụ thể, ...)";
    messageContainer.appendChild(avatar);
    messageContainer.appendChild(messageText);
    messages.appendChild(messageContainer);
    messages.scrollTop = messages.scrollHeight;
}

    loadMessagesFromSession();

    // Mở hoặc đóng hộp chat
    chatButton.addEventListener("click", () => {
    chatBox.classList.toggle("d-none");
    if (messages.children.length === 0) {
    showWelcomeMessage();
}
});

    closeChat.addEventListener("click", () => {
    chatBox.classList.add("d-none");
});
});

    // WebSocket kết nối tới server
    var socket = new WebSocket('ws://103.126.161.11/chat');

    socket.onopen = function() {
    console.log("Connected to the WebSocket server");
};

    socket.onmessage = function(event) {
    var messages = document.getElementById('messages');
    var messageContainer = document.createElement('div');

    messageContainer.classList.add('message-container', 'server-message');
    var avatar = document.createElement('img');
    avatar.src = '/static/img/avatar/chatbot.png';
    avatar.classList.add('avatar');
    var messageText = document.createElement('p');
    messageText.textContent = event.data;
    messageContainer.appendChild(avatar);
    messageContainer.appendChild(messageText);
    messages.appendChild(messageContainer);
    messages.scrollTop = messages.scrollHeight;

    // Lưu tin nhắn trả về từ server vào sessionStorage
    const currentChatHistory = JSON.parse(localStorage.getItem('chatHistory')) || [];
    currentChatHistory.push({ sender: "server", message: event.data });
    localStorage.setItem('chatHistory', JSON.stringify(currentChatHistory));

};

    socket.onclose = function() {
    console.log("Disconnected from the WebSocket server");
};

    // Gửi tin nhắn từ người dùng
    function sendMessage() {
    var message = document.getElementById('message').value;
    if (message != "") {
    socket.send(message);

    var messages = document.getElementById('messages');
    var messageContainer = document.createElement('div');
    messageContainer.classList.add('message-container', 'user-message');

    var avatar = document.createElement('img');
    avatar.src = '/static/img/avatar/userChat.png';
    avatar.classList.add('avatar');

    var messageText = document.createElement('p');
    messageText.textContent = message;

    messageContainer.appendChild(avatar);
    messageContainer.appendChild(messageText);
    messages.appendChild(messageContainer);
    messages.scrollTop = messages.scrollHeight;

    // Lưu tin nhắn của người dùng vào sessionStorage
    const currentChatHistory = JSON.parse(localStorage.getItem('chatHistory')) || [];
    currentChatHistory.push({ sender: "user", message: message });
    localStorage.setItem('chatHistory', JSON.stringify(currentChatHistory));

    document.getElementById('message').value = '';
}
}

    // Gửi tin nhắn từ session vào giao diện
    function sendMessageFromSession(messageObj) {
    var messages = document.getElementById('messages');
    var messageContainer = document.createElement('div');

    // Phân biệt tin nhắn của server và người dùng
    if (messageObj.sender === "user") {
    messageContainer.classList.add('message-container', 'user-message');
    var avatar = document.createElement('img');
    avatar.src = '/static/img/avatar/userChat.png'; // Tin nhắn của người dùng
} else {
    messageContainer.classList.add('message-container', 'server-message');
    var avatar = document.createElement('img');
    avatar.src = '/static/img/avatar/chatbot.png'; // Tin nhắn từ server
}

    avatar.classList.add('avatar');

    var messageText = document.createElement('p');
    messageText.textContent = messageObj.message;

    messageContainer.appendChild(avatar);
    messageContainer.appendChild(messageText);
    messages.appendChild(messageContainer);
    // messages.scrollTop = messages.scrollHeight;
}

    // Tải tin nhắn từ sessionStorage
    function loadMessagesFromSession() {
    const savedMessages = JSON.parse(localStorage.getItem('chatHistory')) || [];
    savedMessages.forEach((messageObj) => {
    sendMessageFromSession(messageObj);
});
}

    // Kiểm tra khi người dùng nhấn Enter
    function checkEnter(event) {
    if (event.key === 'Enter') {
    sendMessage();
}
}

    // Gắn sự kiện cho phím Enter trong trường nhập tin nhắn
    document.getElementById('message').addEventListener('keydown', checkEnter);






    function getCookie(name) {
    const value = "; " + document.cookie;  // Lấy tất cả cookies
    const parts = value.split("; " + name + "=");  // Tìm kiếm cookie có tên bằng name
    if (parts.length === 2) return parts.pop().split(";").shift();  // Trả về giá trị cookie nếu tìm thấy
    return null;  // Trả về null nếu không tìm thấy cookie
}

    // Lấy token từ cookie
    const token = getCookie("token");

    document.getElementById("chatRoomBtn").addEventListener("click", () => {
    if (token) {
    const chatRoom = document.getElementById("chatRoom");
    chatRoom.style.display = chatRoom.style.display === "none" ? "block" : "none";
} else {
    alert("Bạn cần phải có tài khoản để tham gia thảo luận!")
}
});

    const chatRoomMessages = document.getElementById("chatRoomMessages");
    const chatRoomInput = document.getElementById("chatRoomInput");
    const sendChatRoomBtn = document.getElementById("sendChatRoomBtn");
    document.getElementById('chatRoomInput').addEventListener('keydown', checkEnterChat);
    let wsUrl = "ws://103.126.161.11/chat-room";  // URL cơ bản của WebSocket
    if (token) {
    wsUrl += `?token=` + token;  // Nếu có token, thêm nó vào URL
}
    // Kết nối WebSocket đến endpoint chat room
    const chatRoomSocket = new WebSocket(wsUrl);

    chatRoomSocket.onmessage = (event) => {
    const message = document.createElement("p");
    message.textContent = event.data;

    if (event.data.includes("Chủ cửa hàng") || event.data.includes("Hệ thống")) {
    message.style.color = "red"; // Đổi màu chữ thành đỏ
} else {
    message.style.color = "black"; // Màu chữ đen cho tin nhắn bình thường
}

    chatRoomMessages.appendChild(message);
    chatRoomMessages.scrollTop = chatRoomMessages.scrollHeight; // Tự động cuộn xuống cuối
};

    // Hàm kiểm tra phím Enter
    function checkEnterChat(event) {
    if (event.key === 'Enter') {
    event.preventDefault(); // Ngăn chặn hành động mặc định của Enter (tạo dòng mới)
    sendMessageChat(); // Gọi hàm gửi tin nhắn
}
}

    // Gửi tin nhắn
    sendChatRoomBtn.addEventListener("click", sendMessageChat);

    // Hàm gửi tin nhắn
    function sendMessageChat() {
    const message = chatRoomInput.value.trim();
    if (message) {
    chatRoomSocket.send(message);
    chatRoomInput.value = ""; // Xóa ô nhập sau khi gửi
}
}