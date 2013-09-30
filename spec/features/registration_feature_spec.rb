require "spec_helper"

feature "Registration" do
  describe "New user" do
    let(:user) { FactoryGirl.build(:user) }

    it "should register with valid username & password" do
      visit new_user_registration_url
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password
      click_button "Sign up"
      expect(page).to have_content "Welcome! You have signed up successfully."
    end

    it "should not register with missing fields" do
      visit new_user_registration_url
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      click_button "Sign up"
      expect(page).to have_content "error prohibited this user from being saved"
    end

    it "should not register with existing email" do
      FactoryGirl.create(:user)
      visit new_user_registration_url
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      fill_in 'user_password_confirmation', :with => user.password
      click_button "Sign up"
      expect(page).to have_content "error prohibited this user from being saved"
    end
  end
end