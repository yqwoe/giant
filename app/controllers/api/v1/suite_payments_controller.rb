class Api::V1::SuitePaymentsController < ActionController::API
  before_action :set_suite_order, only: [:index, :create]

  def create
    if @suite_order
      render json: {
        success: true,
        suite_order: SuiteOrderSerializer.new(@suite_order)
      }
    else
      render json: {
        success: false,
        suite_order: nil
      }
    end
  end

  def index
    render json: {
      success: true,
      suiteOrder: SuiteOrderSerializer.new(@suite_order)
    }
  end

  private
    def convert_to_vip
      @car               = @order.car
      @car.valid_at      = @car.valid_at ? @car.valid_at + 1.year : Time.zone.now + 1.year
      @suite_order.finished_at = Time.zone.now
      @suite_order.status      = :success
      @suite_order.payment_gateway = :alipay

      @car.transaction do
        @suite_order.save!
        @car.save!
      end
    end

    def set_suite_order
      @suite_order = SuiteOrder.find_by_trade_no params[:out_trade_no]
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
