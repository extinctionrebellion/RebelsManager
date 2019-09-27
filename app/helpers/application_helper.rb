module ApplicationHelper
  def params_plus(additional_params)
    params.to_unsafe_h.merge(additional_params)
  end
end
