# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe InputHelper do
  let(:game_interface) { instance_double(GameInterface) }
  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game_interface).to receive(:name_entrance_message)
    allow(game_interface).to receive(:enter_coordinates_message)
    allow(game_interface).to receive(:incorrect_input_message)
  end

  describe '#get_player_name' do
    it "returns the player's name" do
      input_helper = InputHelper.new
      name = 'Player 1'
      allow(input_helper).to receive(:gets).and_return(name)
      expect(input_helper.get_player_name).to eq(name)
    end
  end

  describe '#get_battleship_coordinates' do
    it 'returns valid start and end coordinates' do
      input_helper = InputHelper.new
      start_coordinate = ['A', 1]
      end_coordinate = ['A', 2]
      allow(input_helper).to receive(:enter_coordinate).and_return(start_coordinate, end_coordinate)
      expect(input_helper.get_battleship_coordinates).to eq({ start_coordinate: start_coordinate,
                                                              end_coordinate: end_coordinate })
    end
  end

  describe '#get_turn_input' do
    it 'returns valid shot coordinate' do
      input_helper = InputHelper.new
      shot_coordinate = ['A', 1]
      allow(input_helper).to receive(:enter_coordinate).and_return(shot_coordinate)
      expect(input_helper.get_turn_input).to eq(shot_coordinate)
    end
  end

  describe '#enter_coordinate' do
    it 'returns a correct coordinate' do
      input_helper = InputHelper.new
      correct_coordinate = ['A', 1]
      allow(input_helper).to receive(:gets).and_return("A2\n", "B2\n", "A1\n")
      allow(input_helper).to receive(:transform_coordinate_input).and_return(correct_coordinate)
      allow(input_helper).to receive(:correct_coordinate?).and_return(false, false, true)
      expect(input_helper.send(:enter_coordinate)).to eq(correct_coordinate)
    end
  end

  describe '#transform_coordinate_input' do
    it 'transforms the coordinate input' do
      input_helper = InputHelper.new
      expect(input_helper.send(:transform_coordinate_input, 'A1')).to eq([0, 0])
    end
  end

  describe '#correct_coordinate?' do
    it 'returns true if the coordinate is correct' do
      input_helper = InputHelper.new
      expect(input_helper.send(:correct_coordinate?, [1, 1])).to eq(true)
    end

    it 'returns false if the coordinate is incorrect' do
      input_helper = InputHelper.new
      expect(input_helper.send(:correct_coordinate?, ['Z', 100])).to eq(false)
    end
  end
end
