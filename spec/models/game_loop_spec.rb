# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GameLoop do
  let(:game_interface) { instance_double("GameInterface") }
  let(:game) { instance_double("Game", game_finished: false, change_turn: nil, turn_printer: double(call: nil), current_player: double(make_turn: :coordinate), finish_game: nil, prepare_new_game: nil) }
  let(:enemy) { instance_double("Player") }
  let(:game_loop) { GameLoop.new(game: game) }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game).to receive(:current_enemy).and_return(enemy)
    allow(enemy).to receive(:receive_shot).and_return(true)
    allow(game_interface).to receive(:hit_before_status_message)
    allow(game_interface).to receive(:hit_status_message)
    allow(game_interface).to receive(:miss_status_message)
    allow(game_interface).to receive(:sunk_status_message)
    allow(game_interface).to receive(:win_status_message)
    allow(game_interface).to receive(:ask_for_rematch_message)
    allow(game).to receive(:game_finished).and_return(true)
    allow(game_interface).to receive(:goodbye_message)
  end

  describe '#call' do
    it 'starts the game loop' do
      expect(game_interface).to receive(:goodbye_message).once
      game_loop.call
    end
  end

  describe '#start_turn_loop' do
    it 'ends the turn loop when a shot hits' do
      allow(enemy).to receive(:receive_shot).and_return(:hit)
      expect(game_interface).to receive(:hit_status_message).once
      game_loop.send(:start_turn_loop)
    end

    it 'ends the turn loop when a shot misses' do
      allow(enemy).to receive(:receive_shot).and_return(:miss)
      expect(game_interface).to receive(:miss_status_message).once
      game_loop.send(:start_turn_loop)
    end

    it 'ends the turn loop when a ship is sunk' do
      allow(enemy).to receive(:receive_shot).and_return(:sunk)
      expect(game_interface).to receive(:sunk_status_message).once
      game_loop.send(:start_turn_loop)
    end
  end

  describe '#ask_for_rematch' do
    before do
      allow(game_loop).to receive(:gets).and_return("n\n")
    end

    it 'displays a goodbye message and exits if the player declines a rematch' do
      expect(game_interface).to receive(:goodbye_message).once
      expect(game_loop).to receive(:exit)
      game_loop.send(:ask_for_rematch)
    end
  end
end
