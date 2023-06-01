# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ShotProcessor do
  let(:ship_cell) { instance_double(ShipCell, shot?: false, shoot: false) }
  let(:cell) { instance_double(Cell, shot?: false, shoot: false) }
  let(:ship) { instance_double(Ship, get_coordinates: [[0, 0]], take_hit: true, sunk?: false) }
  let(:board) { instance_double(Board, cell_at: cell) }
  let(:cells) { [[cell], [ship_cell]] }

  before do
    allow(board).to receive(:cells).and_return(cells)
    allow(board).to receive(:ships).and_return([ship])
    allow(cell).to receive(:instance_of?).and_return(true)
    allow(ship_cell).to receive(:instance_of?).and_return(false)
  end

  subject(:shot_processor) { described_class.new(board: board, coordinates: [0, 0]) }

  describe '#process' do
    context 'when the cell has been shot before' do
      let(:cell) { instance_double(Cell, shot?: true, shoot: true) }

      it 'returns :hit_before' do
        expect(shot_processor.process).to eq :hit_before
      end
    end

    context 'when the cell is shot' do
      it 'returns :miss' do
        expect(board).to receive(:update_hint_observer).once
        expect(shot_processor.process).to eq :miss
      end
    end

    context 'when the ship cell is shot' do
      let(:board) { instance_double(Board, cell_at: ship_cell) }

      it 'returns :miss' do
        expect(board).to receive(:update_hint_observer).once
        expect(shot_processor.process).to eq :hit
      end
    end

    context 'when the ship cell sunk' do
      let(:board) { instance_double(Board, cell_at: ship_cell) }
      let(:ship) { instance_double(Ship, get_coordinates: [[0, 0]], take_hit: true, sunk?: true) }

      it 'returns :miss' do
        expect(board).to receive(:update_hint_observer).once
        expect(shot_processor.process).to eq :sunk
      end
    end
  end
end
