class Api::V1::PaymentsController <  ActionController::API
  before_action :set_logger, only: [:show, :create]
  before_action :set_order, only: [:show, :create]

  def create
    #TODO: verify sign
    unless @order
      @logger.fatal params.inspect
      @logger.fatal "#{params[:out_trade_no]}\t订单不存在"
      render json: {
        success: false,
        message: '订单不存在'
      } and return
    end

    @car = @order.car
    unless @car
      @logger.fatal params.inspect
      @logger.fatal "#{@car}不存在"

      render json: {
        success: false,
        message: "#{@car}不存在"
      } and return
    end

    if @order.success?
      @logger.fatal params.inspect
      @logger.fatal "#{params[:out_trade_no]}\t会员卡已经激活"

      render json: {
        success: true,
        message: '会员卡已经激活'
      } and return
    end

    unless verify_payment?
      @logger.fatal params.inspect
      @logger.fatal "#{params[:out_trade_no]}\t会员卡已经激活"

      render json: {
        success: false,
        message: '参数不完整'
      } and return
    end

    if trade_success? # && convert_to_vip
      @logger.info "#{@car.licensed_id} " \
        "deposit_at: #{Time.zone.now} valid at: #{@car.valid_at}"

      ChinaSMS.use :yunpian, password: '173d6d0d1d96a59d7a80530ee6c862c7' #ENV['YUNPIAN_API']
      ChinaSMS.to @car.user.mobile, {
        licensed_id: @car.licensed_id,
        kind: '年',
        valid_at: @car.valid_at }, tpl_id: '1827684'

      render json: {
        success: true,
        message: "您车牌号为#{@car.licensed_id}会员有效期延长至#{@car.valid_at},
          请联系客服400-852-3369为您人工激活"
      }
    else
      @logger.fatal params.inspect
      @logger.fatal "#{@car.errors.messages.to_json}"

      render json: {
        success: false,
        message: @car.errors.messages.to_json
      }
    end

  end

  def show
    # TODO: return !!@order.finished?
    render json: { success: true }
  end

  private
    def convert_to_vip
      # FIXME: 临时取消，待问题修复后再
      # @car.valid_at  = @car.valid_at ? @car.valid_at + 1.year : 1.year.from_now
      @order.finished_at = Time.zone.now
      @order.status      = trade_success
      @order.payment_gateway = :alipay

      @car.transaction do
        @order.save!
        @car.save!
      end
    end

    def trade_success
      params[:trade_status] == 'TRADE_SUCCESS' ? :success : :created
    end

    def trade_success?
      trade_success == :success
    end

    def set_order
      @order = Order.find_by_trade_no params[:out_trade_no]
    end

    def payment_params
      params.permit!
    end

    def set_logger
      payments_log_file = File.open(
        File.join(Rails.root, 'log', 'payments.log'), 'a')
      payments_log_file.sync = true
      @logger = Logger.new(payments_log_file)
    end

    def logger_alipay_notify
      @logger.info params.to_h.inspect
    end

    ##
    # 1、商户需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
    # 2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
    # 3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的
    #    对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email），
    # 4、验证app_id是否为该商户本身
    #
    # 上述1、2、3、4有任何一个验证不通过，则表明本次通知是异常通知，务必忽略。
    # 在上述验证通过后商户必须根据支付宝不同类型的业务通知，
    # 正确的进行不同的业务处理，并且过滤重复的通知结果数据。
    # 在支付宝的业务通知中，只有交易通知状态为TRADE_SUCCESS或TRADE_FINISHED时，
    # 支付宝才会认定为买家付款成功。
    def verify_payment?
      @order.total_amount == params[:total_amount].to_f
    end

    ##
    # 第一步：
    # 在通知返回参数列表中，除去sign、sign_type两个参数外，凡是通知返回回来的参数皆是待验签的参数。
    #
    # total_amount=0.01&buyer_id=2088002340337660&trade_no=2017050521001004660202926693&body=becomeVIP&notify_time=2017-05-05%2014:56:28&subject=VIP&sign_type=RSA&buyer_logon_id=roc***@yahoo.com.cn&auth_app_id=2016111802958037&charset=utf-8&notify_type=trade_status_sync&invoice_amount=0.01&trade_status=TRADE_SUCCESS&gmt_payment=2017-05-05%2014:56:28&version=1.0&point_amount=0.00&sign=iDZ7wxvI/dOEcluHO1efJNFiqcxzV+6tPDm5xfIf6PeU3t3XtJy/Q5K428CtNj/0UP1wPZtZMbubDg/SEt+Kd/zy3diaGofa066jAZQmpTssG99lkb2OTmQe0qUOwLaSH29eFcFgk8i1tQT8wb3UVhxk+XScgY8r6mz8i24uVE4=&gmt_create=2017-05-05%2014:56:28&buyer_pay_amount=0.01&receipt_amount=0.01&fund_bill_list=[{%22amount%22:%220.01%22,%22fundChannel%22:%22ALIPAYACCOUNT%22}]&app_id=2016111802958037&seller_id=2088221491093746&notify_id=f8f8c4c65f0389c4fcbccd22d700413l3e&seller_email=1991996789@qq.com&out_trade_no=ios20170505153834959
    #
    # 第二步： 将剩下参数进行url_decode, 然后进行字典排序，组成字符串，得到待签名字符串：
    #
    # app_id=2015102700040153&body=大乐透2.1&buyer_id=2088102116773037&charset=utf-8&gmt_close=2016-07-19 14:10:46&gmt_payment=2016-07-19 14:10:47&notify_id=4a91b7a78a503640467525113fb7d8bg8e&notify_time=2016-07-19 14:10:49&notify_type=trade_status_sync&out_trade_no=0719141034-6418&refund_fee=0.00&seller_id=2088102119685838&subject=大乐透2.1&total_amount=2.00&trade_no=2016071921001003030200089909&trade_status=TRADE_SUCCESS&version=1.0
    #
    # 第三步： 将签名参数（sign）使用base64解码为字节码串。
    #
    # 第四步：使用RSA的验签方法，通过签名字符串、签名参数（经过base64解码）
    # 及支付宝公钥验证签名。
    #
    # 第五步：在步骤四验证签名正确后，必须再严格按照如下描述校验通知数据的正确性。
    # 
    # sample:
    #
    def verify_sign?
      
    end
end
