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
			namespace :startup_fundraising, path: 'startup-fundraising' do
				namespace :v0, path: 'v0' do
					namespace :nbos, path: nil do
						get '/users' => "users#index", path: '/users', param: 'user_type'
						post '/users' => "users#sign_up", path: 'users/signup'
						post '/users' => "users#login", path: 'users/signin'
						get '/users' => "users#sign_out", path: 'users/signout'
						get '/about' => "home#about", path: '/about'
						get '/users/:id' => "users#show"
						put '/users/:id' => "users#update"

						get '/tenantInfo' => "users#get_tenant_info"

						get '/companies' => "companies#index", path: '/companies', param: 'company_type'
						post '/companies' => "companies#create", path: '/companies'
						put '/companies/:id/profile' => "companies#update_profile"
						get '/companies/:id' => "companies#show"
						put '/companies/:id' => "companies#update"
						delete '/companies/:id' => "companies#delete"

						# To Get all associates of a company & Add an Associate to a company
						get '/companies/:id/associates' => 'associates#index'
						post '/companies/:id/associates' => 'associates#create'

						# Funding Rounds of a company
						get '/companies/:id/fundingRounds' => 'funding_rounds#index'
						post '/companies/:id/fundingRounds' => 'funding_rounds#create'
            
            # To GET, Update and Delete a fundingRound
						get '/fundingRounds/:id' => 'funding_rounds#show'
						put '/fundingRounds/:id' => 'funding_rounds#update_fundingRound'
						delete '/fundingRounds/:id' => 'funding_rounds#delete' 

						# To GET, Update and Delete an Associate
						get '/associate/:id' => 'associates#show'
						put '/associate/:id' => 'associates#update_associate'
						delete '/associate/:id' => 'associates#delete' 
						
						# To Get MetaData of Company,Currency,Associate,Address,
						# CompanySummary and Document types 
						get '/company/categories' => "company_categories#index"
						get '/company/stages' => "company_stages#index"
						get '/company/summarytypes' => "company_summary_types#index"
						get '/document/types' => "company_document_category#index"
						get '/currency/types' => "currency_types#index"
						get '/associates/teams' => "associate_teams#index"
						get '/address/types' => "address_types#index"
						get '/domain_expertises/types' => "domain_expertises#index"

						#To Upload media
						post '/media' => "media#add_media"
						get '/media/:id' => "media#get_media"

						#To Add a company to Favoirite list
						get '/user/favorites' => "favorites#index"
						post '/user/favorites' => "favorites#create"
						delete '/user/favorites' => "favorites#delete"
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
						get '/events' => "events#get_events"
						get '/:tenantId/events/:id' => "events#show"
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
