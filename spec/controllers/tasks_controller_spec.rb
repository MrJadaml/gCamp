require 'rails_helper'
describe TasksController do
  before do
    @project = create_project
    @user = create_user
    @task = Task.create!(
      description: 'todo',
      due_date: '11/11/2016',
      project_id: @project.id,
    )
  end

# --------------------------------> #index <---------------------------------

  describe '#index' do

    it 'should redirect visitors to signin page' do
      get :index, project_id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 on project pages for non-members' do
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
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :index, project_id: @project
      expect(response).to be_success
    end

    it 'should render index if user is an admin' do
      admin = create_user admin: true

      session[:id] = admin.id
      get :index, project_id: @project
      expect(response).to be_success
    end
  end

# --------------------------------> #show <---------------------------------

  describe '#show' do

    it 'should redirect visitors to signin page' do
      get :show, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 on project pages for non-members' do
      session[:id] = @user
      get :show, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end

    it 'should render show if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :show, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should render show if user is an Owner' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :show, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should render show if user is an admin' do
      admin = create_user admin: true

      session[:id] = admin.id
      get :show, project_id: @project, id: @task
      expect(response).to be_success
    end

  end

# ------------------------------> #new/create <--------------------------

  describe '#new' do

    it 'should redirect visitors to signin page' do
      get :new, project_id: @project
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 on project pages for non-members' do
      session[:id] = @user
      get :new, project_id: @project
      expect(response.status).to eq(404)
    end

    it 'should render #new if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :new, project_id: @project
      expect(response).to be_success
    end

    it 'should render show if user is an Owner' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :new, project_id: @project
      expect(response).to be_success
    end

    it 'should render new if user is an admin' do
      admin = create_user admin: true

      session[:id] = admin.id
      get :new, project_id: @project
      expect(response).to be_success
    end

  end

# ------------------------------> #edit/update <--------------------------

  describe '#edit' do

    it 'should redirect visitors to signin page' do
      get :edit, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 on project pages for non-members' do
      session[:id] = @user
      get :edit, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end

    it 'should render edit if user is a Member' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :edit, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should render show if user is an Owner' do
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :edit, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should render edit if user is an admin' do
      admin = create_user admin: true

      session[:id] = admin.id
      get :edit, project_id: @project, id: @task
      expect(response).to be_success
    end

  end
# --------------------------------> #destroy <---------------------------------

  describe '#destroy' do

    it 'should redirect visitors to signin page' do
      get :destroy, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end

    it 'should 404 on project pages for non-members' do
      session[:id] = @user
      get :destroy, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end

    it 'should allow destroy if user is a Member' do
    skip
      membership = @project.memberships.create!(
        user: @user,
        project: @project,
        role: 'Member'
      )

      session[:id] = @user
      get :destroy, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should render show if user is an Owner' do
    skip
      membership = create_membership user: @user, project: @project

      session[:id] = @user
      get :destroy, project_id: @project, id: @task
      expect(response).to be_success
    end

    it 'should allow destroy if user is an admin' do
    skip
    admin = create_user admin: true

      session[:id] = admin.id
      get :destroy, project_id: @project, id: @task
      expect(response).to be_success
    end

  end
end
