class EmailRecapMailer < ApplicationMailer
default from: "'Standup App' <standups@app.standup.com>"
def recap_email(user, team, standups)
@user = user
@team = team
@standups = standups
mail(to: @user.email, subject: "#{team.name} Standups Recap!")
end
end
