# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GameLoop do
  subject(:game_loop) { described_class.new(game: game) }

  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:game) { instance_double(Game, current_player: player1, current_enemy: player2) }
  let(:game_interface) { instance_double(GameInterface, hit_status_message: true) }
  let(:shot) { [0, 0] }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game).to receive(:players).and_return([player1, player2])
    allow(game).to receive(:change_turn)
    allow(game).to receive(:turn_printer).and_return(instance_double(TurnPrinter, call: nil))
    allow(game).to receive(:finish_game)
    allow(player1).to receive(:make_turn).and_return(shot)
    allow(player2).to receive(:receive_shot).and_return(:hit)
  end

  describe '#call' do
    it 'starts the game loop' do
      expect(game).to receive(:change_turn).once
      expect(game_interface).to receive(:goodbye_message)
      allow(game).to receive(:game_finished).and_return(false, true)
      game_loop.call
    end
  end

  describe '#make_turn' do
    it 'processes a hit' do
      allow(game).to receive(:game_finished).and_return(false, true)
      expect(game_interface).to receive(:goodbye_message)
      expect(game_interface).to receive(:hit_status_message)
      game_loop.call
    end
  end
end
