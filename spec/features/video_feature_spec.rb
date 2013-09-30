require "spec_helper"

feature "Videos" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, :user => user) }

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

  describe "add/modify" do
    context "non-signed in user" do
      it "cannot create video" do
        visit new_project_video_path(project)
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
    end

    context "signed in user" do
      before(:each) do
        sign_in_user user
      end

      it "can add video" do
        visit new_project_video_path(project)
        video = FactoryGirl.build(:video, :user => user, :project => project)
        fill_in 'video_url', :with => video.url
        click_button "Create Video"
        expect(page).to have_content("Successfully added Video")
      end

      it "can edit video" do
        video = FactoryGirl.create(:video, :user => user, :project => project)
        visit edit_project_video_path(project,video)
        fill_in 'video_url', :with => video.url
        click_button "Update Video"
        expect(page).to have_content("Successfully updated Video")
      end
    end

    context "singed in user who is not owner of video" do
      it "cannot update video" do
        video = FactoryGirl.create(:video, :user => user, :project => project)
        user2 = FactoryGirl.create(:user, :email => "test2@crowdvocate.com")
        sign_in_user user2
        visit edit_project_video_path(project,video)
        expect(page).to have_content("You do not have permission to edit this Video!")
      end
    end
  end

  describe "Votes" do
    context "non-signed in user" do
      it "cannot vote on videos" do
        video = FactoryGirl.create(:video, :user => user, :project => project)
        visit project_path(project)
        expect(page).to_not have_content("Upvote")
        expect(page).to_not have_content("Remove Vote")
      end
    end

    context "signed in user" do
      before(:each) do
        sign_in_user user
        video = FactoryGirl.create(:video, :user => user, :project => project)
      end

      it "can add/remove vote" do
        visit project_path(project)
        click_link 'Upvote'
        expect(page).to have_content("Remove Vote")

        click_link 'Remove Vote'
        expect(page).to have_content("Upvote")
      end
    end
  end
end