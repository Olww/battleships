# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BestOfThreeGame do
  let(:player1) { instance_double('Player', score: 0, name: 'test') }
  let(:player2) { instance_double('Player', score: 2, name: 'test2') }
  let(:game) { BestOfThreeGame.new }
  let(:game_interface) { instance_double(GameInterface) }

  before do
    game.add_player(player1)
    game.add_player(player2)
    allow(game).to receive(:initialize_game_state)
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game).to receive(:start_game_loop)
    allow(game).to receive(:prepare_new_game)
    allow(game).to receive(:ask_for_rematch)
    allow(game_interface).to receive(:best_of_3_finished_message)
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
