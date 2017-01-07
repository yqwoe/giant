class AlipayService

 ALIPAY_RSA_PUBLIC_KEY = <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkr
IvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsra
prwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUr
CmZYI/FCEa3/cNMW0QIDAQAB
-----END PUBLIC KEY-----
EOF

  def self.verify result
    delete_sign_and_sign_type result
    delete_sign result

    verify_app_id Alipay.app_id
    verify_
  end

  def self.delete_sign_type result
    result.gsub '&sign_type=RSA', ''
  end

  def self.delete_sign result
    result.gsub(/sign=.+=&/, '')
  end

  def self.decode result
    result.split('&').sort.join('&')
  end
end

