class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservatios or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  def col_data
    cols = ("1".."12").to_a
    movie_instance = MovieInstance.find(params[:movie_instance_id])
    row = params[:row]
    movie_instance.reservations.each do |reservation|
      reservation.seats.where(row: row).each do |seat|
        cols.delete((seat.column.to_i).to_s)
      end
    end
    render json: cols
  end

  def transform_to_int(row, col)
    t_row = ["A", "B", "C", "D"]
    t_col = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

    [t_row.find_index(row), t_col.find_index(col)]
  end

  def get_seats(instance_id)
    occ_seats = Seat.joins(:reservation).where("reservations.movie_instance_id = ?", instance_id)
    seats = [["A", ("1".."12").to_a], ["B", ("1".."12").to_a], ["C", ("1".."12").to_a], ["D", ("1".."12").to_a]]

    occ_seats.each do |occ_seat|
      position = transform_to_int(occ_seat.row, occ_seat.column)
      seats[position[0]][1][position[1]] = false
    end
    seats
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @movie_instance = MovieInstance.find(params[:movie_instance_id])
    @rows = ["A", "B", "C", "D"]
    @cols = ("1".."12").to_a
    @seats = get_seats(params[:movie_instance_id])
    @movie_instance.reservations.each do |reservation|
      reservation.seats.where(row: 'A').each do |seat|
        @cols.delete((seat.column.to_i).to_s)
      end
    end
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
    if @reservation.username == ''
      @reservation.errors[:base] << "El nombre de usuario no puede ser vacio"
    end
    id = params[:movie_instance_id]
    @reservation.movie_instance_id = id
    # create seats reservations

    respond_to do |format|
      if @reservation.save
        for col in params[:reservation][:cols]
          seat = Seat.new(reservation_id: @reservation.id,
                          row: params[:reservation][:row],
                          column: col)
          seat.save
        end
        format.html { redirect_to '/movie_instances', notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { redirect_to '/movie_instances', notice: "No se pudo crear la reserva" }
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
