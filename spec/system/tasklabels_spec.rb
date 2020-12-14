require 'rails_helper'
RSpec.describe "Tasks labels function", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:second_task, user: @user)
    @third_task = FactoryBot.create(:third_task, user: @user)
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    @third_label = FactoryBot.create(:third_label)
  end

  describe 'related to task and labels' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'password'
      click_on 'Log in'
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
        click_link 'Edit', match: :first
        uncheck 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on 'Submit'
        click_link 'Show', match: :first
        expect(page).to have_no_content 'SecondLabel'
        expect(page).to have_no_content 'ThirdLabel'
      end
    end

    context 'searching with label' do
      before do
        visit tasks_path
        click_link 'Edit', match: :first
        check 'ThirdLabel'
        click_on 'Submit'
      end
      it 'only task with selected label are displayed' do
        visit tasks_path
        check "search_label_ids_609"
        click_on 'search'
        expect(page).to have_no_content 'future'
        expect(page).to have_no_content 'old'
      end
    end
  end
end
