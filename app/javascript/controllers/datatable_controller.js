import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'table'
  ]

  initialize() {
    var source = this.data.get('source')
    var table = $(this.tableTarget)
    table.DataTable({
      ajax: source,
      buttons: [],
      // columns: table.find('th').map(th => { data: $(th).data('column') }),
      columns: [
        {data: 'name'},
        {data: 'email'}
      ],
      dom: "<'datatable-header grid-x grid-padding-x'<'cell auto" +
        "'f><'cell small-12 medium-shrink'B>r>t" +
        "<'datatable-footer grid-x grid-padding-x align-middle'<'cell small-12 medium-auto'i><'cell shrink'p>>",
      info: true,
      language: {
        search: ''
      },
      pageLength: 10,
      paging: true,
      pagingType: 'numbers',
      processing: true,
      // order: [[4, 'desc']],
      serverSide: true
    })
  }
}
