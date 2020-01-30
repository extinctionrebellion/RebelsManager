import { Controller } from 'stimulus'
import { animations } from '../js/animations'

export default class extends Controller {
  static targets = [
    'activeRebelFields',
    'involvementSelector'
  ]

  toggleInvolvement(event) {
    if (event.currentTarget.value == 'false') {
      // supporter, yes!
      animations.animateCss(
        this.activeRebelFieldsTarget,
        'bounceOut',
        (() => {
          this.activeRebelFieldsTarget.classList.add('hide')
        })
      )
    } else {
      // active rebel, woohoo!
      this.activeRebelFieldsTarget.classList.remove('hide')
      animations.animateCss(
        this.activeRebelFieldsTarget,
        'bounce'
      )
    }
  }
}
