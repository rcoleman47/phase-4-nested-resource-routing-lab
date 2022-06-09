class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  rescue ActiveRecord::RecordNotFound
    render json: {errors: "user not found"}, status: :not_found
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  rescue ActiveRecord::RecordNotFound
    render json: {errors: "item not found"}, status: :not_found
  end

  def create
    user = User.find(item_params[:user_id])
    item = user.items.create!(item_params)
    render json: item, include: :user, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {errors: "user not found"}, status: :not_found
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
