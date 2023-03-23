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