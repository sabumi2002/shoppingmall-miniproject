
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