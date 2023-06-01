# frozen_string_literal: true

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

    it 'initializes with a board printer' do
      expect(board.board_printer).to be_instance_of(BoardPrinter)
    end

    it 'initializes with no ships' do
      expect(board.ships).to be_empty
    end
  end

  describe '#add_ship' do
    let(:ship) { instance_double(Ship) }
    before { allow(ship).to receive(:instance_of?).and_return(true) }

    it 'adds a ship to the board' do
      board.add_ship(ship)
      expect(board.ships).to include(ship)
    end
  end

  describe '#shoot_cell' do
    let(:shot_processor) { instance_double(ShotProcessor, process: :hit) }

    before do
      allow(ShotProcessor).to receive(:new).and_return(shot_processor)
    end

    it 'processes a shot at the given coordinates' do
      expect(shot_processor).to receive(:process)
      board.shoot_cell([0, 0])
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
