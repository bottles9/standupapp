class ActivityController < ApplicationController
  
 authorize_resource :class => "ActivityController"
  def mine
    @standups = current_user.standups 
    @standups = @standups.includes(:dids, :todos, :blockers).references(:tasks).order('standup_date DESC')  
    @standups = @standups.page params[:page]
  
  end

  def feed
  end
end
