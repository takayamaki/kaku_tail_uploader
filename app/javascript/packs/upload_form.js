'use strict';
import '../styles/application'
import { setToggleMenuHandler } from '../header/header'
import {initUppy} from '../upload_form/init_uppy'

const run = ()=>{
  setToggleMenuHandler();
  initUppy();
}

window.addEventListener('load',()=>{
  run();
})