class Admin::CarsController < ApplicationController
  def update
    respond_to do |format|
      format.js
    end
  end

  def show
  end
end
