CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]

CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = CONFIG["qiniu_access_key"]
  config.qiniu_secret_key    = CONFIG["qiniu_secret_key"]
  config.qiniu_bucket        = CONFIG["qiniu_bucket"]
  config.qiniu_bucket_domain = CONFIG["qiniu_bucket_domain"]
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
  config.qiniu_up_host       = "http://up.qiniug.com"  #选择不同的区域时，"up.qiniug.com" 不同

end
