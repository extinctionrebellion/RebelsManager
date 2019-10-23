class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  attr_reader :view, :options

  def collection
    @collection ||= options[:collection]
  end

  # our custom :start_with cond
  # query 'pol henri' will return records with last name == 'Pol-Henri'
  #   thanks to regexp_replace and gsub
  # query 'dazs' will return records with last name == 'Haagen Dazs'
  #   thanks to matches_any second item
  def whitespaced_start_with
    ->(column, _value) {
      ::Arel::Nodes::SqlLiteral.new(
        "regexp_replace(#{column.table.name}.#{column.field}, '[-]', ' ', 'g')"
      ).matches_any([
        "#{column.search.value.gsub(/[-]/, ' ')}%",
        "% #{column.search.value.gsub(/[-]/, ' ')}%"
      ])
    }
  end

  def filter_digits_in_string
    ->(column, _value) {
      ::Arel::Nodes::SqlLiteral.new(
        "regexp_replace(#{column.field}, '\\\D', '', 'g')"
      ).matches("%#{ column.search.value }%")
    }
  end

  def get_raw_records
    collection
  end

  private

  def load_orm_extension
    super
    extend CustomOverrides
  end

  module CustomOverrides
    def build_conditions_for_datatable
      # overwrite gem method
      # if query = 'john legend'
      # original behavior: search for 'john' AND 'legend'
      # new behavior: search for 'john legend', 'john' AND 'legend'
      full_criteria = inject_conditions(unsplitted_search_for)
      criteria = inject_conditions(search_for)
      [full_criteria, criteria].reduce(:or)
    end

    def inject_conditions(search_terms)
      search_terms.inject([]) do |crit, atom|
        search = Datatable::SimpleSearch.new(
          value: atom,
          regex: datatable.search.regexp?
        )
        crit << searchable_columns.map do |simple_column|
          simple_column.search = search
          simple_column.search_query
        end.reduce(:or)
      end.compact.reduce(:and)
    end

    def unsplitted_search_for
      [datatable.search.value]
    end
  end
end
