if Rails.env.production? || Rails.env.staging?
  $redis = Redis::Namespace.new("giant", redis: Redis.new(host: 'r-m5e9f4cabdf6b104.redis.rds.aliyuncs.com', password: ENV['REDIS_PASSWD']))
else
  $redis = Redis::Namespace.new("giant", redis: Redis.new(password: ENV['REDIS_PASSWD']))
end
