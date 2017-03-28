require 'test_helper'
require 'capybara/rails'

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL

    def sign_in_as(user)
      user = create(:user)
      visit user_session_path
      fill_in 'user[login]', with: user.email
      fill_in 'user[password]', with: user.password
      click_link_or_button '登陆'
    end
  end
end
