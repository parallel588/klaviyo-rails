require 'action_mailer'
require 'klaviyo'
require 'klaviyo-rails/version'
require 'klaviyo-rails/delivery_method'

module KlaviyoRails
  def install
    ActionMailer::Base.add_delivery_method(
      :klaviyo, KlaviyoRails::DeliveryMethod
    )
  end
  module_function :install
end

if defined?(Rails)
  require 'klaviyo-rails/railtie'
else
  KlaviyoRails.install
end
