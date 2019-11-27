module WorkingGroups
  class CreateService < ServiceBase
    attr_reader :working_group

    def initialize
      @working_group = WorkingGroup.new
      @report_errors = true
    end

    def run(params = {})
      context = {
        params: params
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      working_group.attributes = working_group_params(params)
      working_group.code.upcase!
      working_group.save!
      true
    end

    private

    def working_group_params(params)
      params
        .require(:working_group)
        .permit(
          :color,
          :local_group_id,
          :name,
          :code
        )
    end
  end
end
