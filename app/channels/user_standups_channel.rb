class UserStandupsChannel < ApplicationCable::Channel
def follow(data)
stream_from "user:#{data['user_id']}:standups"
end
def unfollow
stop_all_streams
end
end
