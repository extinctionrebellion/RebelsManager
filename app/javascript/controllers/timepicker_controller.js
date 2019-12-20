import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'input'
  ]

  initialize() {
    $(this.inputTarget).pickatime(this.options)
  }

  get options() {
    return {
      container: $(this.inputTarget).closest('.field').find('.pickadate-container'),
      interval: 5,
      format: 'H:i',
      formatLabel: 'H:i',
      formatSubmit: 'HH:i',
      hiddenPrefix: 'prefix__',
      hiddenSuffix: '__suffix'
    }
  }
}
