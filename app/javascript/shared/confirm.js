'use strict';
class Confirm{
  constructor(elm){
    this.message = elm.getAttribute('data-confirm')
    if(this.message){
      elm.form.addEventListener('submit', this.confirm.bind(this))
    } else {
      console && console.warn('No value specified in `data-confirm`', elm)
    }
  }

  confirm(e) {
    if (!window.confirm(this.message)) {
      e.preventDefault();
    }
  }
}

export const setConfirmHandler = () =>{
  const targets = document.querySelectorAll('.is-danger')
  console.log(targets)
  if(targets){
    targets.forEach((target) => {
      new Confirm(target)
    })
  }
}