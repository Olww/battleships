# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Player do
  subject(:player) { described_class.new }

  let(:board) { instance_double(Board) }
  let(:input_helper) { instance_double(InputHelper, get_player_name: 'Test') }
  let(:coordinates) { [0, 0] }
  let(:ship_placement_handler) { instance_double(ShipPlacementHandler) }

  before do
    allow(InputHelper).to receive(:new).and_return(input_helper)
    allow(Board).to receive(:new).and_return(board)
    allow(ShipPlacementHandler).to receive(:new).with(board: board, length: 1).and_return(ship_placement_handler)
    allow(ship_placement_handler).to receive(:place)
    allow(input_helper).to receive(:get_turn_input).and_return(coordinates)
    allow(board).to receive(:shoot_cell).with(coordinates)
  end

  describe '#initialize_ship' do
    it 'creates a ship placement handler and places the ship' do
      expect(ship_placement_handler).to receive(:place)
      player.initialize_ship(1)
    end
  end

  describe '#make_turn' do
    it 'gets the turn input from the input helper' do
      expect(input_helper).to receive(:get_turn_input)
      player.make_turn
    end
  end

  describe '#receive_shot' do
    it 'shoots the cell on the board with the given coordinates' do
      expect(board).to receive(:shoot_cell).with(coordinates)
      player.receive_shot(coordinates)
    end
  end
end
