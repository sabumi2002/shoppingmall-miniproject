let MAX_DELIVERYPRICE = 19800;

$(document).ready(() => {
    cartCountCheck();
    $('.cart-item').each(function (index, element) {
        let productCount = $(element).find(".productCount").val();
        if (productCount == 0) {
            $(element).find(".cart-check").attr("disabled", true);
            $(element).find(".cart-price").text("품절");

        }

        // if ($(element).find(".cart-check").is(":checked") === true) {
        //     let finalProduct = $(element).find(".cart-price").text().replace(regex, "");
        //     let finalDelivery = $(element).find(".cart-delivery-price").text().replace(regex, "");
        //
        //
        // }
    })

    // 전체 item 좋아요 표시하기
    $('.like-box :button').each(function (index, element) {
        $(element).find(".likeImg");

        let data = {
            "id": $(this).val()
        }

        $.ajax({
            url: '/shop/likeAll',
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
            url: '/shop/like',
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


function selectAll(selectAll) {
    const checkboxes
        = document.getElementsByName('cart-check');

    checkboxes.forEach((checkbox) => {
        if (checkbox.disabled == false) {
            checkbox.checked = selectAll.checked;
        }
    })
    totalChange();
}

$('.cart-check').click(() => {
    totalChange();
})


$('.input-count').on({
    'change': function (e) {
        e.preventDefault();
        let cart = $(this).parent().parent().parent().parent('.cart-item');
        let $cartPrice = cart.find('.cart-price');
        let $itemPrice = cart.find('.item-price');
        let totalPrice = parseInt($itemPrice.text()) * parseInt($(this).val());

        $cartPrice.text(totalPrice + "원");

        totalChange();
    }
});

function totalChange() {
    //     총 주문 정보
    let totalProductPrice = 0;
    let totaldeliveryPrice = 0;
    const regex = /[^0-9]/g;


    $('.cart-item').each(function (index, element) {

        if ($(element).find(".cart-check").is(":checked") === true) {
            let finalProduct = $(element).find(".cart-price").text().replace(regex, "");
            let finalDelivery = $(element).find(".cart-delivery-price").text().replace(regex, "");
            totalProductPrice += parseInt(finalProduct);
            totaldeliveryPrice += parseInt(finalDelivery);

        }
    })
    if (totalProductPrice > MAX_DELIVERYPRICE) {
        totaldeliveryPrice = 0;
    }
    $('.final-productPrice').text(totalProductPrice);
    $('.final-deliPrice').text(totaldeliveryPrice);
    $('.final-price').text(totalProductPrice + totaldeliveryPrice);
}

function cartCountCheck() {
    let countTemp = new Array();
    let cartIdTemp = new Array();
    $('.cart-item').each(function (index, element) {


        let count = $(element).find(".input-count").val();
        let cartId = $(element).find(".cartId").val();
        countTemp.push(count);
        cartIdTemp.push(cartId);

    });


    let data = {
        "countList": countTemp,
        "cartIdList": cartIdTemp
    }
    $.ajax({
        url: 'cartCountUpdate',
        type: 'POST',
        data: data,
        traditional: true,
        success: (message) => {

        }
    });

}


function cartCountUpdate() {

    let countTemp = new Array();
    let cartIdTemp = new Array();
    $('.cart-item').each(function (index, element) {

        if ($(element).find(".cart-check").is(":checked") === true) {
            let count = $(element).find(".input-count").val();
            let cartId = $(element).find(".cartId").val();
            countTemp.push(count);
            cartIdTemp.push(cartId);
        }
    });


    let data = {
        "countList": countTemp,
        "cartIdList": cartIdTemp
    }
    $.ajax({
        url: 'cartCountUpdate',
        type: 'POST',
        data: data,
        traditional: true,
        success: (message) => {

        }
    });
    payment();
}


let payment = () => {
    console.log("payment");
    let temp = new Array();
    $('.cart-item').each(function (index, element) {

        if ($(element).find(".cart-check").is(":checked") === true) {
            let cartId = $(element).find(".cartId").val();
            temp.push(cartId);
        }
    });

    let totalDeliPrice = $('.final-deliPrice').text();

    let data = {
        cartList: temp,
        totalDeliPrice: totalDeliPrice
    }

    $.ajax({
        url: 'cartPayment',
        type: 'POST',
        data: data,
        dataType: 'JSON',
        traditional: true,
        success: (message) => {
            let result = message;
            if (result.status == "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'payment payment',
                    showConfirmButton: false,
                    timer: 1000
                }).then(() => {
                    location.href="/mypage/showCartPayment?totalDeliPrice="+totalDeliPrice;
                })

            } else {
                Swal.fire({
                    icon: 'error',
                    title: '!!! 중복 불가 !!!',
                    text: '이미 장바구니에 담겨있습니다.',
                    showConfirmButton: false,
                    timer: 1000
                })
            }

        }
    })


}

function likeButton() {
    console.log("likeButton 활성화");
}

function deleteCart(id) {
    let data = {
        "id": id
    }
    console.log(id);
    $.ajax({
        url: 'deleteCart',
        type: 'POST',
        data: data,
        success: (message) => {
            let result = JSON.parse(message);
            if (result.status == "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'success delete',
                    showConfirmButton: false,
                    timer: 1000
                }).then(() => {
                    location.reload();
                })

            } else {
                Swal.fire({
                    icon: 'error',
                    title: '!!! error !!!',
                    text: '이미 삭제된 상품 입니다.',
                    showConfirmButton: false,
                    timer: 1000
                }).then(() => {
                    location.reload();
                })
            }
        }
    });
}