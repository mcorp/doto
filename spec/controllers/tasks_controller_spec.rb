require 'spec_helper'

describe TasksController do
  login_user

  it 'GET #index' do
    task = create(:task, user: @user)
    get :index, format: :json
    expect(response.body).to eq([task].to_json)
  end

  it 'GET #show' do
    task = create(:task, user: @user)

    get :show, id: task, format: :json
    expect(response.body).to eq(task.to_json)
  end

  describe 'POST #create' do
    it 'with valid attributes' do
      expect {
        post :create, task: attributes_for(:task), format: :json
      }.to change(Task, :count).by(1)

      expect(response.status).to be(201)
    end

    it 'with invalid attributes' do
      expect {
        post :create, task: attributes_for(:task, title: nil), format: :json
      }.to_not change(Task, :count)

      expect(response.status).to be(422)
    end
  end

  describe 'PUT #update' do
    before(:each) { @task = create(:task, user: @user) }

    context 'valid attributes' do
      it 'changes @task attributes' do
        put :update, id: @task, task: attributes_for(:task, title: "New title"), format: :json
        @task.reload
        expect(@task.title).to eq("New title")
      end
    end

    context 'invalid attributes' do
      it 'does not change @task attributes' do
        put :update, id: @task, task: attributes_for(:task, title: nil), format: :json
        @task.reload
        expect(@task.title).to eq("Task.title")
      end
    end
  end

  it 'DELETE' do
    task = create(:task, user: @user)

    expect { delete :destroy, id: task, format: :json }.to change(Task, :count).by(-1)
  end
end
