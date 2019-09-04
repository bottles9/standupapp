class StandupsChannel < ApplicationCable::Channel

  def follow(data)
    stream_from "standups:#{data['standup_id']}"
  end

  def unfollow
    stop_all_sreams
  end

end
