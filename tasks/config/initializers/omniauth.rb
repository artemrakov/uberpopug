Rails.application.config.middleware.use OmniAuth::Builder do
  provider :uberpopug, ENV['UBERPOPUG_AUTH_ID'], ENV['UBERPOPUG_AUTH_SECRET'], scope: 'public write'
end
