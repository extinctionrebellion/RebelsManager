Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.production?
    allow do
      origins "extinctionrebellion.be",
              "www.extinctionrebellion.be",
              "namur.extinctionrebellion.be",
              "rebels.extinctionrebellion.be",
              "xrliege.be"
      resource "*",
          headers: :any,
          methods: [:get, :post, :options]
    end
  end
end
