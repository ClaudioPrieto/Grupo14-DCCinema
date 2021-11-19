RSpec.describe 'HomeView', type: :system do

    before do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
        DatabaseCleaner.start
    end

    it 'First Message' do
        visit root_path
        expect(page).to have_content('Bienvenido a DCCINEMA')
    end

    it 'Second Message' do
        visit root_path
        expect(page).to have_content('Tu cine Favorito!')
    end

    after do
        DatabaseCleaner.clean
    end
end
