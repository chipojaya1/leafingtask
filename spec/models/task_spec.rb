require 'rails_helper'

RSpec.describe Task, type: :model do

  it 'validation does not pass if the task title is empty' do
    task = Task.new(title: '', content: 'failure test')
    expect(task).not_to be_valid
  end

  it 'validation does not pass if the task contents are empty' do
    task = Task.new(title: 'Test from details', content: '')
    expect(task).not_to be_valid
  end

  it 'Validations pass if the task title and content are present' do
    task = Task.new(title: 'test', content: 'testtest')
    expect(task).to be_valid
  end
end
