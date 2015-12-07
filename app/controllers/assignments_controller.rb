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
    redirect_to @assignment
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
