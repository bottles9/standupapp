module Cables
class StandupTeamDomJob < ApplicationJob
def perform(standup)
teams = standup.user.teams
teams.each do |team|
ActionCable.server.broadcast(
"team:#{team.hash_id}:standups:#{standup.standup_date.iso8601}",
html: render_standup(standups(team, standup.standup_date))
)
end
end
private
def render_standup(standups)
ApplicationController.render(
partial: 'teams/standups',
locals: { standups: standups }
)
end
def standups(team, date)
team.users.flat_map do |user|
user.standups
.where(standup_date: date)
.order(standup_date: :desc)
end
end
end
end
