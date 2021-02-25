require 'rails_helper'

feature 'User visits the site' do
  scenario 'and successfully signs up' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'

    within('form') do
      fill_in 'Nome completo', with: 'João José Silva'
      fill_in 'Usuário', with: 'jojo_avlis'
      fill_in 'E-mail',	with: 'jojo@codante.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      fill_in 'CPF',	with: '12345678910'
      fill_in 'Sobre mim',	with: 'Pessoa feliz e contente, que sorri com os dente.'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    within('nav') do
      expect(page).to have_content('jojo_avlis')
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Entrar')
    end
  end

  scenario 'and signs up with photo' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'

    within('form') do
      attach_file 'Foto de perfil', Rails.root.join('spec', 'support', 'my_profile.jpg')
      fill_in 'Nome completo', with: 'João José Silva'
      fill_in 'Usuário', with: 'jojo_avlis'
      fill_in 'E-mail',	with: 'jojo@codante.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      fill_in 'CPF',	with: '12345678910'
      fill_in 'Sobre mim',	with: 'Pessoa feliz e contente, que sorri com os dente.'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to have_css('img[src*="my_profile.jpg"]')
  end
end
