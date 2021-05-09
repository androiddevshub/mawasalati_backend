class Buses < Api
  format :json
  default_format :json

  namespace :buses, desc: "Buses Related Operations" do
    get "/" do
      buses = Bus.all
      { status: true, data: buses }
    end

    post "/" do
      bus = Bus.create(params)
      { status: true, data: bus }
    end

    put "/:id" do
      bus = Bus.find_by(id: params[:id])
      if bus && bus.update(name: params[:name])
        { status: true, data: bus, message: "Bus updated successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end

    delete "/:id" do
      bus = Bus.find_by(id: params[:id])
      if bus && bus.delete
        { status: true, data: bus, message: "Bus deleted successfully" }
      else
        error!({ status: false, message: "Something went wrong" }, 400)
      end
    end
  end
end
