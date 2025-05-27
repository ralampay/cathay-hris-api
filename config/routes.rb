Rails.application.routes.draw do
  get "/employees", to: "employees#index"
end
