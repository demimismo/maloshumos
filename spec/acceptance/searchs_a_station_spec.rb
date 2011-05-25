require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Searchs a station" do
  fixtures :stations, :cities

  scenario "using the form on the homepage" do
    visit '/'
  
    within :css, '#home-content .buscador' do
      fill_in 'postal_code', :with => 'plaza del carmen'
    end
 
    click_button 'Voy a tener suerte'

    page.should have_css('#station-content')
    within :css, '#station-content' do
      page.should have_content('Plaza del Carmen')
    end

    visit '/'
  
    within :css, '#home-content .buscador' do
      fill_in 'postal_code', :with => 'méndez álvaro'
    end
 
    click_button 'Voy a tener suerte'

    within :css, '#station-content' do
      page.should have_content('Méndez Álvaro')
      page.should_not have_content('Plaza del Carmen')
    end
  end


  scenario "using the select box on the homepage" do
    visit '/'

    page.select 'Méndez Álvaro', :from => 'station_id'
    click_button 'Ir'

    within :css, '#station-content' do
      page.should have_content('Méndez Álvaro')
      page.should_not have_content('Plaza del Carmen')
    end
    
  end

end

