CarrierWave.configure do |config|
  config.storage           = :aliyun
  config.aliyun_access_id  = "LTAISJMBLHMyiCxI"
  config.aliyun_access_key = 'Qip3D04vOprIkvDOOhZFwIASPriHcN'
  # 你需要在 Aliyum OSS 上面提前创建一个 Bucket
  config.aliyun_bucket     = "deals"
  # 是否使用内部连接，true - 使用 Aliyun 主机内部局域网的方式访问  false - 外部网络访问
  config.aliyun_internal   = true
  # 配置存储的地区数据中心，默认: cn-hangzhou
  config.aliyun_area     = "cn-beijing"
  # 使用自定义域名，设定此项，carrierwave 返回的 URL 将会用自定义域名
  # config.aliyun_private_read = false
end
