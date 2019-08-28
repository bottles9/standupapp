Rails.application.routes.draw do
  devise_for :users,controllers: {registrations: 'registrations'}
  resource :accounts
  get 'activity/mine'
  get 'activity/feed'
  
  root 'activity#mine'


end
