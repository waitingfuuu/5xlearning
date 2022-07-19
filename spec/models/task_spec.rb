# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'when search tasks' do
    it 'finds a task by title' do
      task = create(:task, title: 'test')
      result = described_class.where(title: 'test')
      expect(result).to eq([task])
    end
  end
end
