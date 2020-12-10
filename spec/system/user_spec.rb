require 'rails_helper'
RSpec.describe 'User registration/login/logout function', type: :system do

  describe 'User registration test' do
    context 'If the user is not logged in' do
      it 'should register new user' do
        visit new_user_path
        fill_in 'name', with: 'test'
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_on 'Create account'
        expect(page).to have_content 'test'
        expect(page).to have_content 'test@example.com'
      end

      it 'should jump to login screen when not logged in' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
        expect(page).to have_content 'Everleaf Login'
      end
    end
  end

  describe "Session login test" do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end
    context "If the user is logged in" do
      it "should navigate to user details page" do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
        expect(current_path).to eq user_path(id: @user.id)
      end

      it 'should see your profile page' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'user1@example.com'
      end

      it 'navigating to other user profile will return you to the tasks list screen' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
        visit user_path(id: @admin_user.id)
        expect(current_path).to eq tasks_path
      end

      it 'should not be able to access the management screen' do
        visit admin_users_path
        expect(page).to have_content 'only for admins！'
      end

      it 'should be able to log out' do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
        click_on 'Logout'
        expect(page).to have_content 'logged out'
      end
    end
  end

  describe "Management screen test" do
    context "If there are no admin users" do
      it "be able to access management page" do
        visit new_session_path
        fill_in "session_email", with: "admin@example.com"
        fill_in "session_password", with: "12345678"
        click_button 'Login'
        visit admin_users_path
        expect(page).to have_content "List of Users"
      end

      it 'should create new user' do
        visit admin_users_path
        click_button 'Create user'
        fill_in 'name', with: 'abc'
        fill_in 'email', with: 'abc@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button 'Submit'
        expect(page).to have_content 'abc'
        expect(page).to have_content 'abc@example.com'
      end

      it 'should be able to access user profile' do
        sample = FactoryBot.create(:user, name: "sample", email: "sample@example.com")
        visit admin_user_path(sample)
        expect(page).to have_content 'sample@example.com'
      end

      it 'should be able to access user edit screen' do
        visit edit_admin_user_path(user.id)
        fill_in 'name', with: 'update'
        fill_in 'email', with: 'update@example.com'
        fill_in 'password', with: 'password'
        fill_in 'password_confirmation', with: 'password'
        click_button 'Submit'
        expect(page).to have_content 'update'
        expect(page).to have_content 'update@example.com'
      end

      it 'Being able to delete users' do
        visit admin_users_path
        click_link "Delete", match: :first
        expect(page).to have_content 'user deleted!'
      end
    end
  end
end
