Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '/testing/' # Change to specific origin(s) if needed
      resource '*', 
        headers: :any, 
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
  end