class PhonesController < ApplicationController
  def new
    @phone = Phone.new
    render layout: false
  end

  def create
    @phone = Phone.find_or_create_by(phone: params[:phone][:phone])
    @phone.generate_pin
    @phone.send_pin
    respond_to do |format|
      format.js # render app/views/phones/create.js.erb
    end
  end

  def verify
    @phone = Phone.find_by(phone: params[:hidden_phone])
    if @phone.verify(params[:pin])
      # TODO: 添加邀请人
      respond_to do |format|
        format.js
      end
    else
    end
  end
end
