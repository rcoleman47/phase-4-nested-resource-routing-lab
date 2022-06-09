class UsersController < ApplicationController
  
  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  rescue ActiveRecord::RecordNotFound
    render json: {errors: "user not found"}, status: :not_found
  end

end
