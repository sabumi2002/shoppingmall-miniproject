
let paymentButton = () => {


    let data = {

    }

    $.ajax({
        url: 'cartPaymentLogic',
        type: 'GET',
        // data: data,
        // dataType: 'JSON',
        traditional: true,
        success: (message) => {
            let result = JSON.parse(message);
            if (result.state == "lack") {
                Swal.fire({
                    icon: 'error',
                    title: '!!! error !!!',
                    text: '상품 개수가 부족합니다.',
                    showConfirmButton: false,
                    timer: 1000
                }).then(()=>{
                    // 장바구니로 이동
                    location.href="/mypage/showBasket";
                })
            }
            if ( result.state == "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'success',
                    text: '구매 완료',
                    showConfirmButton: false,
                    timer: 1000
                }).then(()=>{
                    // 장바구니로 이동
                    location.href="/mypage/showBasket";
                })
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'error',
                    text: '코드 에러',
                    showConfirmButton: false,
                    timer: 1000
                }).then(()=>{
                    // 장바구니로 이동
                    location.href="/mypage/showBasket";
                })
            }
        }
    })


}