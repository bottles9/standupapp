module NotificationServices
class SlackWebhooks
class NewAccount < SlackWebhooks
WEBHOOK_URL =
  'https://hooks.slack.com/services/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'.freeze
def initialize(params)
@user = params[:user]
@account = params[:account]
end
def self.call(params)
new(params).send(:send_message)
end
private
attr_reader :user, :account
def send_message
super(WEBHOOK_URL, message)
end
def message
"A New User has appeared! #{account.name} - 
#{user.name} || ENV: #{Rails.env}"
end
end
end
end
