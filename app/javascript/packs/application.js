import '../styles/application'

const toggleActive = (elm) =>{
  elm.classList.contains('is-active') ? elm.classList.remove('is-active') : elm.classList.add('is-active');
}

const setToggleMenuHandler = () =>{
  const header = document.getElementById('header')
  const menu = header.querySelector('.navbar-menu');
  const burger = header.querySelector('.navbar-brand > .navbar-burger')

  burger.addEventListener('click', ()=>{
    toggleActive(menu)
    toggleActive(burger)
  })
}

const run = ()=>{
  setToggleMenuHandler();
}

window.addEventListener('load',()=>{
  run();
})