module NotificationServices
class SlackWebhooks
private
def send_message(webhook, message)
notifier = Slack::Notifier.new webhook
notifier.ping message
end

def message
"A New User has appeared #{account.name} -
#{user.name} || ENV:
#{Rails.env}"             
end
end
end
