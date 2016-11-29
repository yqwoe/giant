class User < ApplicationRecord
  before_save :ensure_authentication_token
  has_many :cars

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  attr_accessor :login

  validates :mobile,
    presence: true,
    uniqueness: true,
    format: { with: /\A1[345789][0-9]{9}\z/, on: :create }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["mobile = :value OR lower(email) = :value",
                                    { :value => login.downcase }]).first
    elsif conditions.has_key?(:mobile) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def generate_pin
    self.pin = rand(0000...9999).to_s.rjust(4, "0")
    save
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
  end

  def send_pin
    ChinaSMS.use :yunpian, password: ENV['YUNPIAN_API']
    ChinaSMS.to :mobile, { code: self.pin, company: '嘻唰唰' }, tpl_id: 1
  end

  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  protected

  def email_required?
    false
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
