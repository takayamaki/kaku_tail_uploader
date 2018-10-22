'use strict';
import '../styles/application'
import { setToggleMenuHandler } from '../shared/header'
import { setConfirmHandler } from '../shared/confirm'

const run = ()=>{
  setToggleMenuHandler();
  setConfirmHandler();
}

window.addEventListener('load',()=>{
  run();
})