require "spec_helper"

feature "Events" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, :user => user) }
  let(:event) { FactoryGirl.build(:event, :project => project, :user => user) }

  def sign_in_user (user)
    visit new_user_session_path
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button "Sign in"
  end

  before(:each) do
    project.published = true
    project.save
  end

  describe "modify" do
    context "non-signed in user" do
      it "cannot create event" do
        visit project_path(project)
        expect(page).to_not have_content("Create Event")
      end
    end

    context "signed in user who is not owner of project" do
      it "cannot create event on someone else's project" do
        user1 = FactoryGirl.create(:user, :email => "test1@crowdvocate.com")
        user2 = FactoryGirl.create(:user, :email => "test2@crowdvocate.com")
        project2 = FactoryGirl.create(:project, :slug => "sample2", :user => user2)
        project2.published = true
        project2.save
        sign_in_user user1
        visit new_project_event_path(project2)
        expect(page).to have_content("You do not have permission to create an event on this Pitch")
      end
    end

    context "signed in user who is owner of project" do
      before(:each) do
        sign_in_user user
      end

      it "can create event" do
        visit new_project_event_path(project)
        fill_in 'event_body', :with => event.body
        click_button 'Create Event'
        expect(page).to have_content("Successfully created Event")
      end

      it "can edit event" do
        event = FactoryGirl.create(:event, :project => project, :user => user)
        visit edit_project_event_path(project, event)
        fill_in 'event_body', :with => "Changed Event"
        click_button 'Update Event'
        expect(page).to have_content("Changed Event")
      end
    end
  end
end