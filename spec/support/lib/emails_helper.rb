module EmailsHelper

  def mailbox_for(address)
    deliveries.select { |email| email.destinations.include?(address) }
  end

  protected

  def deliveries
    mailer = ActionMailer::Base
    if ActionMailer::Base.delivery_method == :cache
      mailer.cached_deliveries
    else
      mailer.deliveries
    end
  end
end

