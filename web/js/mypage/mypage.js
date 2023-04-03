function hsitoryButton(){
    $('.history-box').attr("style", "display:block");
    $('.like-box').attr("style", "display:none");
    $('.myStore').attr("style", "display:none");
}
function likeButton(){
    $('.history-box').attr("style", "display:none");
    $('.like-box').attr("style", "display:block");
    $('.myStore').attr("style", "display:none");
}
function myStoreButton(){
    $('.history-box').attr("style", "display:none");
    $('.like-box').attr("style", "display:none");
    $('.myStore').attr("style", "display:block");
}




function cartButton(id) {


    console.log(id);
    let data = {
        "id" : id
    }

    $.ajax({
        url: 'mypageCart',
        type: 'post',
        data: data,
        dataType: 'JSON',
        // traditional: true,
        success: (message) => {
            let result = message;

            console.log(result);
            if (result.state == "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'success',
                    text: '상품이 장바구니에 담겼습니다.',
                    showConfirmButton: false,
                    timer: 1000
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'error',
                    text: '이미 상품에 장바구니에 담겨있습니다.',
                    showConfirmButton: false,
                    timer: 1000
                })
            }
        }
    })


}
function deleteLike(id) {


    console.log(id);
    let data = {
        "id" : id
    }

    $.ajax({
        url: 'deleteLike',
        type: 'post',
        data: data,
        dataType: 'JSON',
        // traditional: true,
        success: (message) => {
            let result = message;

            console.log(result);
            if (result.state == "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'success',
                    text: '좋아요 삭제',
                    showConfirmButton: false,
                    timer: 1000
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'error',
                    text: '삭제 실패',
                    showConfirmButton: false,
                    timer: 1000
                })
            }
        }
    })


}