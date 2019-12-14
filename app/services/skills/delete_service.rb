module Skills
  class DeleteService < ServiceBase
    attr_reader :skill

    def initialize(skill:)
      @skill = skill
    end

    def run
      catch_error do
        run!
      end
    end

    def run!
      skill_rebels_ids = skill.rebels.pluck(:id)
      skill.destroy

      # update subscriptions
      rebels = Rebel.find(skill_rebels_ids)
      rebels.each do |rebel|
        Mailtrain::DeleteSubscriptionsJob.perform_later(rebel.email, rebel.local_group&.id)
        Mailtrain::AddSubscriptionsJob.perform_later(rebel)
      end

      true
    end
  end
end
