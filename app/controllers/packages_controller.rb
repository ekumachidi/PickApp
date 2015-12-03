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
  end

  def new
    @package = Package.new
  end

  def edit
  end

  def create
    @package = Package.new(package_params)
    
      if @package.save
         @couriers = Courier.find_by_sql(["select * from couriers join profiles on couriers.user_id = profiles.user_id "])
         @couriers.each do |courier|
         AssignMAiler.notified(courier,@package) if courier.near([@package.latidude, @package.longitue], 5)
         end
         flash[:notice] ='Package was successfully created.'
         redirect_to @package
      else
        render :new
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
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
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

 
