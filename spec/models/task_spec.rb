# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validates' do
    context 'when create task' do
      let (:task) { create(:task) }

      it 'title is required' do
        expect(task.title).not_to be_empty
      end
    end
  end
end
