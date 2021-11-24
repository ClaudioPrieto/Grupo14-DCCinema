class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservatios or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @movie_instances = MovieInstance.all
    @seats = Seat.all
    @rows = ["A", "B", "C", "D"]
    @cols = ("1".."12").to_a
    # eliminar rows y cols donde ya hay reserva en @seats
  end

  # GET /reservations/1/edit
  def edit
    @movie_instances = MovieInstance.all
  end

  def create
    @movie_instances = MovieInstance.all
    @seats = Seat.all
    @reservation = Reservation.new(reservation_params)
  
    # create seats reservations

    respond_to do |format|
      if @reservation.save
        for col in params[:reservation][:cols]
          seat = Seat.new(reservation_id: @reservation.id,
                          row: params[:reservation][:row],
                          column: col)
          print "\n #{seat.row} | #{seat.column} \n"
          #seat.save
        end
        format.html { redirect_to '/movie_instances', notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:movie_instance_id, :username)
  end

  def seats_params
    params.permit(:row, :cols)
  end

  def valid_reservation(all_movies_instances, movie_instance_id, seat)
    for movie_instance in all_movies_instances do
      if movie_instance.object_id == movie_instance_id
        check_seat(seat)
        end
      end
    end
  end
