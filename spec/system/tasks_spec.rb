require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do

  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        click_on 'Create Task'
        expect(page).to have_content 'content test'
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
end
