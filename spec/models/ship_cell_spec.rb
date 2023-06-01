# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ShipCell do
  subject(:cell) { described_class.new }

  describe '#initialize' do
    it 'initializes not shot' do
      expect(cell.shot).to be false
    end
  end

  describe '#shoot' do
    it 'marks the cell as shot' do
      cell.shoot
      expect(cell.shot).to be true
    end
  end

  describe '#shot?' do
    context 'when the cell is shot' do
      before do
        cell.shoot
      end

      it 'returns true' do
        expect(cell.shot?).to be true
      end
    end

    context 'when the cell is not shot' do
      it 'returns false' do
        expect(cell.shot?).to be false
      end
    end
  end
end
