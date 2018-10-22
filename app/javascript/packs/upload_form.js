'use strict';
import '../styles/application'
import { setToggleMenuHandler } from '../shared/header'
import { setConfirmHandler } from '../shared/confirm'
import {initUppy} from '../upload_form/init_uppy'

const run = ()=>{
  setToggleMenuHandler();
  setConfirmHandler();
  initUppy();
}

window.addEventListener('load',()=>{
  run();
})