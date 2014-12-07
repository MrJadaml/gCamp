require 'rails_helper'
describe UsersController do
  before do
    @user = create_user
  end

# --------------------------------> #index <----------------------------------

  describe '#index'  do

    it 'should redirect visitors to signin page' do

      get :index
      expect(response).to redirect_to(signin_path)
    end

  end

# --------------------------------> #show <-----------------------------------
  describe '#show' do

    it 'should redirect visitors to signin page' do

      get :show, id: @user
      expect(response).to redirect_to(signin_path)
    end

  end

# --------------------------------> #new/create <-----------------------------

describe '#new' do

  it 'should redirect visitors to signin page' do

    get :new
    expect(response).to redirect_to(signin_path)
  end

  it 'should redirect visitors to signin page' do

    get :create
    expect(response).to redirect_to(signin_path)
  end

end

# --------------------------------> #edit/update <----------------------------

describe '#edit' do

  it 'should redirect visitors to signin page' do

    get :edit, id: @user
    expect(response).to redirect_to(signin_path)
  end

  it 'should redirect visitors to signin page' do

    get :update, id: @user
    expect(response).to redirect_to(signin_path)
  end

end

# --------------------------------> #destroy <--------------------------------
  describe '#destroy' do

    it 'should redirect visitors to signin page' do

      get :destroy, id: @user
      expect(response).to redirect_to(signin_path)
    end

  end

end
