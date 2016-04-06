module KlaviyoRails
  class Railtie < Rails::Railtie
    initializer 'klaviyo-rails', before: 'action_mailer.set_configs' do
      ActiveSupport.on_load :action_mailer do
        KlaviyoRails.install
      end
    end
  end
end
