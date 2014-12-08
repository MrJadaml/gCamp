require 'rails_helper'
describe UsersController do
  before do
    @project = create_project
    @membership = create_membership project: @project
    @user = create_user
    @member = create_user
    @owner = create_user
    @member_membership = create_membership project: @project, user: @member
    @owner_membership = create_membership project: @project, user: @owner, role: 'Owner'
    @admin = create_user admin: true
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

    patch :edit, id: @user
    expect(response).to redirect_to(signin_path)
  end

  it 'should redirect visitors to signin page' do

    patch :update, id: @user
    expect(response).to redirect_to(signin_path)
  end

  it 'should 404 non-admins that try to set admin attribute' do
    session[:id] = @owner

    patch :update, id: @user, user: {admin: true}
    expect(response.status).to eq(404)
  end
end

# --------------------------------> #destroy <--------------------------------
  describe '#destroy' do

    it 'should redirect visitors to signin page' do

      delete :destroy, id: @user
      expect(response).to redirect_to(signin_path)
    end

  end

end
