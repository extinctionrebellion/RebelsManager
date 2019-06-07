import { Controller } from 'stimulus'
// import { animations } from '../animations'

export default class extends Controller {
  static targets = [
    'button',
    'form',
    'modal',
    'heading',
    'inputAllRebels',
    'inputRebelIds',
    'notice',
    'noticeMessage',
    'success',
    'submitButton'
  ]

  initialize() {
    if (this.hasModalTarget) {
      $(this.modalTarget).on('open.zf.reveal', () => {
        window.setTimeout(() => {
          this.renderEditor()
          return
        }, 500)
      })
      $(window).resize(() => {
        this.renderEditor()
      })
    }
  }

  emailAllRebels(clickedElement) {
    return $(clickedElement).text().match(/All/)
  }

  initializeForm(clickedElement) {
    console.log('initializeForm', clickedElement)
    $(this.successTarget).hide()
    $(this.noticeTarget).hide()
    this.setSubjectAndMessage(clickedElement)
    if ($(clickedElement).data('recipient')) {
      this.initializeFormForSingleRecipient(clickedElement)    // email one rebel
    } else if (this.emailAllRebels(clickedElement)) {
      this.initializeFormForAllRecipients()      // email all rebels
    } else {
      this.initializeFormForSelectedRecipients()      // email selected rebels
    }
    if (this.countRecipientsWithoutEmail) {
      this.noticeMessageTarget.innerHTML =
        this.countRecipientsWithoutEmail + " selected rebels(s) have <strong>no email set</strong>. They won't receive your message."
      $(this.noticeTarget).show()
    }
    $(this.modalTarget).find('form').show().foundation()
  }

  initializeFormForAllRecipients() {
    this.inputAllRebelsTarget.checked = true
    this.headingTarget.innerHTML = 'Email All Rebels'
    this.noticeMessageTarget.innerHTML = 'Your email will be delivered to <strong>ALL your rebels</strong>.'
    $(this.noticeTarget).show()
    this.setSubmitButtonLabel('Send to ALL Rebels')
  }

  initializeFormForSelectedRecipients() {
    console.log('initializeFormForSelectedRecipients()')
    if (this.selectedIds.length > 1) {
      $(this.headingTarget).html('Email ' + this.selectedIds.length + ' Rebels')
    } else {
      $(this.headingTarget).html('Email 1 Rebel')
    }
    this.inputAllRebelsTarget.checked = false
    this.inputRebelIdsTarget.value = this.selectedIds.join()
    this.setSubmitButtonLabel('Send to Selected Rebels')
  }

  initializeFormForSingleRecipient(clickedElement) {
    const recipient = $(clickedElement).data('recipient')
    $(this.headingTarget).html('Email ' + recipient.name)
    this.inputRebelIdsTarget.value = recipient.id
    $(this.submitButtonTarget).find('span.ladda-label').html('Send Email')
  }

  onPostSuccess(event) {
    $(this.formTarget).fadeOut(400, () => {
      const editor = new App.Editor('.wysiwyg-full')
      editor.clear()
      Ladda.stopAll()
      $(this.successTarget).show()
      // animations.animateCss(this.successTarget, 'jackInTheBox')
    })
  }

  onPostError(event) {
    let [data, status, xhr] = event.detail
    Ladda.stopAll()
    $(this.modalTarget).find('#compose-form-error').html(xhr.response)
    $(this.modalTarget).find('#compose-form-error').show()
  }

  openModal(event) {
    const clickedElement = event.target.closest('[data-target]')
    this.initializeForm(clickedElement)
    if (!$(clickedElement).hasClass('disabled')) {
      $(this.modalTarget).foundation('open')
    }
  }

  renderEditor() {
    this.modalTarget.querySelector('.grid-y').style.height =
      $(this.modalTarget).height() + 'px'
    const emailMessageToolbar = this.modalTarget.querySelector('trix-toolbar')
    const emailMessageEditor = this.modalTarget.querySelector('trix-editor')
    emailMessageEditor.style.height =
      (emailMessageEditor.parentElement.offsetHeight - emailMessageToolbar.offsetHeight - 20) + 'px'
  }

  setSubjectAndMessage(clickedElement) {
    $(this.modalTarget).find('form #email_subject').val('')
    // $(this.modalTarget).find('form #email_message').froalaEditor('html.set', '')
  }

  setSubmitButtonLabel(value) {
    $(this.submitButtonTarget).html(value)
  }

  get countRecipientsWithoutEmail() {
    if (!window.dataTables) { return }
    var rowDataArray = Array.from(window.selectedRows.values())
    return rowDataArray.filter((e) => {
      return !e.hasEmail
    }).length
  }

  get hasMultipleRecipients() {
    return $(this.inputRebelIdsTarget).val().indexOf(',') > -1
  }

  get selectedIds() {
    var rowDataArray = Array.from(window.selectedRows.values())
    return rowDataArray.map((e) => {
      return e.objectId
    }).filter((v, i, a) => a.indexOf(v) === i)
  }
}
