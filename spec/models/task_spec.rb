require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validations' do
    context 'title must be present' do
      it 'is not valid without a title' do
        task = Task.new(content: 'it is a test', tag: 'test')
        expect(task).not_to be_valid
      end

      it 'is valid with a title ' do
        task = Task.new(title: 'E2E', content: 'it is a test', tag: 'test')
        expect(task).to be_valid
        expect(task.title).to eq('E2E')
      end
    end
  end
end
