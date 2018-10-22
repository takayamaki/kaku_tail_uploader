'use strict';
import '../styles/application'
import { setToggleMenuHandler } from '../shared/header'

const run = ()=>{
  setToggleMenuHandler();
}

window.addEventListener('load',()=>{
  run();
})