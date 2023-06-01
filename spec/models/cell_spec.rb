require 'spec_helper'

RSpec.describe Cell do
  subject(:cell) { described_class.new }

  describe '#initialize' do
    it 'initializes not shot' do
      expect(cell.shot).to be false
    end
  end
end
