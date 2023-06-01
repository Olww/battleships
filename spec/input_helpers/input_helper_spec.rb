require 'spec_helper'

RSpec.describe InputHelper do
  let(:game_interface) { instance_double(GameInterface) }
  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game_interface).to receive(:name_entrance_message)
  end

  describe "#get_player_name" do
    it "returns the player's name" do
      input_helper = InputHelper.new
      name = "Player 1"
      allow(input_helper).to receive(:gets).and_return(name)
      expect(input_helper.get_player_name).to eq(name)
    end
  end
end
