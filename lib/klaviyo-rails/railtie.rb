module KlaviyoRails
  class Railtie < Rails::Railtie
    initializer 'klaviyo-rails', before: 'action_mailer.set_configs' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :klaviyo, KlaviyoRails::DeliveryMethod
        )
      end
    end
  end
end
