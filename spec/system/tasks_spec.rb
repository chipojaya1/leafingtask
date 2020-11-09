require 'rails_helper'

RSpec.describe "Tasks management function", type: :system do
  describe 'new feautures' do
    context 'case was the task to create a new task' do
      it 'should display the new task created' do
      end
    end
  end
  describe 'list display function' do
    context 'to transition to the list screen' do
      it 'already created tasks should be displayed' do
      end
    end
  end
  describe 'detailed display function' do
     context 'to transition to any task detail screen' do
       it 'contents of relevant task should be displayed' do
       end
     end
  end

  describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          # テストで使用するためのタスクを作成
          task = FactoryBot.create(:task, title: 'task')
          # タスク一覧ページに遷移
          visit tasks_path
          # The text "task" appears on the visited (transitioned) page (task list page)
          # expect (confirm/expect) that have_content is included (is included)
          expect(page).to have_content 'task'
          # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
        end
      end
    end
  end
  4行目でタスク一
end
