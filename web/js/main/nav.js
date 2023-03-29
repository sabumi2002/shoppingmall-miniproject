const searchEl = document.querySelector('.search');
const searchInputEl = searchEl.querySelector('input');

searchEl.addEventListener('click', function () {
    searchInputEl.focus();
});

searchInputEl.addEventListener('focus', function () {
    searchEl.classList.add('focused'); // classList객체에 'focused'추가
    searchInputEl.setAttribute('placeholder', 'seach');
});
searchInputEl.addEventListener('blur', function () {
    searchEl.classList.remove('focused'); // classList객체에 'focused'추가
    searchInputEl.setAttribute('placeholder', '');
});



let initNav = () => {
    $.ajax({
        url: "/nav",
        type: "get",
        success: function (message) {
            let result = message;
            let categoryList = JSON.parse(result.categoryList);
            categoryList.forEach((c)=> {
                insertCategoryRow(c);
            })
            if (result.result != "success") {

            } else {

            }
        }
    })
}
function insertCategoryRow(category){
    let li = $(document.createElement("li"));
    let a = $(document.createElement("a")).attr("href", "/shop/showByCategory?id="+category.id).text(category.category);
    li.append(a);
    $("#hederMenu").append(li);
}