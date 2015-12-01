class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :update, :edit, :delete]
  
  def index
    @assignment = Assignment.all
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @courier = current_courier
    @package = Package.find(params[:pakage_id])
    @assignment = @courier.assignments.build(package_id: package.id)
    AssignMailer.courier_accepted(@package.user).deliver_now
  end

  def show
   
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

end
