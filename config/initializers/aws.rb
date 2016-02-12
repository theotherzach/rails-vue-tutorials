Aws.config.update(
  region: Rails.application.secrets.amazon_region,
  credentials: Aws::Credentials.new(Rails.application.secrets.amazon_access_key, Rails.application.secrets.amazon_secret_access_key)
)

# No real need to lograge in test or dev
unless Rails.env.test? || Rails.env.development?
  Rails.application.configure do
    config.action_mailer.delivery_method = :aws_sdk

    if Rails.env.production?
      config.action_mailer.default_url_options = { host: "[production-domain].com" }
    elsif Rails.env.stage?
      config.action_mailer.default_url_options = { host: "rails-vue.stage.tablexi.com" }
    else
      config.action_mailer.default_url_options = { host: "localhost:3000" }
    end
  end
end
