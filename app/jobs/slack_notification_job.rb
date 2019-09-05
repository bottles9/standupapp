class SlackNotificationJob < ApplicationJob

  rescue_from(StandardError) do
    retry_job wait: 5.minutes, queue_as: :notifications
  end
  

  #include Sidekiq::Worker
#sidekiq_options :retry => 5 # Only 5 retries and then to the Dead Job Queue

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
