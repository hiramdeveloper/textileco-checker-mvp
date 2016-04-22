class CheckersController < ApplicationController

  def index

  end

  #params[:id]
  def new
  	@checkin = Checker.new
  end

  def create

    if !params[:checker][:id_user].blank?

        if params[:checker][:chk] == "in"
          #This validation is for avoid put another row in same day
          conunter = Checker.where(id_user: params[:checker][:id_user], date_day: Date.today).count

          if conunter == 0
            #If the user will go the CheckIn, insert a new row in the database
            @checkin = Checker.new(id_user: params[:checker][:id_user], date_day: Date.today, initial_date: Time.now)
          else
            @checkin = Checker.where(id_user: params[:checker][:id_user], date_day: Date.today).take
            @checkin.last_date = Time.now
          end
        else
          #If the user is already logged In, will go to update the 'last_date' field in database
          @checkin = Checker.where(id_user: params[:checker][:id_user], date_day: Date.today).take
          @checkin.last_date = Time.now
        end
      	@checkin.save
      	redirect_to action: :new

    else
          redirect_to action: :new
    end

  end

end
#Validar si es distinto de nil