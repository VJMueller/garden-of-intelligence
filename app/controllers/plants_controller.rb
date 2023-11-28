class PlantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @plants = Plant.all
    authorize @plants
  end

  def show
    @plant = Plant.find(params[:id])
    authorize @plant
  end

  def new
    @plant = Plant.new
    authorize @plant
  end

  def create
    @plant = Plant.new(plant_params)
    authorize @plant
    if @plant.save
      redirect_to @plant
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
    authorize @plant
  end

  def update
    @plant = Plant.find(params[:id])
    authorize @plant
    if @plant.update(plant_params)
      redirect_to @plant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plant = Plant.find(params[:id])
    authorize @plant
    @plant.destroy!
    redirect_to plants_path, status: :see_other
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :botanical_name, :eatable, :description)
  end
end
