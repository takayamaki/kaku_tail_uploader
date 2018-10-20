import '../styles/application'
import { setToggleMenuHandler } from '../header/header'

const run = ()=>{
  setToggleMenuHandler();
}

window.addEventListener('load',()=>{
  run();
})