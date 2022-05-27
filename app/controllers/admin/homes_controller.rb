class Admin::HomesController < ApplicationController
  def top
     @items = Item.page(params[:page])
  end
end
