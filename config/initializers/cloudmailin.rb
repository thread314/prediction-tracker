# config/initilizers/cloudmailin.rb
ActionMailer::Base.add_delivery_method :cloudmailin, Mail::SMTP,
  address: ENV['CLOUDMAILIN_HOST'],
  port: 587,
  domain: 'https://salty-sea-96190-e9acf7b934b2.herokuapp.com/',
  user_name: ENV['CLOUDMAILIN_USERNAME'],
  password: ENV['CLOUDMAILIN_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true

