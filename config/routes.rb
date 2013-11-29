AjaxForms::Application.routes.draw do
  resources :requests

  match 'date/:year/:month/:day' => 'requests#by_date'
  
  root :to => "requests#index"

end
