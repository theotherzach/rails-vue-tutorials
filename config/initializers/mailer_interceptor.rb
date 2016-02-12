unless Rails.env.production? || Rails.env.test?
  recipients = Rails.application.secrets.email_interception_addresses
  if recipients.present?
    Mail.register_interceptor RecipientInterceptor.new(recipients, subject_prefix: "[#{Rails.env}]")
  end
end
