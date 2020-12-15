require 'rails_helper'
RSpec.describe "Labels function", type: :system do
  before do
    @adminuser = User.create(name: "Chipo", email: "chipo2@gmail.com", password: "Hyunjoong1*", password_confirmation: "Hyunjoong1*", admin: true)
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:second_task, user: @user)
    @third_task = FactoryBot.create(:third_task, user: @user)
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    @third_label = FactoryBot.create(:third_label)
  end

  describe 'Accessing the label screen after login' do
    context 'when user visits label screen' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'user1@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Login'
      end
      it 'should have access to label screen' do
        visit labels_path
        expect(current_path).to eq labels_path
        expect(page).to have_content 'Labels'
      end
      it 'should create new label' do
        visit new_label_path
        fill_in 'name', with: 'new label'
        click_on 'Create Label'
        expect(page).to have_content 'new label'
        expect(page).to have_content 'Label was successfully created'
      end
      it 'can edit label' do
        visit labels_path
        within first('tbody tr') do
          click_link 'Edit'
        end
        fill_in 'name', with: 'edit label'
        click_on 'Update Label'
        expect(page).to have_content 'Label was successfully updated.'
        expect(page).to have_content 'edit label'
      end
      it 'can delete label' do
        visit labels_path
        within first('tbody tr') do
          click_on 'Delete'
        end
        expect(page).to have_content 'Label was successfully destroyed.'
      end
    end
  end

  describe 'related task' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'Login'
    end

    context 'when new task is created' do
      it 'should be able to add a label' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        select 'started'
        select 'low'
        check 'label'
        check 'second_label'
        check 'third_task'
        click_on 'Submit'
        expect(page).to have_content 'Task created'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end

    context 'when visiting task details screen' do
      it 'should display the label' do
        visit task_path(@task.id)
        expect(page).to have_content 'test1'
        expect(page).not_to have_content 'test2'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).not_to have_content 'ThirdLabel'
      end
    end

    context 'editing labels' do
      it 'should be able to update labels' do
        visit tasks_path
        click_link 'Edit', match: :first
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Submit'
        click_link 'Show', match: :first
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end
    context 'Using edit to delete label' do
      before do
        visit tasks_path
        click_link 'Edit', match: :first
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Submit'
      end
      it 'should remove label' do
        within first('tbody tr') do
          click_on 'Edit'
         end
        uncheck 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on 'Submit'
        click_link 'Show', match: :first
        expect(page).to have_no_content 'SecondLabel'
        expect(page).to have_no_content 'ThirdLabel'
      end
    end
  end

  describe 'related to task and labels' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'Login'
    end

    context 'when new task is created' do
      it 'should be able to add a label' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        select 'started'
        select 'low'
        check 'label'
        check 'second_label'
        check 'third_task'
        click_on 'Submit'
        expect(page).to have_content 'Task created'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end

    context 'when visiting task details screen' do
      it 'should display the label' do
        visit task_path(@task.id)
        expect(page).to have_content 'test1'
        expect(page).not_to have_content 'test2'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).not_to have_content 'ThirdLabel'
      end
    end

    context 'editing labels' do
      it 'should be able to update labels' do
        visit tasks_path
        within first('tbody tr') do
          click_on 'Edit'
         end
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Submit'
        within first('tbody tr') do
          click_on 'Show'
         end
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end

    context 'Using edit to delete label' do
      before do
        visit tasks_path
        within first('tbody tr') do
          click_on 'Edit'
         end
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Submit'
      end
      it 'should remove label' do
        within first('tbody tr') do
          click_on 'Edit'
         end
        uncheck 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on 'Submit'
        within first('tbody tr') do
          click_on 'Show'
         end
        expect(page).to have_no_content 'SecondLabel'
        expect(page).to have_no_content 'ThirdLabel'
      end
    end

    describe 'search function' do
      context 'If you do a fuzzy search for the title, label and status' do
        it "Narrows down tasks that include search with title label and status" do
          visit tasks_path
          fill_in "title keyword", with: "test"
          check "started"
          check "MyString02"
          click_button "search"
          expect(page).to have_content 'test'
          expect(page).to have_content 'started'
          expect(page).to have_content 'MyString02'
        end
      end

      context 'If  you  do a fuzzy label search with title' do
        it "Narrow down search to exactly match the label and title" do
          visit tasks_path
          fill_in "title keyword", with: "test"
          select "MyString01"
          click_button "search"
          expect(page).to have_content 'test'
          expect(page).to have_content 'MyString01'
        end
      end

      context 'When a status search is performed with the scope method' do
        it "Narrows down tasks that exactly match with label" do
          visit tasks_path
          check "MyString02"
          click_button "search"
          expect(page).to have_content 'MyString02'
        end
      end
    end
  end
end
