Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root "faces#consent"

  get "/landing", to: "faces#index"

  get "/create", to: "faces#step1"
  get "/begin", to: "faces#step2"

  get '/lock_answers', to: 'faces#lock_answers'
  get '/gather_user_information', to: 'faces#gather_user_information'
  post '/process_user_information', to: 'faces#process_user_information'
  get '/questionnaire', to: 'faces#questionnaire'

  get '/final_questions', to: 'faces#final_questions'
  post '/process_final_questions', to: 'faces#process_final_questions'

  post 'process_questionnaire', to: 'faces#process_questionnaire'
  get '/end_questionnaire', to: 'faces#end_questionnaire'

end
