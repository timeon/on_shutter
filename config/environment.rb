# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.config.action_mailer.delivery_method = :smtp

Paperclip.options[:log] = false

ActsAsTaggableOn.remove_unused_tags = true

