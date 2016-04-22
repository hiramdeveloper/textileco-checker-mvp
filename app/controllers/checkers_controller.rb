class CheckersController < ApplicationController

  def index

  end

  #params[:id]
  def new
  	@checkin = Checker.new
  end

  def create

    if !params[:checker][:id_user].blank?

       retroDays = Checker.where(id_user: params[:checker][:id_user], extra: 'IN').where.not(date_day: Date.today).count
        if retroDays == 1
          pastDays = Checker.where(id_user: params[:checker][:id_user], extra: 'IN').where.not(date_day: Date.today).last
          work_past = pastDays.initial_date-10.hours
          newHour = work_past.strftime("%H").to_i
          #newHour =  work_past.to_i.between?(9,14) ?  14 : 18
          @kedo = newHour
          if newHour >= 9
            newHour = 14
          else
            newHour = 18
          end

          fecha = pastDays.initial_date.change({ hour: newHour, min: 0, sec: 0 })
          hoursPast = TimeDifference.between(pastDays.initial_date, fecha).in_hours

          pastDays.last_date = fecha
          pastDays.work_hours = hoursPast
          pastDays.extra = 'SYSTEM'
          pastDays.save
        end

        #This validation is for avoid put another row in same day
        conunter = Checker.where(id_user: params[:checker][:id_user], date_day: Date.today, work_hours: nil).count
          if conunter == 0
            #If the user will go the CheckIn, insert a new row in the database
            @checkin = Checker.new(id_user: params[:checker][:id_user], date_day: Date.today, initial_date: Time.now, extra: 'IN')
            check = 'The CHECK IN has been registered successfully!'
          else
            @checkin = Checker.where(id_user: params[:checker][:id_user], date_day: Date.today).last
            hours = TimeDifference.between(@checkin.initial_date, Time.now).in_hours
            @checkin.last_date = Time.now
            @checkin.work_hours = hours
            @checkin.extra = 'OUT'
            check = 'The CHECK OUT has been registered successfully!'
          end

          @checkin.save
          redirect_to action: :new
          flash[:notice] = check
     else
        redirect_to action: :new
        flash[:alert] = "You need put your barcode!"
    end
  
  end

end
#Validar si es distinto de nil