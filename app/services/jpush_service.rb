class JpushService
  class << self
    def shop message
      secrets = Rails.application.secrets
      client = JPush::Client.new(secrets.jpush_shop_app_key,
                          secrets.jpush_shop_master_secret)
      pusher = client.pusher
      audience = JPush::Push::Audience.new
      audience.set_alias(message[:audience])

      payload = JPush::Push::PushPayload.new(
        platform: message[:platform],
        audience: audience,
        notification: message[:body]
      ).set_options({ apns_production: true })

     pusher.push(payload).body['msg_id']
    end
  end
end
