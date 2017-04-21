class Api::V1::GrowingsController < ActionController::API
  before_action :set_growing_card

  def create
    # Record user to growing users
    # one mobile one time
    # remove @card from growing_@cards
    # add @card to table @cards
    # send @card pin
    # verify
    render_has_been_inrolled and return if growing_user_exist?

    @card = add_card_to_table_cards
    create_growing_user
    send_card_to_growing_user
    render_accept_growing_user
  end

  private

  def render_accept_growing_user
    render json: {success: true, message: '恭喜您已参与成功，请稍后留意短信。'}
  end

  def create_growing_user
    @growing_user =
      GrowingUser.create mobile: params[:mobile], growing_card_id: @card.id
  end

  def growing_user_exist?
    GrowingUser.exists?(mobile: params[:mobile])
  end

  def render_has_been_inrolled
    render json: {success: false, message: '您已经参加过该活动了！'}
  end

  def add_card_to_table_cards
    Card.create cid: @growing_card.cid, pin: @growing_card.pin, range: -1, channel: :growing
  end

  def send_card_to_growing_user
    #TODO: remove sensitive information to .env
    ChinaSMS.use :yunpian, password: '173d6d0d1d96a59d7a80530ee6c862c7' #ENV['YUNPIAN_API']
    response = ChinaSMS.to @growing_user.mobile, { code: @growing_card }, tpl_id: '1774946'
    puts response
  end

  def set_growing_card
    loop do
      @growing_card = GrowingCard.last.delete
      card = Card.find_by_pin(@growing_card.pin)
      break unless card
    end
    @growing_card
  end
end
