require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) {
    {name: 'Walter', completed: false}
  }

  let(:invalid_attributes) {
    {name: 'W'}
  }

  describe "GET #index" do
    it "returns a success response" do
      Task.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :edit, params: {id: task.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: {task: valid_attributes}
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post :create, params: {task: valid_attributes}
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid params" do
      it "returns a unprocessable_entity response" do
        request.accept = "application/json"
        post :create, params: {task: {name: "a"}}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'Lucas', completed: true}
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        put :update, params: {id: task.to_param, task: new_attributes}
        task.reload
        expect(assigns(:task).attributes['name']).to match('Lucas')
        expect(assigns(:task).attributes['completed']).to match(true)
      end

      it "check tracking created" do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean

        task = Task.create(name: 'Create new feature', completed: false)

        tracking = Tracking.all
        before_change_count = tracking.count

        put :update, params: {id: task.to_param, task: {completed: true}}

        tracking = Tracking.all
        after_change_count = tracking.count

        expect(before_change_count).to eql(0)
        expect(after_change_count).to eql(1)
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, params: {id: task.to_param, task: valid_attributes}
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid params" do
      it "returns a unprocessable_entity response" do
        task = Task.create! valid_attributes
        request.accept = "application/json"
        put :update, params: {id: task.to_param, task: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, params: {id: task.to_param}
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, params: {id: task.to_param}
      expect(response).to redirect_to(tasks_url)
    end
  end

end
