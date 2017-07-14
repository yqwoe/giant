if Rails.env.production? || Rails.env.staging?
  REDIS_HOST = 'r-2ze17558986ad104.redis.rds.aliyuncs.com'.freeze
  $redis = Redis::Namespace.new("giant", redis: Redis.new(host: REDIS_HOST, password: ENV['REDIS_PASSWD']))
else
  $redis = Redis::Namespace.new("giant", redis: Redis.new(password: ENV['REDIS_PASSWD']))
end
