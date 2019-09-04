module CableServices
class NotifyJobsService
attr_reader :standup, :action, :user
def initialize(params)
@standup = params[:standup]
@action = params[:action]
@user = params[:user]
end
def self.call(params)
new(params).send(:perform)
end
private

def perform
if action == :update
Cables::StandupItemDomJob.perform_later(standup)
else
  Cables::StandupUserDomJob.perform_later(standup)
  Cables::StandupTeamDomJob.perform_later(standup)
  Cables::StandupNotificationJob.perform_later(user)
end
end
end
end
