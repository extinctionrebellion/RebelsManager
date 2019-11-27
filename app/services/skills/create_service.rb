module Skills
  class CreateService < ServiceBase
    attr_reader :skill

    def initialize
      @skill = Skill.new
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
      skill.attributes = skill_params(params)
      skill.code.upcase!
      skill.save!
      true
    end

    private

    def skill_params(params)
      params
        .require(:skill)
        .permit(
          :description,
          :name,
          :code
        )
    end
  end
end
