class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

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
  end

  def new
    @package = Package.new
    @user = current_user
  end

  def edit
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
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
       @couriers = Courier.all
      #@couriers_near =  Courier.all
      @user = current_user
      @package = @user.packages.build(package_params)
      if @package.save
        @couriers.each do |courier|
          if courier.role_id == 2
           twilio_client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
           twilio_client.account.sms.messages.create(
            from: ENV['TWILIO_FROM'],
            to: "+233#{courier.profile.phone}",
           body: "Package with details tracking_code: #{@package.tracking_code},
           vendor: #{@package.vendor}, destination: #{@package.destination}, 
           weight: #{@package.weight} is close to you. Log in to accept"
         end
        )
      end
        redirect_to user_package_path(@user.id, @package)
      else
        render :new
      end
    end

  private
    def set_package
      @package = Package.find(params[:id])
    end

    def package_params
      params.require(:package).permit(:tracking_code, :weight, :vendor, :location, :destination, :recipient, :r_contact)
    end

end

 
