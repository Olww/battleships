# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ShipPlacementHandler do
  let(:input_helper) do
    instance_double(InputHelper, get_battleship_coordinates: { start_coordinate: [0, 0], end_coordinate: [0, 1] })
  end
  let(:game_interface) { instance_double(GameInterface) }
  let(:ship) { instance_double(Ship, valid?: true, get_coordinates: [[0, 0], [0, 1]]) }
  let(:board) do
    instance_double(Board, board_printer: board_printer, add_ship: true, occupy_cell: true, cell_occupied?: false)
  end
  let(:board_printer) { instance_double(BoardPrinter, print_open: true) }

  before do
    allow(InputHelper).to receive(:new).and_return(input_helper)
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(ShipFactory).to receive(:build_ship).and_return(ship)
    allow(game_interface).to receive_messages(ship_placement_message: true, ship_placement_error_message: true,
                                              wait_to_continue: true)
  end

  subject(:ship_placement_handler) { described_class.new(board: board, length: 2) }

  describe '#place' do
    context 'when the ship placement is valid' do
      it 'places the ship on the board and occupies the cell' do
        expect(board).to receive(:add_ship).with(ship)
        ship.get_coordinates.each do |coordinate|
          expect(board).to receive(:occupy_cell).with(coordinate)
        end
        ship_placement_handler.place
      end
    end

    context 'when the ship placement is not valid' do
      let(:ship) { instance_double(Ship, valid?: false, get_coordinates: [[0, 0], [0, 1]]) }

      it 'displays an error message' do
        expect(game_interface).to receive(:ship_placement_error_message).and_raise(StandardError)
        expect { ship_placement_handler.place }.to raise_error(StandardError)
      end
    end
  end
end
