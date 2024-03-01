let contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

function chatRoomList(user_no) {
    $.ajax({
        type : 'POST',
        url : contextPath + '/ChatRoomListServlet',
        data : {
            user_no : user_no
        },
        success : function(data) {
            if (data === "") {
                return;
            }
            var chatRoomList = JSON.parse(data);
            var result = parsed.result;
            $(".content").empty();
            for (let i = 0; i < result.length; i++) {
                addChatRoom(result[i][0], result[i][1], result[i][2]);
            }
        }
    });
}

function addChatRoom(product_img, title, status) {
    $('.content').append('<div class="chat">' + '<div class="product_img">'
    + '<img src="' + product_img + '">' + '</div>' + '</div>' + '<div class="chat-content">' +
        '<div class="chat-title">' + '<p>' + title + '</p>' + '</div>' + '<div class="chat-status">' + '<div class="status">' +
        status  + '</div>' + '</div>' + '</div>' + '</div>');
}

function getInfiniteChatRoomList() {
    setInterval(function() {
        chatRoomList();
    }, 1000);
}

$(document).ready(function() {
    chatRoomList(1);
    getInfiniteChatRoomList();
});