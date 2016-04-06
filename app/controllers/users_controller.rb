class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    user = User.find_or_create_by(phone_number: params[:phoneNumber])
    render text: user.id and return
  end

  def update_token
    @user = User.find(params[:user_id])
    @user.update_attributes(token: params[:token])
    render text: "Token updated Successfully" and return
  end
end
