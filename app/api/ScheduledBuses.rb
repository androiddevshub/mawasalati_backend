class ScheduledBuses < Api
  format :json
  default_format :json

  namespace :scheduled_buses, desc: "Bus scheduled related operations" do
    get "/" do
      @scheduled_buses = ScheduledBus.all
      { status: true, data: @scheduled_buses }
    end

    get "/cities" do
      origin_cities = ScheduledBus.all.pluck(:origin).uniq
      destination_cities = ScheduledBus.all.pluck(:destination).uniq
      { status: true, data: { origin_cities: origin_cities, destination_cities: destination_cities } }
    end

    # get "/origin_cities" do
    #   scheduled_buses = ScheduledBus.all
    #   { status: true, data: scheduled_buses }
    # end

    get "/scheduled" do
      # @scheduled_buses = ScheduledBus.where(origin: params[:origin], destination: params[:destination], date: Date.parse(params[:date])).includes(:bus)
      @scheduled_buses = ScheduledBus.where("origin = ? AND destination = ? AND DATE(date) = ?", params[:origin], params[:destination], Date.parse(params[:date])).includes(:bus)
      if @scheduled_buses
        scheduled_buses = []
        @scheduled_buses.each do |scheduled_bus|
          scheduled_buses << {
            id: scheduled_bus.id,
            bus_name: scheduled_bus.bus.name,
            origin: scheduled_bus.origin,
            destination: scheduled_bus.destination,
            pickup_point: scheduled_bus.departure_center,
            drop_point: scheduled_bus.arrival_center,
            departure_time: DateTime.parse(scheduled_bus.departure_time).utc.localtime.strftime("%I:%M %p"),
            arrival_time: DateTime.parse(scheduled_bus.arrival_time).utc.localtime.strftime("%I:%M %p"),
            duration: scheduled_bus.duration,
            seats: scheduled_bus.seats,
            date: scheduled_bus.date,
            price: scheduled_bus.price,
            rating: scheduled_bus.rating,
          }
        end
        { data: scheduled_buses, status: true }
      else
        error!({ message: "No record found!", status: false }, 400)
      end
    end

    post "/" do
      scheduled_bus = ScheduledBus.new(params)
      if scheduled_bus.save!
        { status: true, data: scheduled_bus, message: "Scheduled Bus created successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    put "/:id" do
      scheduled_bus = ScheduledBus.find_by(id: params[:id])
      if scheduled_bus && scheduled_bus.update(params)
        { status: true, data: scheduled_bus, message: "Scheduled Bus updated successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    delete "/:id" do
      scheduled_bus = ScheduledBus.find_by(id: params[:id])
      if scheduled_bus && scheduled_bus.delete
        { status: true, data: scheduled_bus, message: "Scheduled bus deleted successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end
  end
end
