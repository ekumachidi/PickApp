class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :update, :edit, :delete]
  
  def index
    @assignments = Assignment.all
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @courier = current_user
    @package = Package.find(params[:package_id])
    @assignment = @courier.assignments.build(package_id: @package.id)
    
    if @assignment.save
      twilio_client= Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
        twilio_client.account.sms.messages.create(
          from: ENV['TWILIO_FROM'],
          to: "+233#{@package.user.profile.phone}",
          body: "We got a courier to deliver your package. it will take approximately #{30} mins.
                  Feel free to call us on this number 0546590509 if you have any issue"
          )
      @package.update!(assigned: true)
      flash[:notice] = 'Package has been successfully assigned'
      redirect_to @assignment
    else
      render '/packages'
    end
  end

  def show
   
  end

  def we_assign
    
  end

  def edit
    #re-assign
  end

  def update
  end

  def destroy
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

end
