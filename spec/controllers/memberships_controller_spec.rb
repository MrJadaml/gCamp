require 'rails_helper'
describe MembershipsController do
  before do
    @project = create_project
    @membership = create_membership project: @project
    @user = create_user
    @admin = create_user admin: true
  end

# --------------------------------> #index <----------------------------------

  describe '#index' do

    it 'should redirect visitors to signin page' do

      get :index, project_id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user
      get :index, project_id: @project
      expect(response.status).to eq(404)
    end

    it 'should render index if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :index, project_id: @project
      expect(response).to be_success
    end

    it 'should render index if user is an Owner' do
      membership = create_membership user: @user, project: @project, role: 'Owner'

      session[:id] = @user
      get :index, project_id: @project
      expect(response).to be_success
    end

    it 'should render index if user is an Admin' do
      membership = create_membership user: @admin

      session[:id] = @admin
      get :index, project_id: @project
      expect(response).to be_success
    end
  end

# --------------------------------> #create <---------------------------------

  describe '#create' do
    it 'should redirect visitors to signin page' do

      post :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user

      post :create, project_id: @project
      expect(response.status).to eq(404)
    end

    it 'should 404 if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      post :create, project_id: @project
      expect(response.status).to eq(404)
    end

    it 'should allow an Owner to create a membership' do
      membership = create_membership user: @user, project: @project, role: 'Owner'

      session[:id] = @user
      post :create, project_id: @project, membership: {role: 'Member'}
      expect(response).to be_success
    end

    it 'should allow an Admin to create a membership' do
      membership = create_membership user: @admin, project: @project

      session[:id] = @admin
      post :create, project_id: @project, membership: {role: 'Member'}
      expect(response).to be_success
    end
  end

# --------------------------------> #update <---------------------------------

  describe '#update' do

    it 'should redirect visitors to signin page' do

      patch :update, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user
      patch :update, project_id: @project, id: @membership
      expect(response.status).to eq(404)
    end

    it 'should 404 if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      patch :update, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response.status).to eq(404)
    end

    it 'should allow an Owner to update a membership' do
    skip
      membership = create_membership user: @user, project: @project, role: 'Owner'

      session[:id] = @user
      patch :update, project_id: @project, id: @membership, membership: {role: 'Owner'}
      expect(response).to be_success
    end

    it 'should allow an Admin to update a membership' do
    skip
      membership = create_membership user: @admin, project: @project

      session[:id] = @admin
      patch :update, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response).to be_success
    end

  end

# --------------------------------> #destroy <--------------------------------

  describe '#destroy' do
    it 'should redirect visitors to signin page' do

      get :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user
      get :destroy, project_id: @project, id: @membership
      expect(response.status).to eq(404)
    end

    it 'should 404 if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      delete :destroy, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response.status).to eq(404)
    end

    it 'should allow a Member to destroy their own membership' do
    skip
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      delete :destroy, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response.status).to eq(404)
    end

    it 'should allow an Owner to destroy memberships' do
    skip
      membership = create_membership user: @user, project: @project, role: 'Owner'

      session[:id] = @user
      delete :destroy, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response.status).to eq(404)
    end

    it 'should allow an Admin to destroy memberships' do
    skip
      membership = create_membership user: @admin, project: @project

      session[:id] = @admin
      delete :destroy, project_id: @project, id: @membership, membership: {role: 'Member'}
      expect(response.status).to eq(404)
    end

  end
end
