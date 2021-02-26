require 'rails_helper'

feature 'A user visits the site' do
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

  describe 'as a visitor' do
    scenario 'and sees job opportunities' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, status: :enable,
                                           company: Company.last)
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, status: :enable,
                                        company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, status: :enable,
                                       company: Company.last)

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).to have_content('Vagas disponíveis: 1')
      expect(page).to have_content('Nível: Senior')
    end

    scenario 'and only sees enabled job opportunities' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, status: :enable,
                                           company: Company.last)
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, status: :enable,
                                        company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, status: :disable,
                                       company: Company.last)

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Senior')
    end

    scenario 'only see job opportunities that are still on deadline' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, company: Company.last,
                                           application_deadline: Date.today.advance(days: 1))
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, company: Company.last,
                                       application_deadline: Date.today.ago(1.day))

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Senior')
    end

    scenario 'and sees job opportunities of a company' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, status: :enable,
                                           company: Company.last)
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, status: :enable,
                                        company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, status: :enable,
                                       company: Company.last)

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).to have_content('Vagas disponíveis: 1')
      expect(page).to have_content('Nível: Senior')
    end

    scenario 'and only sees enabled job opportunities of a company' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, status: :enable,
                                           company: Company.last)
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, status: :enable,
                                        company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, status: :disable,
                                       company: Company.last)

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Senior')
    end

    scenario 'only see job opportunities of a company that are still on deadline' do
      User.create!(full_name: 'João', username: 'jojo',
                   email: 'jojo123@codante.com.br', password: '123456',
                   cpf: '01234567890',
                   about_me: 'Admin raivoso, gótico e trevoso.')
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = JobOpportunity.create!(title: 'Programador', max_salary: 1000.00,
                                           min_salary: 3000.00, professional_level: :junior,
                                           total_job_opportunities: 4, company: Company.last,
                                           application_deadline: Date.today.advance(days: 1))
      analista = JobOpportunity.create!(title: 'Analista', max_salary: 2500.00,
                                        min_salary: 4000.00, professional_level: :pleno,
                                        total_job_opportunities: 2, company: Company.last)
      gerente = JobOpportunity.create!(title: 'Gerente de projetos', max_salary: 5000.00,
                                       min_salary: 8000.00, professional_level: :senior,
                                       total_job_opportunities: 1, company: Company.last,
                                       application_deadline: Date.today.ago(1.day))

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Junior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Senior')
    end
  end
end
