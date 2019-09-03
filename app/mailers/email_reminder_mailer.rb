class EmailReminderMailer < ApplicationMailer
def reminder_email(user, team)
@user = user
@team = team
reply_to = "'Standup App' <#{'development.' if Rails.env.development?}\
standup.#{@user.hash_id}@standupappy.herokuapp.com>"
mail(
to: @user.email,
subject: "#{team.name} Standup Reminder!",
reply_to: reply_to
)
end
end
