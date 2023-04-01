

// 좋아요(위시리스트) 선택됬는지
$(document).ready(() => {
    $('.like-box :button').each(function (index, element) {
        $(element).find(".likeImg");

        let data = {
            "id": $(this).val()
        }

        $.ajax({
            url: 'likeAll',
            type: 'POST',
            data: data,
            success: (message) => {
                let result = JSON.parse(message);
                if (result.status == "likeOn") {
                    $(this).find('.likeImg').attr("src", "/resources/images/product/free-icon-heart.png");

                } else {
                    $(this).find('.likeImg').attr("src", "/resources/images/product/free-icon-heart-void.png");
                }
            }
        })



    })
})
// 좋아요 누를때 바뀌게
$('.like-box :button').on({
    'click': function (e) {
        e.preventDefault();

        $(this).find('.likeImg')


        let data = {
            "id": $(this).val()
        }

        $.ajax({
            url: 'like',
            type: 'POST',
            data: data,
            success: (message) => {
                let result = JSON.parse(message);
                if (result.status == "likeOn") {
                    $(this).find('.likeImg').attr("src", "/resources/images/product/free-icon-heart.png");

                } else if ((result.status == "likeOff")) {
                    $(this).find('.likeImg').attr("src", "/resources/images/product/free-icon-heart-void.png");
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '!!! like error !!!',
                        text: '로그인을 해주세요',
                        showConfirmButton: false,
                        timer: 1000
                    })
                }
            }
        })


    }
})




//수량 옵션
$('.count-button-box :button').on({
    'click': function (e) {
        e.preventDefault();
        var $count = $(this).parent('.count-button-box').parent('._count').find('.inp');
        var now = parseInt($count.val());
        var min = 1;
        var max = $("#productCount").val();
        var num = now;
        if ($(this).hasClass('minus')) {
            var type = 'm';
        } else {
            var type = 'p';
        }
        if (type == 'm') {
            if (now > min) {
                num = now - 1;
            }
        } else {
            if (now < max) {
                num = now + 1;
            }
        }
        if (num != now) {
            $count.val(num);
        }
    }
});


let cartButton = () => {
    const regex = /[^0-9]/g;
    let str = $(".total-price").text();

    if($('#productCount').val() == 0) {
        Swal.fire({
            icon: 'error',
            title: '!!! 품절 !!!',
            text: '재입고 대기중',
            showConfirmButton: false,
            timer: 1500
        })
    } else {


        let finalPrice = str.replace(regex, "");
        let id = new URLSearchParams(window.location.search).get('id');
        let itemCount = $(".inp").val();
        let deliveryDate = $(".deliveryDate").text();

        console.log(id);
        console.log(itemCount);
        console.log(finalPrice);
        console.log(deliveryDate);
        let data = {
            "id": id,
            "finalPrice": finalPrice,
            "itemCount": itemCount,
            "deliveryDate": deliveryDate
        }


        $.ajax({
            url: 'cart',
            type: 'POST',
            data: data,
            success: (message) => {
                let result = JSON.parse(message);
                if (result.status == "success") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Your work has been saved',
                        showConfirmButton: false,
                        timer: 1500
                    })

                } else if (result.status == "loginNull") {
                    Swal.fire({
                        icon: 'error',
                        title: '!!! 로그인 오류 !!!',
                        text: '로그인을 해주세요',
                        showConfirmButton: false,
                        timer: 1500
                    })
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '!!! 중복 불가 !!!',
                        text: '이미 장바구니에 담겨있습니다.',
                        showConfirmButton: false,
                        timer: 1500
                    })
                }

            }
        })
    }

}