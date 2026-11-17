frontend_origin = ENV.fetch("FRONTEND_ORIGIN", "http://localhost:5173")
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins frontend_origin
    resource "/api/*", headers: %w[Authorization Content-Type Accept],
      methods: %i[get post put patch delete options head], expose: %w[Authorization], max_age: 600
  end
end
