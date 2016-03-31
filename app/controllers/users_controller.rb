class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    user = User.create(phone_number: params[:phoneNumber])
    render text: user.id and return
  end
end
