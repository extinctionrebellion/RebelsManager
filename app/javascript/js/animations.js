class Animations {
  animateCss(node, animationName, callback) {
    node.classList.add('animated')
    if (animationName instanceof Array) {
      animationName.forEach((animationClass, i) => {
        node.classList.add(animationClass)
      })
    } else {
      node.classList.add(animationName)
    }

    function handleAnimationEnd() {
      node.classList.remove('animated')
      if (animationName instanceof Array) {
        animationName.forEach((animationClass, i) => {
          node.classList.remove(animationClass)
        })
      } else {
        node.classList.remove(animationName)
      }
      node.removeEventListener('animationend', handleAnimationEnd)

      if (typeof callback === 'function') callback()
    }

    node.addEventListener('animationend', handleAnimationEnd)
  }

  bounceAndReplace(replacedNode, replacingNode) {
    this.animateCss(
      replacedNode,
      'bounceOut',
      (() => {
        replacedNode.classList.add('hide')
        replacingNode.classList.remove('hide')
        this.animateCss(replacingNode, 'bounceIn')
      })
    )
  }
}

export const animations = new Animations()
