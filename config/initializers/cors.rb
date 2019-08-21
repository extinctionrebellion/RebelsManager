Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.production?
    allow do
      origins ENV['ALLOWED_ORIGINS'].split(",")
      resource "*",
          headers: :any,
          methods: [:get, :post, :options]
    end
  end
end
