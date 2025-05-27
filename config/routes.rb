Rails.application.routes.draw do
  get "/employees", to: "employees#index"
  get "/employees/:id", to: "employees#show"
  delete "/employees/:id", to: "employees#delete"
end
