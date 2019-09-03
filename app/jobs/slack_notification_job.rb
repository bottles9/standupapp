class SlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    #
    notifier = Slack::Notifier.new(
"https://hooks.slack.com/services/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"
)
notifier.ping "A New User has appeared!\
#{user.account.name} - #{user.name} || ENV: #{Rails.env}"
  end
end
