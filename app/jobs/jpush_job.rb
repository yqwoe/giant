class JpushJob < ApplicationJob
  queue_as :default

  def perform(message)
    puts 'JPUSH job works ' + message
    jpush_client = JPush::Client.new(ENV['JPUSH_APP_KEY'], ENV['JPUSH_MASTER_KEY'])
    pusher = jpush_client.pusher

    push_payload = JPush::Push::PushPayload.new(
      platform: 'all',
      audience: 'all',
      notification: message,
    )
    pusher.push(push_payload)

  end
end
