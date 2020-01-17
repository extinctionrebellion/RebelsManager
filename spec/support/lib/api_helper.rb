module ApiHelper

  def graphql_exec(
    query:,
    user: self.current_user,
    variables: {},
    assert_no_error: true
  )
    raise "GraphQL Not currently setup, cannot use ApiHelper::graphql_exec for request spec"

    path = api_graphql_path()
    authorization_header = jwt(user)

    @parsed_response = nil
    post(
      path,
      headers: {
        "Authorization": authorization_header,
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      params: {
        query: query,
        variables: variables
      }.to_json,
      )
    assert_no_graphql_error if assert_no_error
  end


  def login_as(user, *_args, **_kwargs)
    @current_user= user
  end
  attr_reader :current_user


  def parsed_response
    @parsed_response ||= JSON.parse response.body
  end

  private

  def jwt(user)
    JWT::JsonWebToken.encode({user_id: user.try(:id)})
  end

  def assert_no_graphql_error
    if parsed_response.key?("errors")
      error_messages = parsed_response["errors"].map {|error_hash| error_hash["message"]}
      main_message = error_messages.join(", ")
      details = parsed_response["errors"]
      raise [main_message, details].join("\n")
    end
  end

end
