require 'rails_helper'
describe ProjectsController do
  before do
    @project = create_project
    @admin = create_user admin: true
    @user = create_user
    @member = create_user
    @owner= create_user
    @member_membership = create_membership user: @member, project: @project
    @owner_membership = create_membership user: @owner, project: @project, role: 'Owner'
  end

# --------------------------------> #index <----------------------------------

  describe '#index' do

    it 'should redirect visitors to signin page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end

    it 'should render index for non member' do
      session[:id] = @user.id
      get :index
      expect(response).to be_success
    end

    it 'should render index for a Member' do
      session[:id] = @member.id
      get :index
      expect(response).to be_success
    end

    it 'should render index for an Owner' do
      session[:id] = @owner.id
      get :index
      expect(response).to be_success
    end

    it 'should render index for an Owner' do
      session[:id] = @admin.id
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

    it 'should 404 a non-member on show page' do
      session[:id] = @user.id
      get :show, id: @project
      expect(response.status).to eq(404)
    end

    it 'should allow a Member to view the show page' do
      session[:id] = @member.id
      get :show, id: @project
      expect(response).to be_success
    end

    it 'should allow an Owner to view the show page' do
      session[:id] = @owner.id
      get :show, id: @project
      expect(response).to be_success
    end

    it 'should allow an admin to view the show page' do
      session[:id] = @admin.id
      get :show, id: @project
      expect(response).to be_success
    end

  end

# --------------------------------> #new/create <-----------------------------

  describe '#new' do

    it 'should redirect visitors to signin page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end

    it 'should allow a user to create a project' do
      project = {project: {name: 'stuff'}}
      session[:id] = @user.id

      post :create, project
      expect(response).to redirect_to project_tasks_path(Project.last.id)
    end

    it 'should allow an Admin to create a project' do
      project = {project: {name: 'stuff'}}
      session[:id] = @admin.id

      post :create, project
      expect(response).to redirect_to project_tasks_path(Project.last.id)
    end

    it 'should set role for the creator of the project to Owner' do
      project = {project: {name: 'stuff'}}
      session[:id] = @user.id

      post :create, project
      expect(Membership.last.role).to eq('Owner')
    end
  end

# --------------------------------> #edit/update <----------------------------

  describe '#edit' do

    it 'should redirect visitors to signin page' do
      get :edit, id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 non-owners who try to access edit page' do
      session[:id] = @member.id
      get :edit, id: @project
      expect(response.status).to eq(404)
    end

    it 'should 404 a non-member who tries to update a project' do
      session[:id] = @user.id
      patch :update, id: @project
      expect(response.status).to eq(404)
    end

    it 'should 404 a Member who tries to update a project' do
      session[:id] = @member.id
      patch :update, id: @project
      expect(response.status).to eq(404)
    end

    it 'should allow an Owner to update a project' do
      session[:id] = @owner.id
      patch :update, id: @project, project: {name: 'stuff'}
      expect(response).to redirect_to(@project)
    end

    it 'should allow an Admin to update a project' do
      session[:id] = @admin.id
      patch :update, id: @project, project: {name: 'things'}
      expect(response).to redirect_to(@project)
    end

  end

# --------------------------------> #destroy <--------------------------------

  describe '#destroy' do

    it 'should redirect visitors to signin page' do
      get :destroy, id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 a non-member who tries to destroy a project' do
      session[:id] = @user.id
      delete :destroy, id: @project
      expect(response.status).to eq(404)
    end

    it 'should 404 a Member who tries to destroy a project' do
      session[:id] = @member.id
      delete :destroy, id: @project
      expect(response.status).to eq(404)
    end

    it 'should allow an Owner to destroy a project' do
      session[:id] = @owner.id
      delete :destroy, id: @project
      expect(response).to redirect_to projects_path
    end

    it 'should allow an Admin to destroy a project' do
      session[:id] = @admin.id
      delete :destroy, id: @project
      expect(response).to redirect_to projects_path
    end

  end
end
