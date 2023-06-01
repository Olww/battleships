require 'spec_helper'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'initializes with empty cells' do
      board.cells.each do |row|
        row.each do |cell|
          expect(cell).to be_instance_of(Cell)
        end
      end
    end
  end

  describe '#cell_at' do
    it 'returns the cell at the given coordinates' do
      cell = board.cell_at([0, 0])
      expect(cell).to be_instance_of(Cell)
    end
  end

  describe '#occupy_cell' do
    it 'changes the cell at the given coordinates to a ShipCell' do
      board.occupy_cell([0, 0])
      expect(board.cell_at([0, 0])).to be_instance_of(ShipCell)
    end
  end

  describe '#cell_occupied?' do
    it 'returns false if the cell at the given coordinates is not a ShipCell' do
      expect(board.cell_occupied?([0, 0])).to be false
    end

    it 'returns true if the cell at the given coordinates is a ShipCell' do
      board.occupy_cell([0, 0])
      expect(board.cell_occupied?([0, 0])).to be true
    end
  end
end
