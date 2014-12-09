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
      expect(response).to redirect_to signin_path
    end

  end

# --------------------------------> #show <-----------------------------------
  describe '#show' do

    it 'should redirect visitors to signin page' do

      get :show, id: @user
      expect(response).to redirect_to signin_path
    end

  end

# --------------------------------> #new/create <-----------------------------

describe '#new' do

  it 'should redirect visitors to signin page' do

    get :new
    expect(response).to redirect_to signin_path
  end

  it 'should redirect visitors to signin page' do

    get :create
    expect(response).to redirect_to signin_path
  end

end

# --------------------------------> #edit/update <----------------------------

describe '#edit' do

  it 'should redirect visitors to signin page' do

    patch :edit, id: @user
    expect(response).to redirect_to signin_path
  end

  it 'should redirect visitors to signin page' do

    patch :update, id: @user
    expect(response).to redirect_to signin_path
  end

  it 'should allow logged in user to edit their own user profile' do
    session[:id] = @member.id
    patch :update, id: @member, user: {last_name: 'Wowza'}
    expect(@member.reload.last_name).to eq('Wowza')
  end

  it 'should 404 a user trying to access #edit for another user\'s profile' do
    session[:id] = @member.id
    get :edit, id: @user
    expect(response.status).to eq(404)
  end

  it 'should not allow logged in user to edit other user profiles' do
    session[:id] = @member.id
    user_last_name = @user.last_name
    patch :update, id: @user, user: {last_name: 'Wowza'}
    expect(@user.reload.last_name).to eq(user_last_name)
  end

  it 'should 404 non-admins that try to set admin attribute' do
    session[:id] = @owner.id
    admin_status = @user.admin?

    patch :update, id: @user, user: {admin: true}
    expect(@user.admin?).to eq(admin_status)
  end

  it 'should allow Admins to change admin status' do
    user = create_user admin: false
    session[:id] = @admin
    patch :update, id: user.id, user: {admin: true}
    expect(user.reload.admin?).to eq(true)
  end
end

# --------------------------------> #destroy <--------------------------------
  describe '#destroy' do

    it 'should redirect visitors to signin page' do

      delete :destroy, id: @user
      expect(response).to redirect_to signin_path
    end
  end

end
