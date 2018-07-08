REDIS_HOST = case Rails.env
             when 'production'
               'localhost'
               #'r-2ze17558986ad104.redis.rds.aliyuncs.com'.freeze
             when 'staging'
               'r-m5e9f4cabdf6b104.redis.rds.aliyuncs.com'.freeze
             else
               'localhost'
             end

$redis = Redis::Namespace.new(
  "giant",
  redis: Redis.new(
    host: REDIS_HOST
# ,
#     password: ENV['REDIS_PASSWD']
  )
)
