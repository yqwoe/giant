class Api::V1::PaymentsController <  ActionController::API
  before_action :set_order, only: [:show, :create]

  def create
    #TODO: verify params
    #TODO: verify sign
    logger_alipay_notify

    if verify_payment?
      convert_to_vip
    end

    logger_payment.info "#{@car.licensed_id} " \
      "deposit_at: #{Time.zone.now} valid at: #{@car.valid_at}"
    render json: { success: true }
  end

  def show
    # TODO: return !!@order.finished?
    render json: { success: true }
  end

  private
    def convert_to_vip
      @car   = @order.car
      @car.valid_at = @car.valid_at ? @car.valid_at + 1.year : Time.zone.now + 1.year
      @order.finished_at = Time.zone.now
      @order.status = :success
      @order.payment_gateway = :alipay

      @car.transaction do
        @order.save!
        @car.save!
      end
    end

    def set_order
      @order = Order.find_by_trade_no params[:out_trade_no]
    end

    def payment_params
      params.permit!
    end

    def logger_payment
      payments_log_file = File.open(
        File.join(Rails.root, 'log', 'payments.log'), 'a')
      payments_log_file.sync = true
      Logger.new(payments_log_file)
    end

    def logger_alipay_notify
      logger_payment.info params.to_h.inspect
    end

    def verify_payment?
      true
    end
end
