class TeamStandupsChannel < ApplicationCable::Channel
def follow(data)
stream_from "team:#{data['team_id']}:standups:#{data['date']}"
end
def unfollow
stop_all_streams
end
end
