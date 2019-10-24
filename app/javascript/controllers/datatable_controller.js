import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'table'
  ]

  initialize() {
    var source = this.data.get('source')
    $(this.tableTarget).DataTable({
      ajax: source,
      buttons: [],
      columns: this.columns(),
      dom: "<'datatable-header grid-x grid-padding-x'<'cell auto" +
        "'f><'cell small-12 medium-shrink'B>r>t" +
        "<'datatable-footer grid-x grid-padding-x align-middle'<'cell small-12 medium-auto'i><'cell shrink'p>>",
      info: true,
      language: {
        search: ''
      },
      pageLength: 100,
      paging: true,
      pagingType: 'numbers',
      processing: true,
      // order: [[4, 'desc']],
      serverSide: true
    })
  }

  columns() {
    var tableHeaders = this.tableTarget.querySelectorAll('th')
    return Array.prototype.map.call(tableHeaders, function(th) {
      return { data: th.dataset.column }
    })
  }
}
