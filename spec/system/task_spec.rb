require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    create(:task)
    create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path

        expect(page).to have_content 'タスク1'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順で並んでいること' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく(要素にtask_worというクラスをつけておく)

        expect(task_list[0]).to have_content 'タスク2'
        expect(task_list[1]).to have_content 'タスク1'
      end

      it 'タスクが終了期限の降順で並んでいること' do
        visit tasks_path
        click_on '終了期限でソート'
        sleep 1
        task_list = all('.task_row')

        expect(task_list[0]).to have_content 'タスク1'
        expect(task_list[1]).to have_content 'タスク2'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されていること' do
        visit new_task_path
        fill_in '名称', with: 'task_test'
        fill_in '詳しい説明', with: 'タスクの登録テスト'
        select '2019', from: 'task_expired_at_1i'
        select '12', from: 'task_expired_at_2i'
        select '31', from: 'task_expired_at_3i'
        select '17', from: 'task_expired_at_4i'
        select '00', from: 'task_expired_at_5i'
        click_on '登録する'

        expect(page).to have_content 'タスク「task_test」を登録しました'
        expect(page).to have_content 'task_test'
        expect(page).to have_content 'タスクの登録テスト'
        expect(page).to have_content '2019年12月31日 17:00'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        task = create(
          :task,
          name: 'タスク3',
          description: 'タスクの登録テストです',
          expired_at: Time.new(2019, 12, 10, 22, 30)
        )
        visit task_path(task)

        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスクの登録テストです'
        expect(page).to have_content '2019年12月10日 22:30'
      end
    end
  end
end
