require 'spec_helper'

RSpec.describe Player do
  subject(:player) { described_class.new }

  let(:board) { instance_double(Board) }
  let(:input_helper) { instance_double(InputHelper, get_player_name: "Test") }
  let(:game_interface) { instance_double(GameInterface, :game_interface) }

  before { allow(Board).to receive(:new).and_return(board) }

  describe '#initialize' do
    it 'creates a ship placement handler and places the ship' do
      expect(InputHelper).to receive(:new).twice.and_return(input_helper)
      expect(player.name).to eq("Test")
      expect(player.board).to eq(board)
    end
  end
end
