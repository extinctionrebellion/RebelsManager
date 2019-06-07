import { Controller } from 'stimulus'
import { animations } from '../js/animations'

export default class extends Controller {
  static targets = [
    'modal',
    'expandIcon'
  ]

  initialize() {
    this.expandIconTarget.querySelector('.shrink').classList.add('hide')
  }

  toggleExpand(e) {
    e.preventDefault()
    this.modalTarget.classList.toggle('full')
    if (this.modalTarget.classList.contains('full')) {
      animations.bounceAndReplace(
        this.expandIconTarget.querySelector('.expand'),
        this.expandIconTarget.querySelector('.shrink')
      )
    } else {
      animations.bounceAndReplace(
        this.expandIconTarget.querySelector('.shrink'),
        this.expandIconTarget.querySelector('.expand')
      )
    }
    // window.dispatchEvent(new Event('resize'))
  }
}
