Rails.application.routes.draw do
  get "/employees", to: "employees#index"
  get "/employees/:id", to: "employees#show"
  delete "/employees/:id", to: "employees#delete"
  post "/employees", to: "employees#create"
  put "/employees/:id", to: "employees#update"

  get "/employees/:employee_id/rates", to: "rates#index"
  post "/employees/:employee_id/rates", to: "rates#create"
end
