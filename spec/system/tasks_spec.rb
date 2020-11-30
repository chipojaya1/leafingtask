require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do

  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        click_on 'Create Task'
        expect(page).to have_content 'title test'
      end
    end
  end

  describe 'list function' do
    context 'to transition to the list screen' do
      it 'already created tasks should be displayed' do
        task = FactoryBot.create(:task, title: 'task')
		visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'detailed display function' do
    context 'to transition to any task detail screen' do
      it 'contents of relevant task should be displayed' do
        task = FactoryBot.create(:task, title: 'test2', content: 'test2')
        visit task_path(task)
        expect(page).to have_content 'test2'
      end
    end
  end

  let!(:task){ FactoryBot.create(:task, title: 'task') }
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end
  describe 'list display function' do
    context 'When transitioning to the list screen' do
      it 'already created tasks list should be displayed' do
        expect(page).to have_content 'title test'
      end
    end
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
        assert Task.all.order(duedate: :desc)
      end
    end
  end
end
