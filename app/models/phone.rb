class Phone < ApplicationRecord
  def generate_pin
    self.pin = rand(0000...9999).to_s.rjust(4, "0")
    save
  end

  def send_pin
    generate_pin
    if Rails.env.development?
      self.pin
    else
      ChinaSMS.use :yunpian, password: ENV['YUNPIAN_API']
      ChinaSMS.to :mobile, { code: self.pin, company: '嘻唰唰' }, tpl_id: 1
    end
  end


  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end
end
