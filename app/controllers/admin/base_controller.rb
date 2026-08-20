class Admin::BaseController < ActionController::Base
  layout "admin"

  http_basic_authenticate_with(
    name: ENV.fetch("ADMIN_USER") { "admin" },
    password: ENV.fetch("ADMIN_PASSWORD") { Rails.env.production? ? SecureRandom.hex(16) : "admin" },
    realm: "Portfolio admin"
  )
end
