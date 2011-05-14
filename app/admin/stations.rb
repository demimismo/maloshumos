ActiveAdmin.register Station do
  index do
    column :name
    column "Actions" do |station|
      link_to "Edit", edit_admin_station_path(station.id)
    end
  end
end
