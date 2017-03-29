StatusPage.configure do
  # Cache check status result 10 seconds
  self.interval = 10
  # Use service
  self.use :database
  # self.use :cache
  #self.use :redis
  # Custom redis url
  # self.use :redis, url: 'redis://you-redis-host:3306/1'
  # self.use :sidekiq
end
