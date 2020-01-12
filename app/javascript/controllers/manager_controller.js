import { Controller } from 'stimulus'

export default class extends Controller {
  initialize() {
    $(document).foundation()

    // add class to body for touch-specific features
    if (window.matchMedia('(pointer: coarse)').matches) {
      // this device is probably a touch device
      document.body.classList.add('touch')
    } else {
      document.body.classList.add('no-touch')
    }
  }
}
