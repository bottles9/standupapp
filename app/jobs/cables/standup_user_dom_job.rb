module Cables
class StandupUserDomJob < ApplicationJob
def perform(standup)
standups = standup.user.standups.order(standup_date: :desc)
ActionCable.server.broadcast(
"user:#{standup.user.hash_id}:standups",
html: render_standup(standups)
)
end
private
def render_standup(standups)
ApplicationController.render(
partial: 'users/standups',
locals: { standups: standups }
)
end
end
end
