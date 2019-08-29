class ActivityController < ApplicationController
 load_and_authorize_resource :find_by => :hash_id

  def mine
  end

  def feed
  end
end
