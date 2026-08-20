Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_controller.allow_forgery_protection = false
  config.public_file_server.headers = { "cache-control" => "public, max-age=3600" }
end
