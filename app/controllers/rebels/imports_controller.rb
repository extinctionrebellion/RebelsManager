class Rebels::ImportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @csv_import = CsvImport.new
  end

  def create
    service = Rebels::ImportService.new
    if service.run(params)
      @csv_import = service.csv_import
      if !@csv_import.import_errors.any?
        flash.now[:notice] = "Congrats, #{service.imports_count} rebels imported successfully!"
      end
      render :new
    else
      @csv_import = service.csv_import
      flash.now[:error] = service.error_message unless !@csv_import.valid?
      render :new
    end
  end

  private

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: 'rebels'
    )
  end
end
