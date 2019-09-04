module Cables
class StandupItemDomJob < ApplicationJob
def perform(standup)
ActionCable.server.broadcast(
"standups:#{standup.hash_id}",
id: standup.hash_id,
html: render_standup(standup)
)
end
private
def render_standup(standup)
ApplicationController.render(
partial: 'standups/standup',
locals: { standup: standup }
)
end
end
end
