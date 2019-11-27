module Skills
  class UpdateService < ServiceBase
    attr_reader :skill

    def initialize(skill:)
      @skill = skill
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

      # update all subscriptions
      skill.rebels.each do |rebel|
        Mailtrain::DeleteSubscriptionsJob.perform_later(rebel.email, rebel.local_group&.id)
        Mailtrain::AddSubscriptionsJob.perform_later(rebel)
      end

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
