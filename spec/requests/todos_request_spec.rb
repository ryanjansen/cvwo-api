require 'rails_helper'
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe "Todos", type: :request do
  describe "unauthorized" do
    it "returns unauthorized with no signed cookie" do
      get "/todos"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'authorized' do
    before do
      sign_in
    end

    it 'GET /todos' do
      FactoryBot.create_list(:todo, 20)
      get "/todos"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it "POST /todos" do
      post '/todos', params: { todo: { title: "test", done: false } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq('test')
    end

    it "PUT /todos" do
      @todo = FactoryBot.create(:todo)
      @new_title = "new_title"
      @new_done = true

      put "/todos/#{@todo.id}", params: { todo: {title: @new_title, done: @new_done } }
      expect(response).to have_http_status(:ok)
      expect(Todo.find(@todo.id).title).to eq(@new_title)
      expect(Todo.find(@todo.id).done).to eq(@new_done)
    end

    it 'DELETE /todos' do
      @todo = FactoryBot.create(:todo)
      get "/todos"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]["title"]).to eq(@todo.title)

      delete "/todos/#{@todo.id}"
      get "/todos"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end
end