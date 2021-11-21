RSpec.describe 'Movies', type: :system do

    before do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        DatabaseCleaner.start
        visit '/movies/new'
        fill_in 'movie_name', :with => 'Spiderman'
        fill_in 'movie_image', :with => 'https://sm.ign.com/ign_es/movie/s/spider-man/spider-man-3-tom-holland_8m76.jpg'
        click_button 'Guardar'
    end

    it 'go to movies index' do
        visit root_path
        click_link 'Ver películas existentes'
        expect(page).to have_content('Películas')
    end

    it 'create movie' do
        visit '/movies/new'
        fill_in 'movie_name', :with => 'Shingeki no Kyojin'
        fill_in 'movie_image', :with => 'https://as02.epimg.net/meristation/imagenes/2021/03/19/noticias/1616147119_376716_1616147387_noticia_normal_recorte1.jpg'
        click_button 'Guardar'
        expect(page).to have_content('Movie was successfully created.')
        expect(page).to have_content('Shingeki no Kyojin')
    end

    it 'see info of created movie' do
        visit '/movies'
        click_link 'Spiderman_info'
        expect(page).to have_content('Película: Spiderman')
        expect(page).to have_content('Editar')
        expect(page).to have_content('Volver')
    end

    it 'delete created movie' do
        visit '/movies'
        accept_confirm do
            click_link 'Spiderman_delete'
        end
        expect(page).to have_content('Movie was successfully destroyed.')
        expect(page).not_to have_content('Spiderman')
    end
    
    it 'edit created movie' do
        visit '/movies'
        click_link 'Spiderman_edit'
        fill_in 'movie_name', :with => 'Spiderman: No Way Home'
        fill_in 'movie_image', :with => 'https://es.web.img2.acsta.net/c_310_420/pictures/21/11/15/18/17/0807353.jpg'
        click_button 'Guardar'
        expect(page).to have_content('Movie was successfully updated.')
        expect(page).to have_content('Spiderman: No Way Home')
        click_link 'Volver'
        expect(page).to have_content('Spiderman: No Way Home')
    end

    it 'return to home' do
        visit '/movies'
        click_link 'Volver al home'
        expect(page).to have_content('Bienvenido a DCCINEMA')
    end

    after do
        DatabaseCleaner.clean
    end
end