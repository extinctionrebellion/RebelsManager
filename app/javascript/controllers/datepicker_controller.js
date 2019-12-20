import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'input'
  ]

  initialize() {
    $(this.inputTarget).pickadate(this.options)
  }

  get options() {
    return {
      container: this.container,
      firstDay: true,
      format: 'mmmm d, yyyy',
      min: this.inputTarget.getAttribute('data-min') || undefined,
      max: this.inputTarget.getAttribute('data-max') || undefined,
      selectMonths: this.inputTarget.getAttribute('data-select-months') || undefined,
      selectYears: this.inputTarget.getAttribute('data-select-years') || undefined
    }
  }

  get container() {
    if (document.body.classList.contains('touch')) {
      'body'
    } else {
      $(this.inputTarget).closest('.field').find('.pickadate-container')
    }
  }
}
