Rails.application.config.session_store :cookie_store,
  key: '_sprint_tracker_session',
  same_site: :lax,
  secure: Rails.env.production? 