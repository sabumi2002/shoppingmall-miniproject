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


    let finalPrice = str.replace(regex, "");
    let id = new URLSearchParams(window.location.search).get('id');
    let itemCount = $(".inp").val();
    let deliveryDate = $(".deliveryDate").text();

    console.log(id);
    console.log(itemCount);
    console.log(finalPrice);
    console.log(deliveryDate);
    data = {
        "id": id,
        "finalPrice" : finalPrice,
        "itemCount" : itemCount,
        "deliveryDate" : deliveryDate
    }


    $.ajax({
        // url: 'writeLogic',
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
                }).then(() => {
                    location.href = "/shop/showAll";
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '!!! ERROR !!!',
                    showConfirmButton: false,
                    timer: 1500
                })
            }

        }
    })


}