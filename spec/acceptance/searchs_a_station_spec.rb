require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Searchs A Station" do

  scenario "a station is found" do
    visit '/'
  end

  scenario "a station isn't found" do
    visit '/'

    within :css, '#home-content .buscador' do
      fill_in 'postal_code', :with => 'calle salamanca 17'
    end
    click_button 'Voy a tener suerte'
  end

end
