Rails.application.routes.draw do
  get 'students/index'

  get 'students/new'

  get 'students/all_actions'

  resources :students
  get "students/actions" => "students#all_actions"
end
