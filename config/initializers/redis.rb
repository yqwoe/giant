if Rails.env.production? || Rails.env.staging?
  $redis = Redis::Namespace.new("giant", redis: Redis.new(host: '10.25.76.242'))
else
  $redis = Redis::Namespace.new("giant", redis: Redis.new(password: ENV['REDIS_PASSWD']))
end
