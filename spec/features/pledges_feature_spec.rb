require "spec_helper"

feature "Pledges" do
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

  describe "Add pledge to project" do
    context "non-signed in user" do
      it "cannot add pledge" do
        visit project_path(project)
        expect(page).to_not have_content("Pledge Funds")
      end
    end

    context "signed in user" do
      before(:each) do
        sign_in_user user
      end

      it "cannot add invalid pledge" do
        visit project_path(project)
        within("#new_pledge") do
          fill_in 'pledge_amount', :with => "-1"
          click_button 'Create Pledge'
        end
        expect(page).to have_content("Could not add funds")
      end

      it "can add a pledge" do
        visit project_path(project)
        within("#new_pledge") do
          fill_in 'pledge_amount', :with => "100"
          click_button 'Create Pledge'
        end
        expect(page).to have_content("Raised = 100")
      end

      it "can edit a pledge" do
        pledge = FactoryGirl.create(:pledge, :project => project, :user => user)
        visit project_path(project)
        expect(page).to have_content("Raised = #{pledge.amount}")

        within("#edit_pledge_#{pledge.id}") do
          fill_in 'pledge_amount', :with => "100"
          click_button 'Update Pledge'
        end
        expect(page).to have_content("Raised = 100")
      end
    end
  end
end