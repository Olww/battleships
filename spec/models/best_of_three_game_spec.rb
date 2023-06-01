# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BestOfThreeGame do
  let(:player1) { instance_double('Player', score: 0) }
  let(:player2) { instance_double('Player', score: 2) }
  let(:game) { BestOfThreeGame.new }

  before do
    game.add_player(player1)
    game.add_player(player2)
    allow(game).to receive(:initialize_game_state)
    allow(game).to receive(:start_game_loop)
    allow(game).to receive(:prepare_new_game)
  end

  describe '#start' do
    context 'when a player has a score of 2' do
      it 'stops the game after two rounds' do
        expect(game).to receive(:initialize_game_state).once
        game.start
      end
    end
  end
end
