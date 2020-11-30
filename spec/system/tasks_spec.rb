require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-11-24 11:00 PM'
        select 'started', from: "Status"
        select 'low', from: "Priority"
        click_on 'Create Task'
        expect(page).to have_content 'title test'
        expect(page).to have_content 'content test'
      end
    end
  end

  describe 'list function' do
    context 'to transition to the list screen' do
      it 'already created tasks should be displayed' do
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test2'
        expect(page).to have_content 'sample3'
      end
    end
  end

  describe 'detailed display function' do
    context 'to transition to any task detail screen' do
      it 'contents of relevant task should be displayed' do
        visit task_path(test2)
        expect(page).to have_content 'test2'
      end
    end
  end

  describe 'duedate test' do
    context 'When you click the  Sort by duedate button in the task list' do
      it 'list tasks sorted in descending order of expiration date' do
        click_on "Sort by duedate"
        visit tasks_path(sort_expired: "true")
        expect(all('tbody tr')[0]).to have_content '2020/11/30 11:00'
        expect(all('tbody tr')[1]).to have_content '2020/12/30 00:00'
        expect(all('tbody tr')[2]).to have_content '2020/11/18 17:00'
      end
    end
  end

  describe 'search function' do
    context 'If you do a fuzzy search for the title with the scope method' do
      it "Narrows down tasks that include search keywords with title" do
        visit tasks_path
        fill_in "title keyword", with: "sample"
        click_on "search"
        expect(page).to have_content 'sample'
      end
    end

    context 'When a status search is performed with the scope method' do
      it "Narrows down tasks that exactly match with status" do
        visit tasks_path
        select "pending", from: "by"
        click_on "search"
        expect(page).to have_selector 'by', text: 'pending'
      end
    end

    context 'If  you  do a fuzzy search and status search for the title with the scope method' do
      it "Narrow down tasks that include search keywords in the title and exactly match the status" do
        visit tasks_path
        fill_in "title keyword", with: "sample3"
        select "started", from: "by"
        click_on "submit"
        expect(page).to have_selector 'by', text: 'started'
        expect(page).to have_content 'sample3'
      end
    end
  end

end
