require 'rails_helper'
RSpec.describe 'User registration/login/logout function', type: :system do

  describe 'User registration test' do
    context 'If the user is not logged in' do
      it 'should register new user' do
        visit new_user_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
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

  describe "Testing session functionality" do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end
    context "If the user is logged in" do
      it "should navigate to user details page" do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_on 'Login'
        expect(current_path).to eq user_path(id: @user.id)
      end

      it 'should see your profile page' do
        click_on 'My Profile'
        expect(page).to have_content 'user1@example.com'
      end

      it 'navigating to other user profile will return you to the task list screen' do
        visit user_path(admin_user.id)
        expect(page).to have_content 'Not authorized'
      end

      it 'should not be able to access the management screen' do
        visit admin_users_path
        expect(page).to have_content 'only for admins！'
      end

      it 'should sign out' do
        click_on 'Logout'
        expect(page).to have_content 'logged out'
      end
    end

  describe "Management screen test" do
    context "If there are no admin users" do
      it "bea able to access management page" do
        visit new_session_path
        fill_in "session_email", with: "admin@example.com"
        fill_in "session_password", with: "12345678"
        click_on 'Login'
        click_on 'Admin'
        expect(page).to have_content "List of Users"
      end

      it 'should create new user' do
        click_on 'Create user'
        fill_in 'user_name', with: 'abc'
        fill_in 'user_email', with: 'abc@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        check 'false'
        click_on 'Create user'
        expect(page).to have_content 'abc'
        expect(page).to have_content 'abc@example.com'
      end

      it 'should be able to access user profile' do
        sample = FactoryBot.create(:user, name: "sample", email: "sample@example.com")
        visit admin_users_path
        click_on 'sample'
        expect(current_path).to eq admin_user_path(sample)
        expect(page).to have_content 'sample@example.com'
      end

      it 'should be able to access user edit screen' do
        visit edit_admin_user_path(user.id)
        fill_in 'user_name', with: 'update'
        fill_in 'user_email', with: 'update@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        check 'true'
        click_on 'Edit'
        expect(page).to have_content 'update'
        expect(page).to have_content 'update@example.com'
      end

      it 'Being able to delete users' do
        visit admin_users_path
        within first('tbody tr') do
         click_on 'Delete'
        end
      #  click_on "Delete", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'user deleted!'
      end
    end
  end
end
