require 'rails_helper'

feature 'A user visits the site' do
  describe 'as a employee' do
    scenario 'and creates a job opportunity' do
      user = create(:user_admin)
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
      user = create(:user_admin)
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

    scenario 'and sees job opportunities of the company' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst)
      gerente = create(:opportunity_manager)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).to have_content('Vagas disponíveis: 1')
      expect(page).to have_content('Nível: Sênior')
      expect(page).to have_content('Habilitada', count: 1)
      expect(page).to have_content('Desabilitada', count: 2)
    end

    scenario 'and sees the details of a job opportunity' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      create(:opportunity_programmer)
      analista = create(:opportunity_analyst, application_deadline: 10.days.since(Date.today), status: :enable)
      create(:opportunity_manager)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Analista'

      expect(current_path).to eq(job_opportunity_path(analista))
      expect(page).to have_content('Analista')
      expect(page).to have_content('Salário: R$ 2.500,00 - R$ 4.000,00')
      expect(page).to have_content('Analisar projetos')
      expect(page).to have_content('Pleno')
      expect(page).to have_content("Vaga disponível até #{I18n.l(Date.today.advance(days: 10), format: :long)}")
      expect(page).to have_content('Habilitada')
      expect(page).to have_content('Número de vagas disponíveis: 2')
      expect(page).to have_link('Codante', href: company_path(analista.company))
      expect(page).to have_link('Inativar', href: disable_job_opportunity_path(analista))
      expect(page).to have_link('Voltar', href: company_path(analista.company))
    end

    scenario 'and edits a job opportunity' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      create(:opportunity_analyst)
      create(:opportunity_manager)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Programador'
      click_on 'Editar Vaga'

      within('form') do
        fill_in 'Título', with: 'Procura-se fazedor de código'
        fill_in 'Descrição', with: 'Precisa saber fazer código que não me faça questionar a vida'
        fill_in 'Salário mínimo',	with: '1100.00'
        fill_in 'Salário máximo',	with: '2000.00'
        choose 'pleno'
        fill_in 'Data de encerramento', with: Date.today.advance(days: 10)
        fill_in 'Total de vagas', with: '10'
        choose 'enable'
        click_on 'Atualizar Vaga'
      end

      expect(current_path).to eq(job_opportunity_path(programador))
      expect(page).to have_content('Procura-se fazedor de código')
      expect(page).to have_content('Pleno')
      expect(page).to have_link('Editar Vaga', href: edit_job_opportunity_path(programador))
    end

    scenario 'and edits a job opportunity, fields cannot stay blank' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      create(:opportunity_programmer)
      create(:opportunity_analyst)
      create(:opportunity_manager)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Programador'
      click_on 'Editar Vaga'

      within('form') do
        fill_in 'Título', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Salário mínimo',	with: ''
        fill_in 'Salário máximo',	with: ''
        fill_in 'Data de encerramento', with: ''
        fill_in 'Total de vagas', with: ''
        click_on 'Atualizar Vaga'
      end

      expect(page).to have_content('Não foi possível atualizar a vaga')
      expect(page).to have_content('Título não pode ficar em branco')
      expect(page).to have_content('Salário máximo não pode ficar em branco')
      expect(page).to have_content('Salário máximo não é um número')
      expect(page).to have_content('Salário mínimo não pode ficar em branco')
      expect(page).to have_content('Salário mínimo não é um número')
      expect(page).to have_content('Total de vagas não pode ficar em branco')
    end

    scenario 'and enable a job opportunity' do
      user = create(:user_admin)
      login_as user, scope: :user
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      create(:opportunity_programmer)
      analista = create(:opportunity_analyst, application_deadline: 10.days.since(Date.today))
      create(:opportunity_manager)

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Analista'
      click_on 'Ativar'

      expect(current_path).to eq(job_opportunity_path(analista))
      expect(page).to have_content('Habilitada')
      expect(page).to have_link('Inativar', href: disable_job_opportunity_path(analista))
      expect(page).to have_link('Voltar', href: company_path(analista.company))
      expect(analista.reload.enable?).to be(true)
    end

    scenario 'and disable a job opportunity' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      create(:opportunity_programmer)
      analista = create(:opportunity_analyst,
                        application_deadline: 10.days.since(Date.today),
                        status: :enable)
      create(:opportunity_manager)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on 'Analista'
      click_on 'Inativar'

      expect(current_path).to eq(job_opportunity_path(analista))
      expect(page).to have_content('Desabilitada')
      expect(page).to have_link('Ativar', href: enable_job_opportunity_path(analista))
      expect(page).to have_link('Voltar', href: company_path(analista.company))
      expect(analista.reload.disable?).to be(true)
    end
  end

  describe 'as a visitor' do
    scenario 'and sees job opportunities' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager, application_deadline: Date.today)

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).to have_content('Vagas disponíveis: 1')
      expect(page).to have_content('Nível: Sênior')
    end

    scenario 'and only sees enabled job opportunities' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager, status: :disable, application_deadline: Date.today)

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Sênior')
    end

    scenario 'only see job opportunities that are still on deadline' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager)

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Sênior')
    end

    scenario 'and sees job opportunities of a company' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager, application_deadline: Date.today)

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).to have_content('Vagas disponíveis: 1')
      expect(page).to have_content('Nível: Sênior')
    end

    scenario 'and only sees enabled job opportunities of a company' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager, status: :disable, application_deadline: Date.today)

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Sênior')
    end

    scenario 'and cannot access job opportunities out of deadline' do
      create(:user_admin)
      gerente = create(:opportunity_manager)

      visit job_opportunity_path(gerente)

      expect(current_path).to eq(root_path)
    end

    scenario 'only see job opportunities of a company that are still on deadline' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager)

      visit root_path
      click_on 'Codante'

      expect(current_path).to eq(company_path(Company.first))
      expect(page).to have_link('Programador', href: job_opportunity_path(programador))
      expect(page).to have_content('Vagas disponíveis: 4')
      expect(page).to have_content('Nível: Júnior')
      expect(page).to have_link('Analista', href: job_opportunity_path(analista))
      expect(page).to have_content('Vagas disponíveis: 2')
      expect(page).to have_content('Nível: Pleno')
      expect(page).not_to have_link('Gerente de projetos', href: job_opportunity_path(gerente))
      expect(page).not_to have_content('Vagas disponíveis: 1')
      expect(page).not_to have_content('Nível: Sênior')
    end

    scenario 'and sees the details of a job opportunity' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      create(:opportunity_programmer)
      create(:opportunity_manager)
      analista = create(:opportunity_analyst, application_deadline: 10.days.since(Date.today), status: :enable)

      visit root_path
      click_on 'Codante'
      click_on 'Analista'

      expect(current_path).to eq(job_opportunity_path(analista))
      expect(page).to have_content('Analista')
      expect(page).to have_content('Salário: R$ 2.500,00 - R$ 4.000,00')
      expect(page).to have_content('Analisar projetos')
      expect(page).to have_content('Pleno')
      expect(page).to have_content("Vaga disponível até #{I18n.l(Date.today.advance(days: 10), format: :long)}")
      expect(page).to have_content('Número de vagas disponíveis: 2')
      expect(page).to have_link('Codante', href: company_path(analista.company))
      expect(page).to have_link('Voltar', href: company_path(analista.company))
    end

    scenario 'and cannot sees the details of a disabled job opportunity' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')

      create(:opportunity_programmer)
      create(:opportunity_manager)
      analista = create(:opportunity_analyst)

      visit job_opportunity_path(analista)

      expect(current_path).to eq(root_path)
    end
  end
end
