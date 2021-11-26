RSpec.describe 'Reservations', type: :system do

  before do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      DatabaseCleaner.start
      load "#{Rails.root}/db/seeds.rb" 
      visit '/movies/new'
      fill_in 'movie_name', :with => 'Shingeki no Kyojin'
      fill_in 'movie_image', :with => 'https://as02.epimg.net/meristation/imagenes/2021/03/19/noticias/1616147119_376716_1616147387_noticia_normal_recorte1.jpg'
      click_button 'Guardar'

      visit 'movie_instances/new'
      select "Shingeki no Kyojin", :from => "movie_instance_movie_id"
      select 1 , :from => "movie_instance_room_id"
      select "2021", :from => "movie_instance_day_1i"
      select "November", :from => "movie_instance_day_2i"
      select "23", :from => "movie_instance_day_3i"
      select "MATINE", :from => "movie_instance_schedule"
      click_button 'Añadir función'
  end

  it 'create reservation' do
      visit '/movie_instances'
      click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
      fill_in 'reservation_username', :with => 'Tester'
      select 'A', :from => "row-selector"
      select 1, :from => "col-selector"
      select 2, :from => "col-selector"
      click_button 'Reservar'
      expect(page).to have_content('Reservation was successfully created.')
  end

  it 'see info of reservation' do
      visit '/movie_instances'
      click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
      fill_in 'reservation_username', :with => 'Tester'
      select 'A', :from => "row-selector"
      select 1, :from => "col-selector"
      click_button 'Reservar'

      click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
      expect(page).to have_select('col-selector', :options => ["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
  end

  it 'see view of reservation css' do
    visit '/movie_instances'
    click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
    fill_in 'reservation_username', :with => 'Tester'
    select 'A', :from => "row-selector"
    select 1, :from => "col-selector"
    click_button 'Reservar'

    click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
    expect(page).to have_css(".row", :count => 5)
    expect(page).to have_css(".bg-success", :count => 12*4 - 1)
    expect(page).to have_css(".bg-danger", :count => 1)
end


  it 'return to instances' do
      visit '/movie_instances'
      click_link 'Shingeki no Kyojin_2021-11-23_new_reservation'
      click_link 'Volver'
      expect(page).to have_content('Funciones')
  end

  after do
      DatabaseCleaner.clean
  end
end