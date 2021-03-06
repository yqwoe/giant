class JpushJob < ApplicationJob
  queue_as :default

  def perform(message)
    jpush_client = JPush::Client.new(ENV['JPUSH_APP_KEY'], ENV['JPUSH_MASTER_KEY'])
    pusher = jpush_client.pusher

    push_payload = JPush::Push::PushPayload.new(
      platform: 'all',
      audience: 'all',
      notification: message.body,
    ).set_options({apns_production: true})
    msg_id = pusher.push(push_payload).body['msg_id']
    message.update_attribute(:msg_id, msg_id)
  end
end
