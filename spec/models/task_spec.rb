require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  describe 'タスク新規登録時のバリデーション' do
    it 'nameが空ならバリデーションが通らない' do
      task = Task.new(
        name: '',
        description: '失敗テスト',
        expired_at: Time.now + 60 * 60 * 24
      )
      expect(task).not_to be_valid
    end

    it 'descriptionが空なら、バリデーションが通らない' do
      task = Task.new(
        name: '失敗テスト',
        description: '',
        expired_at: Time.now + 60 * 60 * 24
      )
      expect(task).not_to be_valid
    end

    it 'nameとdescriptionに内容が記載されていれば、バリデーションが通る' do
      task = Task.new(
        name: '成功テスト',
        description: 'テストが成功しました！',
        expired_at: Time.now + 60 * 60 * 24
      )
      expect(task).to be_valid
    end

    it 'nameが30文字より大きければ、バリデーションが通らない' do
      task = Task.new(
        name: 'a' * 31,
        description: '失敗テスト',
        expired_at: Time.now + 60 * 60 * 24
      )
      expect(task).not_to be_valid
    end

    it 'nameが重複していたら、バリデーションが通らない' do
      Task.create(
        name: 'タスク1',
        description: 'タスク1です',
        expired_at: Time.now + 60 * 60 * 24
      )

      task = Task.new(
        name: 'タスク1',
        description: 'タスク名称の重複は認められません',
        expired_at: Time.now + 60 * 60 * 24
      )
      expect(task).not_to be_valid
    end

    it 'expired_atが現在日時以前の場合、バリデーションが通らない' do
      task = Task.create(
        name: 'タスク1',
        description: 'タスク1です',
        expired_at: Time.now
      )
      expect(task).not_to be_valid
    end
  end

  describe 'タスク検索機能' do
    before do
      @task2 = create :task2
      @task3 = create :task3
    end

    context 'タスク名を「植栽」、ステータスは「指定なし」で検索した場合' do
      it 'タスク名が「植栽」を含むタスクを返す' do
        expect(Task.search(name: '植栽', status: '')).to include(@task2)
      end

      it '他のタスクを返さない' do
        expect(Task.search(name: '植栽', status: '')).to_not include(@task3)
      end
    end

    context 'タスク名を「テスト」、ステータスは「指定なし」で検索した場合' do
      it '空を返す' do
        expect(Task.search(name: 'テスト', status: '')).to be_empty
      end
    end

    context 'タスク名は指定なし、ステータスを「着手中」で検索した場合' do
      it 'ステータスが「着手中」のタスクを返す' do
        expect(Task.search(name: '', status: 'in_progress')).to include(@task2)
      end
    end

    context 'タスク名を「伐採」、ステータスを「未着手」で検索した場合' do
      it 'タスク名が「伐採」を含み、ステータスが「未着手」のタスクを返す' do
        expect(Task.search(name: '伐採', status: 'not_started')).to include(@task3)
      end
    end
  end
end
