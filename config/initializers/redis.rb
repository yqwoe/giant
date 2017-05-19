if Rails.env.production?
  $redis = Redis::Namespace.new("giant", redis: Redis.new(host: '10.25.76.242', password: ENV['REDIS_PASSWD']))
else
  $redis = Redis::Namespace.new("giant", redis: Redis.new(password: ENV['REDIS_PASSWD']))
end
