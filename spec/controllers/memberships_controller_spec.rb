require 'rails_helper'
describe MembershipsController do
  before do
    @project = create_project
    @membership = create_membership project: @project
    @user = create_user
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
  end

# --------------------------------> #create <---------------------------------

  describe '#create' do
    it 'should redirect visitors to signin page' do

      get :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user

      get :create, project_id: @project
      expect(response.status).to eq(404)
    end

    it 'should 404 if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :create, project_id: @project
      expect(response.status).to eq(404)
    end
  end

# --------------------------------> #update <---------------------------------

  describe '#update' do

    it 'should redirect visitors to signin page' do

      get :update, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member' do
      session[:id] = @user
      get :update, project_id: @project, id: @membership
      expect(response.status).to eq(404)
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

  end
end
