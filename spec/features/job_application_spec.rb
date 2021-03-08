require 'rails_helper'

feature 'User visits the site' do
  describe 'as an employee' do
    scenario 'and cannot apply for a job opportunity in the company itself' do
      user = create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      create(:opportunity_analyst, status: :enable)
      create(:opportunity_manager, application_deadline: Date.today)
      login_as user, scope: :user

      visit root_path
      click_on 'Codante'
      click_on programador.title

      expect(current_path).not_to have_link('Candidatar-se',
                                            href: apply_company_job_opportunity_path(programador.company,
                                                                                     programador))
    end

    scenario 'and list the job applications for a job opportunity' do
      user = create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      gabriel = create(:user_candidate_gabriel)
      pedro = create(:user_candidate_pedro)
      paulo = create(:user_candidate_paulo)
      appl_gabriel = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                            job_opportunity: programador)
      appl_pedro = JobApplication.create!(candidate_profile: pedro.candidate_profile,
                                          job_opportunity: programador)
      appl_paulo = JobApplication.create!(candidate_profile: paulo.candidate_profile,
                                          job_opportunity: programador)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on programador.title

      expect(current_path).to eq(company_job_opportunity_path(programador.company, programador))
      expect(page).to have_link(gabriel.full_name,
                                href: company_job_opportunity_job_application_path(programador.company,
                                                                                   programador,
                                                                                   appl_gabriel))
      expect(page).to have_link(pedro.full_name,
                                href: company_job_opportunity_job_application_path(programador.company,
                                                                                   programador,
                                                                                   appl_pedro))
      expect(page).to have_link(paulo.full_name,
                                href: company_job_opportunity_job_application_path(programador.company,
                                                                                   programador,
                                                                                   appl_paulo))
    end

    scenario 'and shows details of an application for a job opportunity' do
      user = create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer, min_salary: 1000, max_salary: 3000)
      gabriel = create(:user_candidate_gabriel)
      gabriel.candidate_profile.update!(cellphone_number: '00999999999', biography: 'Sei Rails')
      JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                             job_opportunity: programador)

      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on programador.title
      click_on gabriel.full_name

      expect(page).to have_content("Vaga: #{programador.title} - #{programador.company.name}")
      expect(page).to have_content('Faixa salarial: R$ 1.000,00 - R$ 3.000,00')
      expect(page).to have_content("Número de vagas disponíveis: #{programador.total_job_opportunities}")
      expect(page).to have_content("Candidato: #{gabriel.full_name}")
      expect(page).to have_content(gabriel.candidate_profile.biography)
      expect(page).to have_content(gabriel.email)
      expect(page).to have_content('(00) 99999-9999')
    end

    scenario 'and refusals an application', js: true do
      user = create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer, min_salary: 1000, max_salary: 3000)
      gabriel = create(:user_candidate_gabriel)
      gabriel.candidate_profile.update!(cellphone_number: '00999999999', biography: 'Sei Rails')
      appl_gabriel = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                            job_opportunity: programador)

      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'
      click_on programador.title
      click_on gabriel.full_name
      click_on 'Recusar Candidatura'

      within('form#candidature-refusal-form') do
        fill_in 'Motivo da Recusa',	with: 'A vaga tem preferência para quem tem DDD 21.'
        click_on 'Enviar'
      end

      expect(current_path).to eq(company_job_opportunity_job_application_path(programador.company,
                                                                              programador,
                                                                              appl_gabriel))
      expect(page).to have_content('Candidatura recusada com sucesso')
      expect(page).to have_content('Status: Recusada')
      expect(page).not_to have_button('Recusar Candidatura')
    end
  end

  describe 'as a candidate' do
    scenario 'and applies to a job opportunity' do
      create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      create(:opportunity_analyst, status: :enable)
      create(:opportunity_manager, application_deadline: Date.today)

      user = create(:user_candidate_gabriel)
      login_as user, scope: :user

      visit root_path
      click_on 'Codante'
      click_on programador.title
      click_on 'Candidatar-se'

      job_a = JobApplication.last
      expect(page).to have_content('Sua candidatura já foi enviada, aguarde por uma resposta')
      expect(page).to have_content('Você já se candidatou a esta vaga')
      expect(page).to have_link('Detalhes da Candidatura',
                                href: company_job_opportunity_job_application_path(
                                  job_a.job_opportunity.company,
                                  job_a.job_opportunity,
                                  job_a
                                ))
      expect(page).not_to have_link('Candidatar-se',
                                    href: apply_company_job_opportunity_path(programador.company, programador))
    end

    scenario 'and cannot list the job applications for a job opportunity of a company' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      gabriel = create(:user_candidate_gabriel)
      pedro = create(:user_candidate_pedro)
      paulo = create(:user_candidate_paulo)
      appl_gabriel = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                            job_opportunity: programador)
      appl_pedro = JobApplication.create!(candidate_profile: pedro.candidate_profile,
                                          job_opportunity: programador)
      appl_paulo = JobApplication.create!(candidate_profile: paulo.candidate_profile,
                                          job_opportunity: programador)
      login_as gabriel, scope: :user

      visit root_path
      click_on 'Codante'
      click_on programador.title

      expect(current_path).to eq(company_job_opportunity_path(programador.company, programador))
      expect(page).not_to have_link(gabriel.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_gabriel))
      expect(page).not_to have_link(pedro.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_pedro))
      expect(page).not_to have_link(paulo.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_paulo))
      expect(page).to have_content('Você já se candidatou a esta vaga')
      expect(page).to have_link('Detalhes da Candidatura',
                                href: company_job_opportunity_job_application_path(programador.company,
                                                                                   programador,
                                                                                   appl_gabriel))
    end

    scenario 'and lists applications for job opportunities' do
      create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      analista = create(:opportunity_analyst, status: :enable)
      gerente = create(:opportunity_manager, application_deadline: Date.today)
      gabriel = create(:user_candidate_gabriel)
      gabriel_programador = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                                   job_opportunity: programador)
      gabriel_analista = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                                job_opportunity: analista)
      gabriel_gerente = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                               job_opportunity: gerente)

      login_as gabriel, scope: :user

      visit root_path
      click_on gabriel.username

      expect(page).to have_content("Vaga: #{programador.title} - #{programador.company.name}")
      expect(page).to have_link('Detalhes da Candidatura',
                                href: company_job_opportunity_job_application_path(programador.company,
                                                                                   programador,
                                                                                   gabriel_programador))
      expect(page).to have_content("Vaga: #{analista.title} - #{analista.company.name}")
      expect(page).to have_link('Detalhes da Candidatura',
                                href: company_job_opportunity_job_application_path(analista.company,
                                                                                   analista,
                                                                                   gabriel_analista))
      expect(page).to have_content("Vaga: #{gerente.title} - #{gerente.company.name}")
      expect(page).to have_link('Detalhes da Candidatura',
                                href: company_job_opportunity_job_application_path(gerente.company,
                                                                                   gerente,
                                                                                   gabriel_gerente))
    end
  end

  describe 'not logged in yet' do
    scenario 'and tries to apply for a job opportunity' do
      create(:user_admin)
      Company.last.update!(name: 'Codante',
                           cnpj: '01.987.654/0003-21',
                           site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      create(:opportunity_analyst, status: :enable)
      create(:opportunity_manager, application_deadline: Date.today)

      visit root_path
      click_on 'Codante'
      click_on programador.title
      click_on 'Candidatar-se'

      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and cannot list the job applications for a job opportunity' do
      create(:user_admin)
      Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
      programador = create(:opportunity_programmer)
      gabriel = create(:user_candidate_gabriel)
      pedro = create(:user_candidate_pedro)
      paulo = create(:user_candidate_paulo)
      appl_gabriel = JobApplication.create!(candidate_profile: gabriel.candidate_profile,
                                            job_opportunity: programador)
      appl_pedro = JobApplication.create!(candidate_profile: pedro.candidate_profile,
                                          job_opportunity: programador)
      appl_paulo = JobApplication.create!(candidate_profile: paulo.candidate_profile,
                                          job_opportunity: programador)

      visit root_path
      click_on 'Codante'
      click_on programador.title

      expect(current_path).to eq(company_job_opportunity_path(programador.company, programador))
      expect(page).not_to have_link(gabriel.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_gabriel))
      expect(page).not_to have_link(pedro.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_pedro))
      expect(page).not_to have_link(paulo.full_name,
                                    href: company_job_opportunity_job_application_path(programador.company,
                                                                                       programador,
                                                                                       appl_paulo))
      expect(page).not_to have_content('Você já se candidatou a esta vaga')
      expect(page).not_to have_link('Detalhes da Candidatura')
    end
  end
end
