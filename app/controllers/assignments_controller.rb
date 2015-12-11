class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :update, :edit, :delete]
  before_action :restrict_user 
  before_action :restrict_courier, only: [:index, :new]
  
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
          to: "+233#{@package.r_contact}",
          body: "We got a courier to deliver your package. It will take approximately #{1 } hour.Aren't we awesome? Call us on this number 0546590509."
          )
      @package.update!(assigned: true)
      flash[:notice] = 'Package has been successfully assigned'
      redirect_to current_user
    else
      redirect_to user_packages_path(@courier)
    end
  end

  def show
   
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
