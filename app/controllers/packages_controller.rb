class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :update, :destroy]
  before_action :restrict_user , only: [:index, :checkout]
  layout 'application'
  before_filter :authenticate_user!


  def index
    @packages = Package.where(assigned: false)
    @hash = Gmaps4rails.build_markers(@packages) do |package, marker|
    marker.lat package.latitude
    marker.lng package.longitude
    marker.infowindow package.tracking_code
    end
  end
   
  def show
    @user = current_user
    @hash = Gmaps4rails.build_markers(@package) do |package, marker|
      marker.lat package.latitude
      marker.lng package.longitude
      marker.infowindow package.tracking_code
    end
  end

  def new
    @package = Package.new
    @user = current_user
  end

  def edit
   @package = Package.find(params[:id])
   unless current_user.id == @package.user_id
    redirect_to  @package
   end
  end

  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id), notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
      @user = current_user
      @package = @user.packages.build(package_params)
      if @package.save
        @couriers = User.where(role_id:  2)
        @near_couriers = Profile.near([@package.latitude, @package.longitude], 5)
        Message.new.courier_notification(@near_couriers, @package)
        redirect_to user_package_path(@user.id, @package)
      else
        render :new
      end
    end

    def checkout
      @package = Package.find(params[:id])
      @package.update(status: true)
      Message.new.package_delivered(current_user)
      redirect_to user_path(current_user)
    end

  private
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      params.require(:package).permit(:tracking_code, :weight, :vendor, :location, :destination, :recipient, :r_contact, :assigned)
    end

end

 
