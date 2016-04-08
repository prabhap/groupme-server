class OtpMailer < ActionMailer::Base
  after_action :set_status
  default from: "groupme.noreply@gmail.com"

  def generate_otp_mail(user)
    @user = user
    mail(to: @user.email, subject: "Verification mail from Groupme")
  end

  def set_status
    @user.update_attributes(mail_sent: true)
  end
end
