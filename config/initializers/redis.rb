if Rails.env.production?
  $redis = Redis::Namespace.new("giant", redis: Redis.new(host: '10.25.76.242'))
else
  $redis = Redis::Namespace.new("giant", redis: Redis.new)
end
