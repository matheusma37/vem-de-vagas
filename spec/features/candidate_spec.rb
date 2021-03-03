require 'rails_helper'

feature 'Candidate visits the site' do
  scenario 'and successfully signs up' do
    visit root_path
    click_on 'Entrar'
    click_on 'Inscrever-se'

    within('form') do
      fill_in 'Nome completo', with: 'Gabriel Romero Jr.'
      fill_in 'Usuário', with: 'ga_rome'
      fill_in 'E-mail',	with: 'garome73@gmail.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      fill_in 'CPF',	with: '12345678910'
      fill_in 'Sobre mim',	with: 'Amo pão e batatinhas.'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    within('nav') do
      expect(page).to have_content('ga_rome')
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Entrar')
    end

    user = User.last
    expect(user.employee_profile).not_to be_truthy
    expect(user.candidate_profile).to be_truthy
    expect(user.candidate_profile).to be_an_instance_of(CandidateProfile)
    expect(current_path).to eq(candidate_path(user))
  end

  scenario 'and logs in' do
    user = create(:user_candidate_gabriel)

    visit root_path
    click_on 'Entrar'

    within('form') do
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('ga_rome', href: candidate_path(user))
  end

  scenario 'and opens show page' do
    user = create(:user_candidate_gabriel)

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
    expect(page).to have_link('ga_rome', href: candidate_path(user))
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and edits the profile' do
    user = create(:user_candidate_gabriel)

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
      fill_in 'Nome completo', with: ''
      fill_in 'Usuário', with: ''
      fill_in 'CPF',	with: ''
      fill_in 'Sobre mim',	with: ''
      fill_in 'Número de celular',	with: ''
      fill_in 'Biografia',	with: ''
      click_on 'Atualizar Usuário'
    end

    expect(page).to have_content('Usuário não pode ficar em branco')
    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('CPF não é válido')
  end
end
