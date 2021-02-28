require 'rails_helper'

feature 'User visits the site' do
  scenario 'and sees the index screen' do
    visit root_path

    expect(current_path).to eq('/')
    expect(page).to have_content('Vem de Vagas')
  end

  scenario 'search for a company successfully' do
    create(:user_admin)
    Company.last.update!(name: 'Codante',
                         cnpj: '01.987.654/0003-21',
                         site: 'www.codante.com')
    create(:user_admin, email: 'admin2@fazcodigo.com')
    Company.last.update!(name: 'Faz Código',
                         cnpj: '01.987.654/0003-32',
                         site: 'www.fazcodigo.com')
    create(:user_admin, email: 'admin3@fCodeme.com')
    Company.last.update!(name: 'Code.me',
                         cnpj: '01.987.654/0003-43',
                         site: 'www.code.me')

    visit root_path
    fill_in 'Busca:', with: 'Cod'
    check 'empresas'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within 'div.companies' do
      expect(page).to have_link('Codante', href: company_path(Company.first))
      expect(page).to have_link('Code.me', href: company_path(Company.last))
    end
  end

  scenario 'search for a company unsuccessfully' do
    visit root_path
    fill_in 'Busca:', with: 'Cod'
    check 'empresas'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within 'div.companies' do
      expect(page).to have_content('Nenhum resultado encontrado...')
    end
  end

  scenario 'search for a job opportunity successfully' do
    create(:user_admin)
    Company.first.update!(name: 'Codante', cnpj: '12.345.678/0009-10', site: 'www.codante.com')
    create(:opportunity_programmer)
    analista = create(:opportunity_analyst, status: :enable)
    gerente = create(:opportunity_manager, application_deadline: Date.today.advance(days: 10))

    visit root_path
    fill_in 'Busca:', with: 'projetos'
    check 'vagas'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within 'div.job_opportunities' do
      expect(page).to have_link(analista.title, href: job_opportunity_path(analista))
      expect(page).to have_link(gerente.title, href: job_opportunity_path(gerente))
    end
  end

  scenario 'search for a job opportunity unsuccessfully' do
    visit root_path
    fill_in 'Busca:', with: 'Cod'
    check 'vagas'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within 'div.job_opportunities' do
      expect(page).to have_content('Nenhum resultado encontrado...')
    end
  end

  scenario 'search for a company successfully' do
    create(:user_admin)
    Company.last.update!(name: 'Codante',
                         cnpj: '01.987.654/0003-21',
                         site: 'www.codante.com')
    create(:user_admin, email: 'admin2@fazcodigo.com')
    Company.last.update!(name: 'Faz Código',
                         cnpj: '01.987.654/0003-32',
                         site: 'www.fazcodigo.com')
    create(:user_admin, email: 'admin3@fCodeme.com')
    Company.last.update!(name: 'Code.me',
                         cnpj: '01.987.654/0003-43',
                         site: 'www.code.me')

    create(:opportunity_analyst, status: :enable)
    programador = create(:opportunity_programmer)
    gerente = create(:opportunity_manager, application_deadline: Date.today.advance(days: 10))

    visit root_path
    fill_in 'Busca:', with: 'd'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within 'div.companies' do
      expect(page).to have_link('Codante', href: company_path(Company.first))
      expect(page).to have_link('Faz Código', href: company_path(Company.second))
      expect(page).to have_link('Code.me', href: company_path(Company.last))
    end
    within 'div.job_opportunities' do
      expect(page).to have_link(programador.title, href: job_opportunity_path(programador))
      expect(page).to have_link(gerente.title, href: job_opportunity_path(gerente))
    end
  end
end
