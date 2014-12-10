module FeatureMethods
  def sign_in(user)
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within('.actions') do
      click_on 'Sign in'
    end
  end
end
