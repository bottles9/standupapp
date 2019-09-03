class EmailProcessor
attr_reader :email
def initialize(email)
@email = email
end
TASK_TYPE_HASH = {
'[d]' => 'Did',
'[t]' => 'Todo',
'[b]' => 'Blocker'
}
def process
if Rails.env.development?
Rails.logger.info '-----------EMAIL-------------'
Rails.logger.info email.to.first[:token]
Rails.logger.info email.body
Rails.logger.info email.headers["Message-ID"]
Rails.logger.info '-----------EMAIL-------------'
end
# Get a user hash_id from reploy-to or bail
reply_user = email.to.first[:token]&.split('<')&.last&.split('@')&.first&.
split('.')&.last
return if reply_user.blank?
# Find a user by the hash_id or bail
user = User.find_by(hash_id: reply_user)
return if user.nil?
# Bail if standup with incoming message-id exists
return if Standup.exists?(message_id: email.headers["Message-ID"])
# Bail if a standup for today exists
today = Date.today.iso8601
return if Standup.exists?(standup_date: today)
# Get content or bail
tasks_from_body = email.body.scan(/(\[[dtb]{1}\].*)$/)
return if tasks_from_body.blank? || tasks_from_body.empty?
build_and_create_standup(
user: user,
tasks: tasks_from_body,
date: today,
message_id: email.headers["Message-ID"]
)
end
private
def build_and_create_standup(user:, tasks:, date:, message_id:)
standup = Standup.new(
user_id: user.id,
standup_date: date,
message_id: message_id
)
tasks.each do |task|
task_type, task_body = task.first.scan(/(\[[dtb]\])(.*)$/).flatten
standup.tasks << Task.new(type: TASK_TYPE_HASH[task_type], title: task_body)
end
standup.save
end
end
