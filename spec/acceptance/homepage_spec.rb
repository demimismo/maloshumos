require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Homepage" do

  scenario "should display active stations" do
    visit '/'

    page.should have_css('#home-content .buscador')
  end
end
