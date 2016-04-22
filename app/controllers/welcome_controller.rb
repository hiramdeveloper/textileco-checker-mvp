class WelcomeController < ApplicationController

  	def index
  		
  	end

  	def barcode
  		#session[:user_id] = @current_user.id
  		@employees = User.where(type_user: 2)
  		#@barcode = Barby::EAN13.new('012345678912')
  		#@barcode_for_html = Barby::HtmlOutputter.new(@barcode)
  	end

  	def new
  		
  	end

    def show
      
    end

end
