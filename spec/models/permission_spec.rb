# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permission do
  describe 'associations' do
    it { is_expected.to belong_to(:accessor) }
  end
end
