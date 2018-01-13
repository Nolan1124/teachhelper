Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'
 # post 'roles#create'
 
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  
  #教师注册
  post 'teachers/register' => 'teachers#create'
  get 'teachers/register' => 'teachers#register'
  
  #教师登录
  post 'teachers/login' => 'teachers#login'
  
  #教师主页
  get 'teachers/entry' => 'teachers#entry'
  
  #教师退出
  get 'teachers/logout' => 'teachers#destroy'
  
  #添加课程
  post 'courses/addcourse' => 'courses#addCourse'
  
  #添加课堂任务
  post 'assignments/addassignment' => 'assignments#addAssignment'
  
  #显示任务列表
  get 'assignments/showlist' => 'assignments#showlist'
  
  #设置密钥有效期
  post 'assignments/setDuration' => 'assignments#setDuration'
  get 'assignments/duration' => 'assignments#duration'

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
  resources :courses
  resources :teachers
  resources :assignments
  
  
end
