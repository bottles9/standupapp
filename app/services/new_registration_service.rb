class NewRegistrationService
def initialize(params)
@user = params[:user]
@account = params[:account]
@plan = params[:plan]
end
def self.call(params)
new(params).perform
end
#private
#attr_reader :user, :account
def perform
begin
account_create
stripe_create
send_welcome_email
notify_slack
rescue ActiveRecord::RecordInvalid => exception
OpenStruct.new(
success?: false, user: user, account: account, error: exception.message
)
else
OpenStruct.new(success?: true, user: user, account: account, error: nil)
end
end

def stripe_create
PaymentServices::Stripe::Subscription::CreationService.(
account: account,
user: user,
plan: plan
)
end

private
attr_reader :user, :account, :plan 
def account_create
post_account_setup if account.save!
end
def post_account_setup
user.account_id = account.id
user.save!
user.add_role :admin, account
end
def send_welcome_email
WelcomeEmailMailer.welcome_email(user).deliver_later
end
def notify_slack
  NotificationServices::SlackWebhooks::NewAccount.(
account: account,
user: user
)

  SlackNotificationJob.perform_later(@user)
end
end
