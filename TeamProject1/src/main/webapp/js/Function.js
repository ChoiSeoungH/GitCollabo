let contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

function ProductListByCategory(categoryId) {
    $.ajax({
        type : 'POST',
        url : contextPath + "/ProductListByCategory",
        data : {
            categoryId : categoryId
        },
        success : function(data) {
            if (data === null) {
                return;
            }
            var parsed = JSON.parse(data);
            var result = parsed.result;
            $('#list').empty();
            for (var i = 0; i < result.length; i++) {
                addList(result[i][0], result[i][1], result[i][2])
            }
        }
    })
}

function addList(img, title, price) {
    $('#list').append('<div class="product-box">' + '<div class="product-img">' +
        '<img src="' + img + '" alt="Product">' + '</div>' + '<div class="content">' +
        '<span class="title">' + title + '</span>' + '<span class="price">' + price + '원</span>' +
        '</div>' + '</div>');
}