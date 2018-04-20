require 'rails_helper'

describe StudentsController do

  render_views

  describe "GET #index" do
    it "displays all users" do
      Student.create(name: "Alice")
      Student.create(name: "Bob")
      Student.create(name: "Claude")

      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to include("<h1>All Students</h1>")
      expect(response.body).to include("All the students are: Alice, Bob and Claude")
      expect(response.body).to include("<header>Ruby Exam</header>")

      Student.create(name: "David")

      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to include("All the students are: Alice, Bob, Claude and David")
    end
  end

  describe "GET #new" do
    it "displays a form to create a new student" do
      get :new

      expect(response).to have_http_status(:success)
      expect(response.body).to include("<h1>New Student</h1>")
      expect(response.body).to include("<form")
      expect(response.body).to include(
        '<input type="submit" name="commit" value="Create Student" />'
      )
      expect(response.body).to include("<header>Ruby Exam</header>")
    end
  end

  describe "POST #create" do
    it "creates a new student only when valid" do
      expect(Student.count).to eq(0)

      post :create, student: {name: "Rick"}
      expect(Student.last.name).to eq("Rick")

      post :create, student: {name: "Morty"}
      expect(Student.last.name).to eq("Morty")

      post :create, student: {name: ""}
      expect(Student.count).to eq(2)
      expect(response.body).to include("<h1>New Student</h1>")
      expect(response.body).to include("<form")
      expect(response.body).to include("Name can&#39;t be blank")
      expect(response.body).to include("<header>Ruby Exam</header>")
    end
  end

  describe "GET #all_actions" do
    it "returns a JSON array containing all actions available in this controller" do
      get :all_actions
      expect(response).to have_http_status(:success)
      expect(response.body).to eq("[\"index\",\"new\",\"create\"]")
    end
  end
end
