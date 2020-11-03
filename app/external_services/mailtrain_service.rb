class MailtrainService
  include Singleton

  # --- API docs ---
  # see https://lists.extinctionrebellion.be/account/api

  def add_subscription(list_id, params = {})
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/subscribe/#{list_id}?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :post,
      url:        url,
      payload:    params,
      headers:    {
                    accept: :json,
                    params: params
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)
      else
        response.return!(&block)
        # response.return!(request, result, &block)
      end
    end
  rescue => e
    Raven.capture_exception(e)
  end

  def create_field(list_id, params = {})
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/field/#{list_id}?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :post,
      url:        url,
      payload:    params,
      headers:    {
                    accept: :json,
                    params: params
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)
      else
        response.return!(&block)
      end
    end
  rescue => e
    Raven.capture_exception(e)
  end

  #     curl -XPOST 'https://lists.dev.organise.earth/api/list?access_token=7f610dd6b2e80b2d895b0238d8395193595a75b8' \
  # -d 'NAMESPACE=1' \
  # -d 'UNSUBSCRIPTION_MODE=0' \
  # -d 'NAME=list1' \
  # -d 'DESCRIPTION=a very nice list' \
  # -d 'CONTACT_EMAIL=test@example.com' \
  # -d 'HOMEPAGE=example.com' \
  # -d 'FIELDWIZARD=first_last_name' \
  # -d 'SEND_CONFIGURATION=1' \
  # -d 'PUBLIC_SUBSCRIBE=1' \
  # -d 'LISTUNSUBSCRIBE_DISABLED=0'
  def create_list(params = {})
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/list?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :post,
      url:        url,
      payload:    params,
      headers:    {
                    accept: :json,
                    params: params
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)['data']['id']
      else
        response.return!(&block)
      end
    end
  rescue => e
    Raven.capture_exception(e)
  end

  def delete_subscription(list_id, params = {})
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/delete/#{list_id}?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :post,
      url:        url,
      payload:    params,
      headers:    {
                    accept: :json,
                    params: params
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)
      # else
      #   response.return!(request, result, &block)
      # subscriber is deleted even if "Cannot read property 'id' of undefined"
      end
    end
  rescue => e
    Raven.capture_exception(e)
  end

  def get_subscriptions(email)
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/lists/#{email}?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :get,
      url:        url,
      headers:    {
                    accept: :json
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)['data']
      else
        response.return!(request, result, &block)
      end
    end
  rescue => e
    Raven.capture_exception(e)
    []
  end

  def send_transactional_email(template_id, params = {})
    url = "#{ENV['MAILTRAIN_API_ENDPOINT']}/templates/#{template_id}/send?access_token=#{ENV['MAILTRAIN_API_TOKEN']}"
    RestClient::Request.execute(
      method:     :post,
      url:        url,
      payload:    params.merge({ "SEND_CONFIGURATION_ID": 2 }),
      headers:    {
                    accept: :json,
                    params: params.merge({ "SEND_CONFIGURATION_ID": 2 })
                  }
    ) do |response, request, result, block|
      case response.code
      when 200
        JSON.parse(response)
      else
        response.return!(&block)
        # response.return!(request, result, &block)
      end
    end
  rescue => e
    Raven.capture_exception(e)
    []
  end
end
