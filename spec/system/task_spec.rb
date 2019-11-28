require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = create(:task)
        visit tasks_path

        expect(page).to have_content 'task_test'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されていること' do
        visit new_task_path

        fill_in '名称', with: 'task_test'
        fill_in '詳しい説明', with: 'タスクの登録テスト'
        click_on 'Create Task'

        expect(page).to have_content 'タスク「task_test」を登録しました'
        expect(page).to have_content 'task_test'
        expect(page).to have_content 'タスクの登録テスト'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        task = create(:task)
        visit task_path(task)

        expect(page).to have_content 'task_test'
        expect(page).to have_content 'taskの登録テストです'
      end
    end
  end
end
