class Bookings < Api
  format :json
  default_format :json

  namespace :bookings, desc: "Tests Related Operations" do
    get "/" do
      authenticate!
      @bookings = current_user.bookings
      if @bookings
        bookings = []
        @bookings.each do |booking|
          scheduled_bus = ScheduledBus.find(booking.scheduled_bus_id)
          bookings << {
            id: booking.id,
            scheduled_bus: {
              id: scheduled_bus.id,
              bus_name: scheduled_bus.bus.name,
              bus_type: scheduled_bus.bus.bus_type,
              bus_number: scheduled_bus.bus_number,
              bus_contact_first: scheduled_bus.bus.operator_contact_first,
              bus_contact_second: scheduled_bus.bus.operator_contact_second,
              origin: scheduled_bus.origin,
              destination: scheduled_bus.destination,
              pickup_point: scheduled_bus.departure_center,
              drop_point: scheduled_bus.arrival_center,
              departure_date: DateTime.parse(scheduled_bus.departure_date).utc.localtime.strftime("%Y-%m-%d"),
              arrival_date: DateTime.parse(scheduled_bus.arrival_date).utc.localtime.strftime("%Y-%m-%d"),
              departure_time: DateTime.parse(scheduled_bus.departure_time).utc.localtime.strftime("%I:%M %p"),
              arrival_time: DateTime.parse(scheduled_bus.arrival_time).utc.localtime.strftime("%I:%M %p"),
              duration: scheduled_bus.duration,
            },
          }
        end
        { data: bookings, status: true }
      else
        error!({ message: "No record found!", status: false }, 400)
      end
      # { status: true, data: bookings }
    end

    get "/:id" do
      authenticate!
      booking = current_user.bookings.find_by(id: params[:id])
      if booking
        scheduled_bus = ScheduledBus.find(booking.scheduled_bus_id)
        { status: true,
         booking: {
          id: booking.id,
          booking_id: booking.booking_id,
          date: booking.date,
          tax_fare: booking.tax_fare,
          passenger_fare: booking.passenger_fare,
          total_fare: booking.total_fare,
          email: booking.email,
          phone: booking.phone,
          status: booking.status,
          passengers: booking.passengers.to_a,
        },
         scheduled_bus: {
          id: scheduled_bus.id,
          bus_name: scheduled_bus.bus.name,
          bus_type: scheduled_bus.bus.bus_type,
          bus_number: scheduled_bus.bus_number,
          bus_contact_first: scheduled_bus.bus.operator_contact_first,
          bus_contact_second: scheduled_bus.bus.operator_contact_second,
          origin: scheduled_bus.origin,
          destination: scheduled_bus.destination,
          pickup_point: scheduled_bus.departure_center,
          drop_point: scheduled_bus.arrival_center,
          departure_date: DateTime.parse(scheduled_bus.departure_date).utc.localtime.strftime("%Y-%m-%d"),
          arrival_date: DateTime.parse(scheduled_bus.arrival_date).utc.localtime.strftime("%Y-%m-%d"),
          departure_time: DateTime.parse(scheduled_bus.departure_time).utc.localtime.strftime("%I:%M %p"),
          arrival_time: DateTime.parse(scheduled_bus.arrival_time).utc.localtime.strftime("%I:%M %p"),
          duration: scheduled_bus.duration,
          seats: scheduled_bus.seats,
          price: scheduled_bus.price,
          rating: scheduled_bus.rating,
        } }
      else
        error!({ status: false, message: "Booking not found" }, 400)
      end
    end

    post "/" do
      # byebug
      booking = Booking.new(scheduled_bus_id: params[:scheduled_bus_id],
                            user_id: params[:user_id],
                            booking_id: params[:booking_id],
                            date: params[:date],
                            tax_fare: params[:tax_fare],
                            passenger_fare: params[:passenger_fare],
                            total_fare: params[:total_fare],
                            email: params[:email],
                            phone: params[:phone],
                            status: params[:status])
      passenger = booking.passengers.new(params[:passengers])
      if booking.save!
        { status: true, message: "Booking successful", id: booking.id }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
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
