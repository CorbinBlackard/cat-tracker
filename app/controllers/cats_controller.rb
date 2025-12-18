class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

  # GET /cats or /cats.json
  def index
    @cats = Cat.all
  end

  # GET /cats/1 or /cats/1.json
  def show
    @cats = Cat.find(params[:id])
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
      redirect_to cats_path, notice: "#{@cat.name} has been fed! 🐟"
    else
      redirect_to cats_path, alert: "Could not feed #{@cat.name}: #{@cat.errors.full_messages.join(', ')}"
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

  def was_spotted
    @cat = Cat.find(params[:id])
    @cat.update(last_seen: Time.now)
    redirect_to root_path, notice: "You spotted #{@cat.name}!"
  end

  def reset_feeding
    @cat = Cat.find(params[:id])
    @cat.update(times_fed_today: 0, last_fed_at: nil)

    redirect_to cats_path, notice: "#{@cat.name}'s feeding data has been reset!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cat_params
      params.expect(cat: [ :name, :color, :pattern, :temperament, :location, :last_seen, :notes, :favorite_food ])
    end
end
