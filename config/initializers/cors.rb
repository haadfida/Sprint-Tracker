Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow Vite dev-server running on any "*.localhost:5173" sub-domain
    # e.g. http://90vals.localhost:5173 or plain http://localhost:5173.
    # Rack::Cors accepts regex or lambda for dynamic checks.
    origins lambda { |origin, _env|
      origin =~ %r{\Ahttp:\/\/(?:[\w-]+\.)?localhost:5173\z} ||
        origin =~ %r{\Ahttp:\/\/127\.0\.0\.1:5173\z}
    }

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end 