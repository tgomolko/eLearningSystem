class UserMailer < ApplicationMailer
  def invite_participant(email, user, organization)
    @user = user
    @email = email
    @organization = organization
    mail(to: @email, subject: "eLearning sing up invitation")
  end
end
