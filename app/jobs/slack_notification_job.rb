class SlackNotificationJob < ApplicationJob

  include Sidekiq::Worker
sidekiq_options :retry => 15 # Only 15 retries and then to the Dead Job Queue
  queue_as :notifications

  def perform(user)
    # Do something later
    #
    notifier = Slack::Notifier.new(
"https://hooks.slack.com/services/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"
)
notifier.ping "A New User has appeared!\
#{user.account.name} - #{user.name} || ENV: #{Rails.env}"
  end
end
