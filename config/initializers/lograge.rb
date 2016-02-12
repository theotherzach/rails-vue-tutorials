# No real need to lograge in test or dev
unless Rails.env.test? || Rails.env.development?
  Rails.application.configure do
    config.paths["log"] = "log/#{Rails.env}.log.json"

    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new

    # Add params to the log
    config.lograge.custom_options = lambda do |event|
      { "params" => event.payload[:params].except("controller", "action") }
    end

    # Uncomment to preserve the original Rails logs
    # config.lograge.keep_original_rails_log = true
    # config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
  end
end
