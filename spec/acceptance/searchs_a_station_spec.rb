require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Searchs a station" do
  fixtures :stations, :cities

  scenario "and finds it" do
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
    end
 end

  scenario "and doesn't find it" do
    visit '/'

    within :css, '#home-content .buscador' do
      fill_in 'postal_code', :with => 'wadus'
    end
    click_button 'Voy a tener suerte'
    #page.should have_content('No hemos encontrado una estación cercana')
  end

end
