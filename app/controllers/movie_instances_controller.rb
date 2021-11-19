class MovieInstancesController < ApplicationController
  before_action :set_movie_instance, only: %i[ show edit update destroy ]

  # GET /movie_instances or /movie_instances.json
  def index
    @movie_instances = MovieInstance.all
  end

  # GET /movie_instances/1 or /movie_instances/1.json
  def show
  end

  # GET /movie_instances/new
  def new
    @movie_instance = MovieInstance.new
    @movies = Movie.all
    @rooms = Room.all
  end

  # GET /movie_instances/1/edit
  def edit
    @movies = Movie.all
    @rooms = Room.all
  end

  # POST /movie_instances or /movie_instances.json
  def create
    @movies = Movie.all
    @rooms = Room.all
    @movie_instance = MovieInstance.new(movie_instance_params)
    movies_same_schedule = MovieInstance.where(room_id: @movie_instance.room_id, day: @movie_instance.day,
                                               schedule: @movie_instance.schedule).where.not(id: @movie_instance.id)
    unless movies_same_schedule.empty?
      @movie_instance.errors[:base] << "Ya existe una función este dia en el mismo horario y sala"
    end

    respond_to do |format|
      if movies_same_schedule.empty? && @movie_instance.save
        format.html { redirect_to @movie_instance, notice: "Movie instance was successfully created." }
        format.json { render :show, status: :created, location: @movie_instance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_instances/1 or /movie_instances/1.json
  def update
    @movies = Movie.all
    @rooms = Room.all
    @movie_instance = MovieInstance.new(movie_instance_params)
    movies_same_schedule = MovieInstance.where(room_id: @movie_instance.room_id, day: @movie_instance.day,
                                               schedule: @movie_instance.schedule).where.not(id: @movie_instance.id)
    unless movies_same_schedule.empty?
      @movie_instance.errors[:base] << "Ya existe una función este dia en el mismo horario y sala"
    end
    respond_to do |format|
      if movies_same_schedule.empty? && @movie_instance.update(movie_instance_params)
        format.html { redirect_to @movie_instance, notice: "Movie instance was successfully updated." }
        format.json { render :show, status: :ok, location: @movie_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_instances/1 or /movie_instances/1.json
  def destroy
    @movie_instance.destroy
    respond_to do |format|
      format.html { redirect_to movie_instances_url, notice: "Movie instance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_instance
      @movie_instance = MovieInstance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_instance_params
      params.require(:movie_instance).permit(:movie_id, :room_id, :day, :schedule)
    end
end
