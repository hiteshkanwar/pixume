Pixsume::Application.routes.draw do
  resources :job_posting_skill_sets

  resources :job_postings

  resources :companies
  resources :invites do
    collection do
      get "user_send_mail"
    end
  end
  get "/invites/:provider/contact_callback" => "invites#index"
  get "/contacts/failure" => "invites#failure"

  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions', 
                                      :confirmations => 'confirmations', :passwords => 'passwords' }
  get 'sitemap.xml' => 'sitemap#index', as: 'sitemap', defaults: { format: 'xml' }
  #match 'sitemap', :to => "sitemap#index", :as => :sitemap
get '/first-thing-first' => "tutorial#first_thing_first", :as => :first_thing_first
  get '/improve-your-visual-resume' => "tutorial#improve_your_visual_resume", :as => :improve_your_visual_resume
  get '/how-to-rate-your-skill' => "tutorial#how_to_rate_your_skill", :as => :how_to_rate_your_skill
  get '/compare-your-visual-resume' => "tutorial#compare_your_visual_resume", :as => :compare_your_visual_resume
  get '/pixsume-in-job-search' => "tutorial#pixsume_in_job_search", :as => :pixsume_in_job_search  

  get '/welcome' => "home#welcome", :as => :welcome

  get '/how-it-works' => "home#how_it_works", :as => :how_it_works

  get '/about-us' => "home#about_us", :as => :about_us
post '/upload_file' => 'users#upload_file', :as => :upload_file
  get '/contact-us' => "home#contact_us", :as => :contact_us
  
  get '/terms-of-services' => "home#terms_of_services", :as => :terms_of_services
  
  get '/privacy-policy' => "home#privacy_policy", :as => :privacy_policy
  
  get '/press-release' => "home#press_release", :as => :press_release
  
  get '/jobs' => "home#jobs", :as => :jobs

  get '/my/home' => "users#my_home", :as => :my_home

  get '/my/profile' => "users#profile", :as => :profile
  
  get '/my/pixsume' => 'users#my_pixsume', :as => :pixsume

  get 'users/standout'
  

  get '/pixsume/search' => 'users#search_pixsume', :as => :search_pixsume
  get '/pixsume/profile' => 'users#show_profile', :as => :show_profile
  
  get '/profile/edit/basic_info' => 'users#edit_basic_profile', :as => :edit_basic_info
  
  get '/profile/edit/summary' => 'users#edit_summary', :as => :edit_summary
  
  get '/profile/edit/video' => 'users#edit_video', :as => :edit_video
  
  get '/profile/from_linkedin' => 'users#profile_from_linkedin', :as => :get_profile_from_linkedin
 
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'

  resources :users do
    get 'pixsume'
	post 'error_event'
	post 'download_pdf'
	get 'requestor_pdf'
	post 'user_location'
	get 'edit_resume'

  end
  
  resources :experiences
  
  resources :skill_sets do
    collection do
      get 'skillsetmap'
      post 'skillsetmap'
      get 'user_search'
      get 'experience_search'
      post 'experience_search'
      post 'resource_create'
      get 'approved_resource'
      get 'pending_resource'
      post 'create_requestor'
      get 'resource_available'
      post 'checked_popup'
	  get 'edit_resource'
      post 'update_resource'
    end
    member do
      get '/resource/detail' =>"skill_sets#resource_detail", :as => :resource_detail
    end
  end
  get '/resource' => "skill_sets#add_resource", :as => :resource
  get '/requestor' => "skill_sets#add_requestor", :as => :requestor
  get '/resources' =>"skill_sets#show_resource", :as => :resources
  get '/requestors' =>"skill_sets#show_requestor", :as => :requestors
  get '/jobs/search' =>"users#job_mached", :as => :job_mached
  post '/jobs/results' =>"users#search_by_keys", :as => :job_mached_by_key
  get '/jobs/detail' =>"users#job_detail", :as => :job_detail   
  get '/home' =>"users#home", :as => :home


  resources :educations
  
  resources :achievements

  resources :achievement_categories

  resources :skill_categories

  resources :school_ratings

  resources :course_ratings

  resources :ratings

  resources :usage_trackings
  
  resources :job_applications
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
  mount RailsAdmin::Engine => '/za7adR7zUP64qEsten3t39ReSwu7Raha2rAdaMatEDepraja7a', :as => 'rails_admin'

  get ':username' => 'users#public_pixsume', :constraints => { :username => /[^\/]*/ }, :as => :public_pixsume

  match '*a', :to => 'errors#routing'
end
