class HomeController < ApplicationController
    
    skip_before_action :require_login, :only => [:index]
    
    #主界面
    def index
    end
    
end
