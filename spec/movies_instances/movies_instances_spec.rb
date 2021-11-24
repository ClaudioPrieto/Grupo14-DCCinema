RSpec.describe 'Movies', type: :system do

    before do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        DatabaseCleaner.start
        load "#{Rails.root}/db/seeds.rb" 
        visit '/movies/new'
        fill_in 'movie_name', :with => 'Spiderman'
        fill_in 'movie_image', :with => 'https://sm.ign.com/ign_es/movie/s/spider-man/spider-man-3-tom-holland_8m76.jpg'
        click_button 'Guardar'

        visit '/movies/new'
        fill_in 'movie_name', :with => 'Shingeki no Kyojin'
        fill_in 'movie_image', :with => 'https://as02.epimg.net/meristation/imagenes/2021/03/19/noticias/1616147119_376716_1616147387_noticia_normal_recorte1.jpg'
        click_button 'Guardar'

        visit '/movies/new'
        fill_in 'movie_name', :with => 'El Conjuro 3'
        fill_in 'movie_image', :with => 'https://c.min.ms/t/d/member/c/113/113934/pagegallery/1623417411/7e778e81.jpg'
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

    it 'go to movies instances index' do
        visit root_path
        click_link 'Ver Funciones'
        expect(page).to have_content('Funciones')
        expect(page).to have_content('Nueva Función')
    end

    it 'create movie instance' do
        visit '/movie_instances/new'
        select "Spiderman", :from => "movie_instance_movie_id"
        select 1 , :from => "movie_instance_room_id"
        select "2021", :from => "movie_instance_day_1i"
        select "November", :from => "movie_instance_day_2i"
        select "24", :from => "movie_instance_day_3i"
        select "MATINE", :from => "movie_instance_schedule"
        click_button 'Añadir función'
        expect(page).to have_content('Movie instance was successfully created.')
        expect(page).to have_content('Película: Spiderman')
        expect(page).to have_content('Sala: 1')
        expect(page).to have_content('Día: 2021-11-24')
        expect(page).to have_content('Horario: MATINE')
    end

    it 'see info of movie instance' do
        visit '/movie_instances'
        click_link 'Shingeki no Kyojin_2021-11-23_info'
        expect(page).to have_content('Película: Shingeki no Kyojin')
        expect(page).to have_content('Sala: 1')
        expect(page).to have_content('Día: 2021-11-23')
        expect(page).to have_content('Horario: MATINE')
    end

    it 'delete created movie instance' do
        visit '/movie_instances'
        accept_confirm do
            click_link 'Shingeki no Kyojin_2021-11-23_delete'
        end
        expect(page).to have_content('Movie instance was successfully destroyed.')
        expect(page).not_to have_content('Shingeki no Kyojin')
    end

    it 'edit created movie instance' do
        visit '/movie_instances'
        click_link 'Shingeki no Kyojin_2021-11-23_edit'
        select "Shingeki no Kyojin", :from => "movie_instance_movie_id"
        select 2 , :from => "movie_instance_room_id"
        select "2021", :from => "movie_instance_day_1i"
        select "December", :from => "movie_instance_day_2i"
        select "25", :from => "movie_instance_day_3i"
        select "TANDA", :from => "movie_instance_schedule"
        click_button 'Añadir función'
        expect(page).to have_content('Movie instance was successfully updated.')
        expect(page).to have_content('Película: Shingeki no Kyojin')
        expect(page).to have_content('Sala: 2')
        expect(page).to have_content('Día: 2021-12-25')
        expect(page).to have_content('Horario: TANDA')
    end

    it 'error at create movie instance in same schedule as other movie' do
        visit '/movie_instances/new'
        select "Spiderman", :from => "movie_instance_movie_id"
        select 1 , :from => "movie_instance_room_id"
        select "2021", :from => "movie_instance_day_1i"
        select "November", :from => "movie_instance_day_2i"
        select "23", :from => "movie_instance_day_3i"
        select "MATINE", :from => "movie_instance_schedule"
        click_button 'Añadir función'
        expect(page).to have_content('Ya existe una función este dia en el mismo horario y sala')
        visit '/movie_instances'
        expect(page).not_to have_content('Spiderman')
    end

    it 'error at update movie instance in same schedule as other movie' do
        visit '/movie_instances/new'
        select "Spiderman", :from => "movie_instance_movie_id"
        select 1 , :from => "movie_instance_room_id"
        select "2021", :from => "movie_instance_day_1i"
        select "November", :from => "movie_instance_day_2i"
        select "24", :from => "movie_instance_day_3i"
        select "MATINE", :from => "movie_instance_schedule"
        click_button 'Añadir función'

        visit '/movie_instances'
        click_link 'Spiderman_2021-11-24_edit'
        select "Spiderman", :from => "movie_instance_movie_id"
        select 1 , :from => "movie_instance_room_id"
        select "2021", :from => "movie_instance_day_1i"
        select "November", :from => "movie_instance_day_2i"
        select "23", :from => "movie_instance_day_3i"
        select "MATINE", :from => "movie_instance_schedule"
        click_button 'Añadir función'

        expect(page).to have_content('Ya existe una función este dia en el mismo horario y sala')
    end


    it 'return to home' do
        visit '/movie_instances'
        click_link 'Volver al home'
        expect(page).to have_content('Bienvenido a DCCINEMA')
    end


    after do
        DatabaseCleaner.clean
    end
end