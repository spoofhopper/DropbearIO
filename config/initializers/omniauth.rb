OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret
  # , {
  #   scope: ['email', 'https://www.googleapis.com/auth/gmail.modify'],
  #   access_type: 'offline'
  # }

end
