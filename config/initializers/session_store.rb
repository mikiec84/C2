# Be sure to restart your server when you modify this file.

C2::Application.config.session_store(
  :cookie_store,
  key: "_c2_session",
  expire_after: 8.hours
)
