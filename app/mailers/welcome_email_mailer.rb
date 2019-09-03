class WelcomeEmailMailer < ApplicationMailer

  default from: "'Standup App' <welcome@standup-app.com>"
def welcome_email(user)
@user = user
mail(to: @user.email, subject: "Welcome to Standup App, #{user.name}!!")
end
end
