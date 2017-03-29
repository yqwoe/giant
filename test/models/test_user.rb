require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new name: 'roc', mobile: '13688889999', email: 'r@g.cn',
      password: '12341234', password_confirmation: '12341234'
  end

  test 'mobile should be valid' do
    assert @user.valid?
  end

  test 'mobile should not be valid' do
    @user.mobile = '135_8888'
    assert_not @user.valid?
  end
end
