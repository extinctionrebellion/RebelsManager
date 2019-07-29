import { Controller } from 'stimulus'
import moment from 'moment'
import jsZip from 'jszip'

export default class extends Controller {
  static targets = [
    'table'
  ]

  initialize() {
    window.JSZip = jsZip

    var exportTitle = '*'
    var pdfOrientation = 'portrait'
    var pdfFooter = ''
    var pdfHeader = null

    if (this.data.get('export-title')) {
      exportTitle = this.data.get('export-title')
    }

    window.selectedRows = new Map()
    $(this.tableTarget).DataTable({
      buttons: {
        buttons: [
          {
            extend: 'collection',
            text: 'Export',
            autoClose: true,
            background: false,
            buttons: [
              {
                extend: 'copyHtml5',
                exportOptions: {
                  columns: '[data-exportable]'
                }
              },
              {
                extend: 'csvHtml5',
                filename: exportTitle + ' - ' +
                  moment().format('YYYY-MM-DD-hh-mm a'),
                exportOptions: {
                  columns: '[data-exportable]'
                }
              },
              {
                extend: 'excelHtml5',
                filename: exportTitle + ' - ' +
                  moment().format('YYYY-MM-DD-hh-mm a'),
                exportOptions: {
                  columns: '[data-exportable]'
                }
              }
            ]
          },
          {
            text: 'Email Selected Rebels',
            autoClose: true,
            background: false,
            className: 'disabled email-button secondary',
            attr: {
              'data-target': 'compose-email.button',
              'data-action': 'compose-email#openModal'
            }
          }
        ]
      },
      columnDefs: [
        { targets: 0, orderable: false, className: 'select-checkbox' }
      ],
      dom: "<'datatable-header grid-x grid-padding-x'<'cell auto" +
        "'f><'cell small-12 medium-shrink'B>r>t",
      info: false,
      language: {
        search: ''
      },
      paging: false,
      order: [[3, 'asc']],
      select: {
        style: 'multi'
      }
    }).on('deselect', (e, dt, type, indexes) => {
      if (!dt.rows({ selected: true }).any()) {
        document.querySelector('.email-button').classList.add('disabled')
      }
      $.map(dt.rows(indexes).nodes().to$(), (val, i) => {
        window.selectedRows.delete($(val).attr('id'))
      })
    }).on('select', (e, dt, type, indexes) => {
      if (dt.rows({ selected: true }).any()) {
        document.querySelector('.email-button').classList.remove('disabled')
      }
      $.map(dt.rows(indexes).nodes().to$(), (val, i) => {
        if ($.inArray($(val).attr('id'), window.selectedRows) < 0) {
          window.selectedRows.set($(val).attr('id'), $(val).data())
        }
      })
    })
  }
}
