class ChinaSmsJob < ApplicationJob
  queue_as :default
  COMPANY = '嘻唰唰'.freeze

  def perform(*args)
    send_sms(*args)
  end

  private

  def send_sms(mobile:, code:, tpl_id:)
    ChinaSMS.to mobile, { code: code, company: COMPANY }, tpl_id: tpl_id
  end
end
