# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rollbook::Application.initialize!

=begin
ActionMailer::Base.stmp_settings = {
  address: "smtp.sendgred.net",
  port: "587",
  authentication: :plain,
  user_name: ENV["SENDGRID_USERNAME"],
  password: ENV["SENDGRID_PASSWORD"],
  domain: "heroku.com",
  enable_starttls_auto: true
}
=end
