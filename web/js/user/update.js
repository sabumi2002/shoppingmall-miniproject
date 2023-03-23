let switchCtn = document.querySelector("#switch-cnt");
let switchC1 = document.querySelector("#switch-c1");
let switchC2 = document.querySelector("#switch-c2");
let switchCircle = document.querySelectorAll(".switch__circle");
let switchBtn = document.querySelectorAll(".switch-btn");
let aContainer = document.querySelector("#a-container");
let bContainer = document.querySelector("#b-container");
let allButtons = document.querySelectorAll(".submit");

let getButtons = (e) => e.preventDefault()

let changeForm = (e) => {

    switchCtn.classList.add("is-gx");
    setTimeout(function () {
        switchCtn.classList.remove("is-gx");
    }, 1500)

    switchCtn.classList.toggle("is-txr");
    switchCircle[0].classList.toggle("is-txr");
    switchCircle[1].classList.toggle("is-txr");

    switchC1.classList.toggle("is-hidden");
    switchC2.classList.toggle("is-hidden");
    aContainer.classList.toggle("is-txl");
    bContainer.classList.toggle("is-txl");
    bContainer.classList.toggle("is-z200");
}

let mainF = (e) => {
    for (var i = 0; i < allButtons.length; i++)
        allButtons[i].addEventListener("click", getButtons);
    for (var i = 0; i < switchBtn.length; i++)
        switchBtn[i].addEventListener("click", changeForm)
}

window.addEventListener("load", mainF);


$(document).ready(function () {
    let state = $('#state').val();
    console.log(state);
    if(state == "loginFail"){
        Swal.fire({
            // position: 'top-end',
            icon: 'error',
            title: '!!! 로그인 실패 !!!',
            text: '아이디, 비밀번호가 틀렸습니다.',
            showConfirmButton: false,
            timer: 1500
        })
    }

    if(state == "registerSuccess"){
        Swal.fire({
            // position: 'top-end',
            icon: 'success',
            title: '회원등록 성공!!!',
            showConfirmButton: false,
            timer: 1500
        })
    }

    if(state == "registerFail"){
        Swal.fire({
            // position: 'top-end',
            icon: 'error',
            title: '!!! 회원등록 실패 !!!',
            text: '빼먹은게 없는지 확인해주세요.',
            showConfirmButton: false,
            timer: 1500
        })
    }

});
function deleteButton(){
    let id = new URLSearchParams(window.location.search).get("id");
    let deleteVal = $("#delete-input").val()
    let deleteName = $("#delete-name").val()
    if(deleteVal == deleteName){
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                ).then(() => {
                    location.href = "/user/delete/"+$('#logIn-id').val();
                })
            }
        })
    }else{
        Swal.fire({
            // position: 'top-end',
            icon: 'error',
            title: '!!! Delete Fail !!!',
            text: '잘못 입력하셨습니다.',
            showConfirmButton: false,
            timer: 1500
        })
    }
}