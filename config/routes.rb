Rails.application.routes.draw do
  root to: 'dashboard#home'
  get '/list_companies', to: 'list_companies#list_companies'
  post '/list_companies', to: 'list_companies#list_companies'
  get '/history', to: 'issues#history'
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/401', to: 'errors#access_denied'
  get '/422', to: 'errors#unprocessable'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' }, path: 'accounts', path_names: { sign_up: 'new' }

  constraints(subdomain: /^(?!www\Z)(\w+)/) do
    get '/companies/search', to: 'companies#search'

    resources :projects do
      member do
        get 'backlog'
        get 'active_sprint'
      end
      resources :sprints
      resources :projects_users
      resources :issues
    end
    resources :sprints do
      resources :issues
      resources :documents, except: %i[edit update]
      member do
        get 'start_sprint_info'
        patch 'start_sprint'
        get 'complete_sprint_info'
        post 'complete_sprint'
        get 'report'
      end
    end

    resources :issues do
      resources :time_logs
      resources :documents, except: %i[edit update]
      collection do
        post 'add_issues_to_sprint'
        get 'fetch_resource_issues', as: 'fetch_resource'
      end
    end
    resources :issues do
      resources :time_logs
    end
    resources :dashboard

    resources :users do
    end

    get '/history', to: 'issues#history'
    resources :reports, only: :index do
      collection do
        get 'sprint'
        get 'issues'
      end
    end
  end
end
