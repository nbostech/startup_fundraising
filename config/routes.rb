Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

		namespace :api , path: 'api' do
			namespace :startup_fundraising, path: 'sfr' do
				namespace :v0, path: 'v0' do
					namespace :nbos, path: nil do
						get '/users' => "users#index", path: '/users', param: 'user_type'
						post '/users' => "users#sign_up", path: 'users/signup'
						post '/users' => "users#login", path: 'users/signin'
						get '/about' => "home#about", path: '/about'
						resource :users, only: [:show, :update]

						get '/companies' => "companies#index", path: '/companies', param: 'company_type'
					end
				end
			end   
		end

		namespace :api , path: 'api' do
			namespace :events, path: 'events' do
				namespace :v0, path: 'v0' do
					namespace :nbos, path: nil do
						get '/:tenantId/events/' => "events#index"
						post '/:tenantId/events/' => "events#create"
						#resources :events
					end
				end
			end   
		end

		namespace :com , path: nil do
			namespace :nbos, path: nil do
				namespace :admin, path: nil do
					root :to => "auth#login"
					match 'login' => "auth#login", as: 'login', via: [:get, :post]
					get 'logout' => "auth#logout", as: 'logout'
				end
			end   
		end

end
