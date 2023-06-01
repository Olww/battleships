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

  describe '#change_turn' do
    let(:player2) { instance_double(Player) }

    before do
      game.add_player(player)
      game.add_player(player2)
    end

    it 'rotates the players' do
      game.change_turn
      expect(game.current_player).to eq(player2)
      expect(game.current_enemy).to eq(player)
    end
  end

  describe '#current_player' do
    before do
      game.add_player(player)
    end

    it 'returns the current player' do
      expect(game.current_player).to eq(player)
    end
  end

  describe '#current_enemy' do
    let(:player2) { instance_double(Player) }

    before do
      game.add_player(player)
      game.add_player(player2)
    end

    it 'returns the current enemy' do
      expect(game.current_enemy).to eq(player2)
    end
  end

  describe '#finish_game' do
    it 'finishes the game' do
      game.finish_game
      expect(game.game_finished).to eq(true)
    end
  end
end
