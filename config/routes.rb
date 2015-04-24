Rails.application.routes.draw do
  resources :projects, only: [:index, :create] do
    resources :logs, only: [:index, :create, :show]
  end

  get '/:project_id/logs' => 'logs#index', format: :html
end
