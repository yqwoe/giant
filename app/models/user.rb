class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  before_save :ensure_authentication_token

  has_many :cars
  has_many :shops
  has_many :deals
  has_many :suite_orders
  has_many :comments, as: :commentable
  has_many :devices_and_users_relationships
  has_many :devices, through:    :devices_and_users_relationships
  has_many :customs, class_name: 'Client', foreign_key: 'seller_id'
  has_one  :seller,  class_name: 'Client', foreign_key: 'custom_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  attr_accessor :login

  validates :mobile,
    presence: true,
    uniqueness: true,
    format: { with: /\A[0-9\-]+\z/, on: :create }

  enum roles: [ :registed, # 初始注册进来的用户，未付费会员
                :member,           # 付费会员
                :agency,           # 代理商
                :salesman,         # 业务员
                :shop_owner,       # 车行老板
                :admin,            # 普通管理员
                :sysadmin,         # 系统管理员
                :dadi,
                :risk,             #高危用户
                :blacklist,        #黑名单
                :zhumadian_dadi    #驻马店大地保险
               ]

  def role
    %w(未付费会员
      付费会员
      代理商
      业务员
      车行老板
      普通管理员
      系统管理员)[roles_before_type_cast]
  end

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
    rand(0000...9999).to_s.rjust(4, "0")
  end

  def send_pin
    rand_pin = generate_pin
    set_pin_status = $redis.set(mobile, rand_pin, ex: 60, nx: true )
    if Rails.env.production? || Rails.env.staging? && set_pin_status
      ChinaSmsJob.new.perform_now(mobile: mobile, code: rand_pin, tpl_id: 1)
    end
  end

  def verify(entered_pin)
    update(verified: true) if $redis.get(mobile) == entered_pin
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def ensure_identity_token
    if identity_token.blank?
      self.identity_token = generate_identity_token
    end
  end

  def reset_member
    true if cars.nil?

    result = false
    cars.each do |car|
      result ||= if car.valid_at
                   (car.valid_at > Time.zone.now.beginning_of_day)
                 else
                   false
                  end
    end

    result ? member! : registed!
  end

  protected

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def generate_identity_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(identity_token: token).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
