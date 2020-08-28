require 'klaviyo'
require 'klaviyo-rails/version'
require 'klaviyo-rails/delivery_method'

module KlaviyoRails
end

require 'klaviyo-rails/railtie' if defined?(Rails::Railtie)
