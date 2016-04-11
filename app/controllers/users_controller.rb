class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    user = User.find_or_initialize_by(email: params[:phoneNumber])
    if(user.new_record?)
      user.save!
      # OtpMailer.generate_otp_mail(user).deliver
    end
    render text: user.id and return
  end

  def authenticate_otp
    @user = User.find(params[:user_id])
    render json: {valid: @user.authenticate_otp(params[:otp])} and return
  end

  def update_token
    @user = User.find(params[:user_id])
    @user.update_attributes(token: params[:token])
    render text: "Token updated Successfully" and return
  end
end
