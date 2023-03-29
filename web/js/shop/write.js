const fileInput = document.getElementById("input-file");

const handleFiles = (e) => {
    const selectedFile = [...fileInput.files];
    const fileReader = new FileReader();

    fileReader.readAsDataURL(selectedFile[0]);

    fileReader.onload = function () {
        document.getElementById("previewImg").src = fileReader.result;
    };
};

fileInput.addEventListener("change", handleFiles);


let fileUpload = () => {

    let id = new URLSearchParams(window.location.search).get('id');
    let formData = new FormData();
    let check = /^[0-9]+$/;

    console.log(id);
    console.log($('#input-file')[0].files[0]);


    formData.append("id", id);
    formData.append("productId", $('#productId').val())
    formData.append("file", $('#input-file')[0].files[0]);
    formData.append("title", $('#input-title').val());
    formData.append("brand", $('#input-brand').val());
    formData.append("price", $('#input-price').val());
    formData.append("categoryId", $('#input-categoryId').val());
    formData.append("deliveryId", $('#input-deliveryId').val());
    formData.append("remaining", $('#input-remaining').val());
    formData.append("content", $('.ck-editor__editable').html());


    if (!check.test(formData.get("price")) || !check.test(formData.get("remaining"))) {
        Swal.fire({
            // position: 'top-end',
            icon: 'error',
            title: '!! input error !!',
            text: '가격과 수량은 숫자로만 입력가능합니다!',
            showConfirmButton: false,
            timer: 1500
        })
    } else {

        $.ajax({
            // url: 'writeLogic',
            url: 'upsert',
            type: 'POST',
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            // contentType: 'application/json',
            data: formData,
            success: (message) => {
                let result = JSON.parse(message);
                if (result.status == "success") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Your work has been saved',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(()=>{
                        location.href="/shop/showAll";
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
}
