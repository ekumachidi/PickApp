class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :update, :destroy]
  before_action :restrict_user , only: [:index, :checkout]


  def index
    @packages = Package.all
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

  # def create
  #   @package = Package.new(package_params)
    
  #     if @package.save
  #        flash[:notice] ='Package was successfully created.'
  #        redirect_to user_packages_path(id: @package.id)
  #     else
  #       render :new
  #     end
  #  end

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
       #@couriers = User.where(role_id: 2)
       
      @user = current_user
      @package = @user.packages.build(package_params)
      if @package.save
        @couriers = Profile.near([@package.latitude, @package.longitude], 2)
        @couriers.each do |courier| 
          if courier.user.role_id == 2 
           twilio_client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
           twilio_client.account.sms.messages.create(
            from: ENV['TWILIO_FROM'],
            to: "+233#{courier.phone}",
           body: "Package with details tracking_code: #{@package.tracking_code},
           vendor: #{@package.vendor}, destination: #{@package.destination}, 
           weight: #{@package.weight} is close to you. Log in to accept"
         )
         end
      end
        redirect_to user_package_path(@user.id, @package)
      else
        render :new
      end
    end

    def checkout
      @package = Package.find(params[:id])
      @package.update(status: true)
      twilio_client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
           twilio_client.account.sms.messages.create(
            from: ENV['TWILIO_FROM'],
            to: "+233#{@package.user.profile.phone}",
           body: "We have been notified that your package has been delivered succesfully. Do let us know if you have any issues 0546590509."
         )
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

 
