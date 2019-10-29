module Exportable
  extend ActiveSupport::Concern

  def respond_to_csv_for_rebels
    render plain: CsvExport.for_model(
      records: exportable_rebels,
      records_class: Rebel
    )
  end

  private

  def exportable_rebels
    if current_user.local_group
      Rebel
        .where(local_group: current_user.local_group)
        .includes(:local_group, :skills, :tags, :working_groups)
        .references(:local_group)
    else
      Rebel.all
        .includes(:local_group, :skills, :tags, :working_groups)
        .references(:local_group)
    end
  end
end
