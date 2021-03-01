require 'rails_helper'

feature 'Employee visits the site' do
  scenario 'and successfully signs up' do
    create(:user_admin)

    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'

    within('form') do
      fill_in 'Nome completo', with: 'João José Silva'
      fill_in 'Usuário', with: 'jojo_avlis'
      fill_in 'E-mail',	with: 'joaoze@codante.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      fill_in 'CPF',	with: '02345678910'
      fill_in 'Sobre mim',	with: 'Pessoa feliz e contente, que sorri com os dente.'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    within('nav') do
      expect(page).to have_content('jojo_avlis')
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Entrar')
    end

    user = User.last
    expect(user.employee_profile).to be_truthy
    expect(user.employee_profile).to be_an_instance_of(EmployeeProfile)
  end

  scenario 'and is assigned to a Company' do
    create(:user_admin)

    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'

    within('form') do
      fill_in 'Nome completo', with: 'João José Silva'
      fill_in 'Usuário', with: 'jojo_avlis'
      fill_in 'E-mail',	with: 'josejao@codante.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      fill_in 'CPF',	with: '02345678910'
      fill_in 'Sobre mim',	with: 'Pessoa feliz e contente, que sorri com os dente.'
      click_on 'Inscrever-se'
    end

    profile = User.last.employee_profile
    expect(profile.company).to be_truthy
    expect(profile.company).to eql(Company.last)
  end

  scenario 'and logs in' do
    user = create(:user_admin)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Minha Empresa', href: company_path(user.company))
  end

  scenario 'open show page' do
    user = create(:user_admin)

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'
    end
    click_on user.username

    expect(page).to have_content(user.about_me)
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.cpf)
    expect(page).to have_content(user.email)
    expect(page).to have_css('img[src*="assets/avatar_placeholder"]', count: 2)
    expect(page).to have_link('jojo', href: employee_path(user))
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'edits the profile' do
    user = create(:user_admin)

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'
    end

    click_on user.username
    click_on 'Editar Perfil'

    within('form') do
      fill_in 'Nome completo', with: 'João José Silva e Santos'
      fill_in 'Usuário', with: 'josilsan'
      fill_in 'CPF',	with: '02345678910'
      fill_in 'Sobre mim',	with: 'Gosto de rock e de cachorrinhos.'
      fill_in 'Código de funcionário',	with: '191738'
      fill_in 'Papel',	with: 'Gerente'
      click_on 'Atualizar Usuário'
    end

    user.reload
    expect(page).to have_content(user.about_me)
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.cpf)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.employee_profile.role)
    expect(page).to have_content(user.employee_profile.employee_code)
    expect(page).to have_css('img[src*="assets/avatar_placeholder"]', count: 2)
    expect(current_path).to eq(employee_path(user))
    expect(page).to have_link('Voltar', href: root_path)
  end
end
