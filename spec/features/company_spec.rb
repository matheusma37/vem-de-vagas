require 'rails_helper'

feature 'User visits the site' do
  describe 'signs up as employee' do
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

    scenario 'and redirects to edit the company information' do
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
      expect(page).to have_css('img[src*="/assets/logo_placeholder"]')
      expect(page).to have_css('img[src*="/assets/cover_placeholder"]')
      expect(page).to have_link('Voltar', href: root_path)
    end

    scenario 'and cnpj and site must be unique' do
      user = create(:user_admin)
      create(:company)
      login_as user, scope: :user

      visit edit_company_path(Company.first)
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

    scenario 'and name, cnpj and site cannot stay blank' do
      user = create(:user_admin)
      create(:company)
      login_as user, scope: :user

      visit edit_company_path(Company.first)
      within('form') do
        fill_in 'Nome', with: ''
        fill_in 'CNPJ',	with: ''
        fill_in 'Descrição', with: 'Empresa fazedora de código'
        fill_in 'Data de criação', with: '2003-02-01'
        fill_in 'Endereço', with: 'Rua ABC, nº 007, Pq. Beta, Los Angeles - Acre'
        fill_in 'Site da empresa', with: ''
        click_on 'Atualizar Empresa'
      end

      expect(page).to have_content('Não foi possível editar a empresa')
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('CNPJ não pode ficar em branco')
      expect(page).to have_content('Site da empresa não pode ficar em branco')
    end

    scenario 'and adds logo and cover image' do
      user = create(:user_admin)
      login_as user, scope: :user

      visit edit_company_path(Company.last)
      within('form') do
        attach_file 'Logo', Rails.root.join('spec', 'support', 'logo.png')
        attach_file 'Foto de capa', Rails.root.join('spec', 'support', 'cover.png')
        fill_in 'Nome', with: 'Codante'
        fill_in 'CNPJ',	with: '12.345.678/0009-10'
        fill_in 'Descrição', with: 'Empresa fazedora de código'
        fill_in 'Data de criação', with: '2003-02-01'
        fill_in 'Endereço', with: 'Rua ABC, nº 007, Pq. Beta, Los Angeles - Acre'
        fill_in 'Site da empresa', with: 'www.codan.te'
        click_on 'Atualizar Empresa'
      end

      expect(page).to have_content('Codante')
      expect(page).to have_css('img[src*="logo.png"]')
      expect(page).to have_css('img[src*="cover.png"]')
    end
  end

  describe 'login as employee' do
    scenario "and only the admin can see the company's edit button" do
      create(:user_admin)
      user = create(:user_employee)
      login_as user, scope: :user

      visit root_path
      click_on 'Minha Empresa'

      expect(page).not_to have_link('Editar Empresa', href: edit_company_path(user.company))
    end

    scenario "and a non-admin cannot access the company's edit view" do
      create(:user_admin)
      user = create(:user_employee)
      login_as user, scope: :user
      visit edit_company_path(user.company)

      expect(current_path).to eq(company_path(user.company))
      expect(page).to have_content('Apenas o administrador pode editar as informações da empresa')
    end
  end

  describe 'stays not logged' do
    scenario 'and see the list of companies' do
      user1 = create(:user_admin)
      user2 = create(:user_employee)
      company1_name = user1.email.split('.')[1].capitalize
      company2_name = user2.email.split('.')[1].capitalize
      Company.first.update!(name: company1_name,
                            cnpj: '12.345.678/0009-10',
                            site: "www.#{company1_name.downcase}.com")
      Company.last.update!(name: company2_name,
                           cnpj: '01.987.654/0003-21',
                           site: "www.#{company2_name.downcase}.com")

      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_link(company1_name, href: company_path(Company.first))
      expect(page).to have_link(company2_name, href: company_path(Company.last))
    end

    scenario "and cannot see the company's edit button" do
      user = create(:user_admin)
      company_name = user.email.split('.')[1].capitalize
      Company.first.update!(name: company_name,
                            cnpj: '12.345.678/0009-10',
                            site: "www.#{company_name.downcase}.com")

      visit root_path
      click_on company_name

      expect(page).not_to have_link('Editar Empresa', href: edit_company_path(Company.first))
    end
  end
end
