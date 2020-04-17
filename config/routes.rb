Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles
  root 'welcome#index'

  # get "racers-table/:error" => "racers_table#index"
  get "racers-table" => "racers_table#index"
  

  post "racers-table/create" => "racers_table#create"  
  post "racers-table/delete" => "racers_table#delete"
  post "racers-table/edit" => "racers_table#edit"
  post "racers-table/update" => "racers_table#update"
  post "racers-table/create_race" => "racers_table#create_race"
  post "racers-table/delete_race" => "racers_table#delete_race"


  
end
