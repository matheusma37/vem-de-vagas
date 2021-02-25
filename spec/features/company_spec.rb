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

    scenario 'and edits the company information' do
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

      within('form') do
        fill_in 'Nome', with: 'Codante'
        fill_in 'CNPJ',	with: '12.345.678/0009-10'
        fill_in 'Descrição', with: 'Empresa fazedora de código'
        fill_in 'Data de criação', with: '2003-02-01'
        fill_in 'Endereço', with: 'Rua ABC, nº 007, Pq. Beta, Los Angeles - Acre'
        fill_in 'Site da empresa', with: 'www.codan.te'
        click_on 'Atualizar Empresa'
      end

      expect(current_path).to eq(company_path(Company.last))
      expect(page).to have_content('Codante')
      expect(page).to have_content('12.345.678/0009-10')
      expect(page).to have_content('Empresa fazedora de código')
      expect(page).to have_content('Trabalhando desde: 01 de fevereiro de 2003')
      expect(page).to have_content('Rua ABC, nº 007, Pq. Beta, Los Angeles - Acre')
      expect(page).to have_content('www.codan.te')
      expect(page).to have_link('Voltar', href: root_path)
    end

    scenario 'and cnpj and site must be unique' do
      visit root_path
      click_on 'Entrar'
      click_on 'Inscrever-se'

      within('form') do
        fill_in 'Nome completo', with: 'João José Silva'
        fill_in 'Usuário', with: 'jojo_avlis'
        fill_in 'E-mail', with: 'jojo@codante.com.br'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        fill_in 'CPF', with: '12345678910'
        fill_in 'Sobre mim', with: 'Pessoa feliz e contente, que sorri com os dente.'
        click_on 'Inscrever-se'
      end

      Company.create!(email_domain: 'test.com', admin: User.last,
                      site: 'www.codan.te', cnpj: '12.345.678/0009-10')

      within('form') do
        fill_in 'Nome', with: 'Codante'
        fill_in 'CNPJ',	with: '12.345.678/0009-10'
        fill_in 'Descrição', with: 'Empresa fazedora de código'
        fill_in 'Data de criação', with: '2003-02-01'
        fill_in 'Endereço', with: 'Rua ABC, nº 007, Pq. Beta, Los Angeles - Acre'
        fill_in 'Site da empresa', with: 'www.codan.te'
        click_on 'Atualizar Empresa'
      end

      expect(page).to have_content('Não foi possível editar a empresa')
      expect(page).to have_content('CNPJ já está em uso')
      expect(page).to have_content('Site da empresa já está em uso')
    end
  end
end
