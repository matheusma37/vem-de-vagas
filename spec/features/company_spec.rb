require 'rails_helper'

feature 'Employee visits the site' do
  describe 'signs up' do
    scenario 'and is the first to assign to a company' do
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

      expect(current_path).to eq(edit_company_path(Company.last))
      expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
      expect(page).to have_content('Edite as informações de sua empresa')
    end

    # TODO: implements this part
    scenario 'and edits the company information' do
      pending
    end
  end
end
