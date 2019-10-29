import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'table'
  ]

  initialize() {
    // initialize dataTable
    this.dataTable
    // set up search with delay
    this.delaySearch()
  }

  delaySearch() {
    const doneTypingInterval = 500
    var typingTimer = null
    var doneTyping = () => {
      if (this.query != queryInput.val()) {
        this.query = queryInput.val()
        this.dataTable.search(this.query).draw()
      }
    }
    var queryInput = $(this.tableTarget)
      .parents('.dataTables_wrapper').find('.dataTables_filter input')
    queryInput.unbind()
    queryInput.on('input', () => {
      // input has been cleared
      if (queryInput.val() == '') queryInput.trigger('keyup')
    })
    queryInput.on('keyup', () => {
      clearTimeout(typingTimer)
      typingTimer = setTimeout(doneTyping, doneTypingInterval)
    })
    queryInput.on('keydown', (event) => {
      clearTimeout(typingTimer)
      // don't submit forms, user wants to search
      if (event.keyCode == 13) { event.preventDefault(); return false }
    })
  }

  get columns() {
    // get values for <th data-column="...">
    var tableHeaders = this.tableTarget.querySelectorAll('th')
    return Array.prototype.map.call(tableHeaders, function(th) {
      return { data: th.dataset.column }
    })
  }

  get dataTable() {
    var _this = this
    if (this._dataTable == undefined) {
      this._dataTable =
        $(this.tableTarget).DataTable(this.options)
        .on('draw.dt', () => {
            $(_this.tableTarget).foundation()
          }
        ).on('processing.dt', (e, settings, processing) => {
            $(_this.tableTarget).find('.dataTables_filter input').toggleClass('processing', processing)
          }
        )
    }
    return this._dataTable
  }

  get options() {
    return {
      ajax: this.data.get('source'),
      buttons: [],
      columns: this.columns,
      dom: "<'datatable-header grid-x grid-padding-x'<'cell auto" +
        "'f><'cell small-12 medium-shrink'B>r>t" +
        "<'datatable-footer grid-x grid-padding-x align-middle'" +
        "<'cell small-12 medium-auto'i><'cell shrink'p>>",
      info: true,
      language: {
        search: ''
      },
      pageLength: 100,
      paging: true,
      pagingType: 'numbers',
      processing: true,
      order: [[3, 'desc']], // order by rebel.created_at
      serverSide: true
    }
  }

  get query() {
    return this.data.get('query')
  }

  set query(value) {
    this.data.set('query', value)
  }
}
