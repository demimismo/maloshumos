require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Compares two stations" do
  fixtures :stations, :cities

  scenario "" do
    visit '/estaciones'

    select 'Plaza del Carmen', :from => 'station1'

  end

end
