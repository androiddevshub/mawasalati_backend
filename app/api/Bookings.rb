class Bookings < Api
  format :json
  default_format :json

  namespace :bookings, desc: "Tests Related Operations" do
    get "/" do
      buses = Booking.all
      { status: true, data: buses }
    end

    post "/" do
      booking = Booking.new(params)
      passenger = booking.passengers.new(params[:passengers])
      if booking.save
        { status: true, data: "bus", message: "Booking successful" }
      else
      end
      #   bus = Booking.create(name: params[:name])

    end

    put "/:id" do
      bus = Bus.find_by(id: params[:id])
      if bus && bus.update(name: params[:name])
        { status: true, data: bus, message: "Bus updated successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end
  end
end
