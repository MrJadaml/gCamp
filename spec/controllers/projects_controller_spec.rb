require 'rails_helper'
describe ProjectsController do
  before do
    @project = Project.create!(name: 'NASA')
    @user = User.create!(
      first_name: 'Albert',
      last_name: 'Einstein',
      password: 'password',
      email: 'xyz@mail.com'
    )
  end

# --------------------------------> #index <----------------------------------

  describe '#index' do

    it 'should redirect visitors to signin page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end

    it 'should render index for non member' do
    skip
      session[:id] = @user.id
      get :index
      expect(response).to be_success
    end

  end

# --------------------------------> #show <-----------------------------------

  describe '#show' do

    it 'should redirect visitors to signin page' do
      get :show, id: @project
      expect(response).to redirect_to(signin_path)
    end

  end

# --------------------------------> #new/create <-----------------------------

  describe '#new' do

    it 'should redirect visitors to signin page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end

  end

# --------------------------------> #edit/update <----------------------------

  describe '#edit' do

    it 'should redirect visitors to signin page' do
      get :edit, id: @project
      expect(response).to redirect_to(signin_path)
    end

  end

# --------------------------------> #destroy <--------------------------------

  describe '#destroy' do

    it 'should redirect visitors to signin page' do
      get :destroy, id: @project
      expect(response).to redirect_to(signin_path)
    end

  end
end
