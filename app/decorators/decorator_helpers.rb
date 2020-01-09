module DecoratorHelpers
  def self.included(controller)
    helpers = [
      :decorate,
      :event_decorator,
      :rebel_decorator
    ]

    if controller.respond_to?(:helper_method)
      controller.send(:helper_method, *helpers)
    end
  end

  def decorate(model, cache: false, reload: true)
    if model.present?
      base = model.class.name.underscore.gsub("/", "__")
      decorator_class = "#{model.class.name}Decorator".constantize
      decorator_var = "@#{base}_decorator"

      if !cache or reload
        decorator = decorator_class.new(model)
      else
        decorator = instance_variable_get(decorator_var)
        decorator ||= decorator_class.new(model)
      end

      if cache
        return instance_variable_set(decorator_var, decorator)
      else
        return decorator
      end
    end

    model
  end

  def event_decorator(reload: false)
    decorate(@event, cache: true, reload: reload)
  end

  def rebel_decorator(reload: false)
    decorate(@rebel, cache: true, reload: reload)
  end
end
