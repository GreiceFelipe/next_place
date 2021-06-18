class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def show
    render json: UserSerializer.new(@current_user).as_json, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).as_json, status: :created
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  #TODO - Não funciona quando não coloca o password e não reclama do password_confirmation quando branco
  def update
    user_params.delete(:password) unless user_params[:password].present?
    user_params.delete(:password_confirmation) unless user_params[:password_confirmation].present?
    if @current_user.update(user_params)
      render json: UserSerializer.new(@current_user).as_json, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
