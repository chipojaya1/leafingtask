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
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
        visit admin_users_path
        expect(page).to_not have_content 'Users'
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
        user = User.create(name: "Chipo", email: "chipo2@gmail.com", password: "Hyunjoong1*", password_confirmation: "Hyunjoong1*", admin: true)
        visit new_session_path
        fill_in "session_email", with: "chipo2@gmail.com"
        fill_in "session_password", with: "Hyunjoong1*"
        click_button 'Login'
        visit admin_users_path
        expect(page).to have_content "Users"
      end

      it 'should create new user' do
        user = User.create(name: "Chipo", email: "chipo2@gmail.com", password: "Hyunjoong1*", password_confirmation: "Hyunjoong1*", admin: true)
        visit new_session_path
        fill_in "session_email", with: "chipo2@gmail.com"
        fill_in "session_password", with: "Hyunjoong1*"
        click_button 'Login'
        click_on 'Admin'
        click_link 'Create user'
        expect(page).to have_content "Register"
      end

      it 'should be able to access user profile' do
        sample = FactoryBot.create(:user, name: "sample", email: "sample@example.com")
        visit admin_user_path(sample)
        expect(page).to have_content 'sample@example.com'
      end

      it 'should be able to access user edit screen' do
        sample = FactoryBot.create(:user, name: "sample", email: "sample@example.com")
        visit edit_admin_user_path(sample)
        expect(page).to have_content 'sample'
        expect(page).to have_content 'sample@example.com'
      end

      it 'Being able to delete users' do
        user = User.create(name: "Chipo", email: "chipo2@gmail.com", password: "Hyunjoong1*", password_confirmation: "Hyunjoong1*", admin: true)
        user = User.create(name: "Chipo2", email: "chipo@gmail.com", password: "Hyunjoon*", password_confirmation: "Hyunjoon*", admin: true)
        visit new_session_path
        fill_in "session_email", with: "chipo2@gmail.com"
        fill_in "session_password", with: "Hyunjoong1*"
        click_button 'Login'
        click_on 'Admin'
        within first('tbody tr') do
          click_on 'Delete'
         end
        expect(page).not_to have_content 'chipo2@gmail.com'
      end
    end
  end
end
