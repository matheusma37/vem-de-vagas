require 'rails_helper'

feature 'User visits the site' do
  scenario 'and sees the index screen' do
    visit root_path

    expect(current_path).to eq('/')
    expect(page).to have_content('Vem de Vagas')
  end
end
