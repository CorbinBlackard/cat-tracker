class CatsController < ApplicationController
   before_action :set_cat, only: %i[ show edit update destroy ]

   # GET /cats or /cats.json
   def index
      @cats = Cat.all
   end

   # GET /cats/1 or /cats/1.json
   def show
     # Remove this line - it's redundant with before_action
     # @cats = Cat.find(params[:id])
   end

   # GET /cats/new
   def new
      @cat = Cat.new
   end

   # GET /cats/1/edit
   def edit
   end

   def feed
      @cat = Cat.find(params[:id])
      if @cat.feed!
         redirect_to @cat, notice: "#{@cat.name} has been fed! 🐟"
      else
         redirect_to @cat, alert: "Could not feed #{@cat.name}: #{@cat.errors.full_messages.join(', ')}"
      end
   end

   # POST /cats or /cats.json
   def create
      @cat = Cat.new(cat_params)

      respond_to do |format|
         if @cat.save
         format.html { redirect_to @cat, notice: "Cat was successfully created." }
         format.json { render :show, status: :created, location: @cat }
         else
         format.html { render :new, status: :unprocessable_entity }
         format.json { render json: @cat.errors, status: :unprocessable_entity }
         end
      end
   end

   # PATCH/PUT /cats/1 or /cats/1.json
   def update
      respond_to do |format|
         if @cat.update(cat_params)
         format.html { redirect_to @cat, notice: "Cat was successfully updated.", status: :see_other }
         format.json { render :show, status: :ok, location: @cat }
         else
         format.html { render :edit, status: :unprocessable_entity }
         format.json { render json: @cat.errors, status: :unprocessable_entity }
         end
      end
   end

   # DELETE /cats/1 or /cats/1.json
   def destroy
      @cat.destroy!

      respond_to do |format|
         format.html { redirect_to cats_path, notice: "Cat was successfully destroyed.", status: :see_other }
         format.json { head :no_content }
      end
   end

   def spotted
      @cat = Cat.find(params[:id])
      @cat.spotted!
      redirect_to root_path, notice: "You spotted #{@cat.name}!"
   end

   def reset_spots
      @cat = Cat.find(params[:id])
      @cat.reset_spots
      redirect_to root_path, notice: "#{@cat.name} spottings had been reset"
   end

   def reset_feeding
      @cat = Cat.find(params[:id])
      @cat.update(times_fed_today: 0, last_fed_at: nil)

      redirect_to @cat, notice: "#{@cat.name}'s feeding data has been reset!"
   end

   def add_photo
      @cat = Cat.find(params[:id])
      if params[:photo]
         @cat.photos.attach(params[:photo])
         redirect_to @cat, notice: "Photo added successfully"
      else
         redirect_to @cat, notice: "Please select a photo first"
      end
   end

   def remove_photo
      @cat = Cat.find(params[:id])
      @cat.photos.find(params[:photo_id]).purge
      redirect_to @cat, notice: "Photo removed"
   end


   private
   # Use callbacks to share common setup or constraints between actions.
   def set_cat
      @cat = Cat.find(params[:id])  # FIXED: Changed .expect to [:id]
   end

   # Only allow a list of trusted parameters through.
   def cat_params
      params.require(:cat).permit(:name, :color, :pattern, :temperament, :location,
                                 :last_seen, :notes, :favorite_food, :times_spotted, photos: [])
     # FIXED: Changed .expect to .require and fixed the parameter structure
   end
end
