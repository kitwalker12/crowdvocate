require "spec_helper"

feature "Projects" do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.build(:project, :user => user) }

  def sign_in_user (user)
    visit new_user_session_path
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button "Sign in"
  end

  describe "Create New Project" do
    context "non-signed in user" do
      it "cannot create new pitch" do
        visit new_project_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
    end

    context "signed in user" do
      before(:each) do
        sign_in_user user
      end

      it "can create project with valid fields" do
        visit new_project_path
        fill_in 'project_name', :with => project.name
        fill_in 'project_description', :with => project.description
        fill_in 'project_deadline', :with => project.deadline
        fill_in 'project_goal', :with => project.goal
        fill_in 'project_body', :with => project.body
        click_button "Create Project"
        expect(page).to have_content("Successfully created Pitch")
      end

      it "cannot create project with invalid fields" do
        visit new_project_path
        fill_in 'project_name', :with => project.name
        fill_in 'project_description', :with => project.description
        fill_in 'project_deadline', :with => project.deadline
        fill_in 'project_goal', :with => "-1"
        fill_in 'project_body', :with => project.body
        click_button "Create Project"
        expect(page).to have_content("Could not save Pitch")
      end

      it "cannot create project with missing fields" do
        visit new_project_path
        fill_in 'project_name', :with => project.name
        fill_in 'project_description', :with => project.description
        click_button "Create Project"
        expect(page).to have_content("Could not save Pitch")
      end
    end
  end
end