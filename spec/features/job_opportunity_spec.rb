require 'rails_helper'

feature 'A user login in the site' do
  describe 'as a employee' do
    scenario 'and creates a job opportunity' do
      user = User.create!(full_name: 'João', username: 'jojo',
                          email: 'jojo123@codante.com.br', password: '123456',
                          cpf: '01234567890',
                          about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Criar Vaga'

      within('form') do
        fill_in 'Título', with: 'Procura-se fazedor de código'
        fill_in 'Descrição', with: 'Precisa saber fazer código que não me faça questionar a vida'
        fill_in 'Salário mínimo',	with: '1100.00'
        fill_in 'Salário máximo',	with: '2000.00'
        choose 'pleno'
        fill_in 'Data de encerramento', with: Date.today.advance(days: 10)
        fill_in 'Total de vagas', with: '10'
        click_on 'Criar Vaga'
      end

      expect(current_path).to eq(company_path(user.company))
      expect(page).to have_content('Procura-se fazedor de código')
      expect(page).to have_content('Pleno')
      expect(page).to have_link('Criar Vaga', href: new_job_opportunity_path)
    end

    scenario 'and fields cannot stay blank' do
      user = User.create!(full_name: 'João', username: 'jojo',
                          email: 'jojo123@codante.com.br', password: '123456',
                          cpf: '01234567890',
                          about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Criar Vaga'

      within('form') do
        fill_in 'Título', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Salário mínimo',	with: ''
        fill_in 'Salário máximo',	with: ''
        fill_in 'Data de encerramento', with: ''
        fill_in 'Total de vagas', with: ''
        click_on 'Criar Vaga'
      end

      expect(page).to have_content('Não foi possível criar a vaga')
      expect(page).to have_content('Título não pode ficar em branco')
      expect(page).to have_content('Salário máximo não pode ficar em branco')
      expect(page).to have_content('Salário máximo não é um número')
      expect(page).to have_content('Salário mínimo não pode ficar em branco')
      expect(page).to have_content('Salário mínimo não é um número')
      expect(page).to have_content('Total de vagas não pode ficar em branco')
    end
  end
end
