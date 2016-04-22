class Employees::UsersController < ApplicationController
	def index
		@employees = User.where(type_user: 2)
	end

	def show
		@barcode = Barby::EAN13.new(params[:id].to_s.rjust(12, '0'))
  		@barcode_for_html = Barby::HtmlOutputter.new(@barcode)
		@employee = User.find(params[:id])
	end
end
