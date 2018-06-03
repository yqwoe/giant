class HomeController < ApplicationController
  def index
  #  redirect_to '/pc/pages/index.html'

    puts ENV['YUNPIAN_KEY']
    puts ENV['YUNPIAN_API']
    puts ENV['REDIS_PASSWD']
    puts ENV['JPUSH_APP_KEY']
    puts ENV['JPUSH_MASTER_KEY']
    puts ENV['RAILS_MASTER_KEY']
  end
end
