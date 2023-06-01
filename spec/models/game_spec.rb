require 'spec_helper'

RSpec.describe Game do
  let(:player) { instance_double(Player) }
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'initializes the game' do
      expect(game.players).to eq([])
      expect(game.game_finished).to eq(false)
    end
  end

  describe '#add_player' do
    it 'adds a player to the game' do
      game.add_player(player)
      expect(game.players).to include(player)
    end
  end
end
