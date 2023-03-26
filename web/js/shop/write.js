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

    let movieId = new URLSearchParams(window.location.search).get('id');
    let formData = new FormData();

    var inputFile = $('#input-file');
    var files = inputFile[0].files;
    console.log(files);
    for(var i =0; i< files.length; i++){
        formData.append("uploadFile", files[i]);
    }

    // formData.append("file", $('#input-file')[0].files[0]);
    // console.log(formData);
    // formData.append("title", $('#input-title').val());
    // formData.append("brand", $('#input-brand').val());
    // formData.append("price", $('#input-price').val());
    // formData.append("deliveryId", $('#input-deliveryId').val());
    // formData.append("remaining", $('#input-remaining').val());
    // formData.append("content", $('#editor').val());


    $.ajax({
        url: 'writeLogic',
        type: 'POST',
        enctype: 'multipart/form-data',
        processData: false,
        contentType: false,
        // contentType: 'application/json',
        data: formData,
        success: (message) => {
            let result = JSON.parse(message);
            if(result.status=="success"){
                Swal.fire({
                    position: 'top-end',
                    icon: 'success',
                    title: 'Your work has been saved',
                    showConfirmButton: false,
                    timer: 1500
                })
            }else{
                Swal.fire({
                    position: 'top-end',
                    icon: 'error',
                    title: '!!! ERROR !!!',
                    showConfirmButton: false,
                    timer: 1500
                })
            }

        }
    })

    // location.href="/movie/movie-detail.jsp?id="+movieId;
}
