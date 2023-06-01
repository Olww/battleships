require 'spec_helper'

RSpec.describe GameInitializer do
  let(:game_interface) { instance_double(GameInterface) }
  let(:board_printer) { instance_double(BoardPrinter, print_open: true) }
  let(:board) { instance_double(Board, board_printer: board_printer) }
  let(:player) { instance_double(Player, name: "Player1", board: board) }
  let(:game) { instance_double(Game, add_player: true, players: [player]) }
  let(:config) { {'number_of_players' => 2, 'ships' => [2, 3, 3, 4, 5]} }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game_interface).to receive(:player_creation_message)
    allow(game_interface).to receive(:player_ship_placement)
    allow(game_interface).to receive(:wait_to_continue)
    allow(player).to receive(:initialize_ship)
    allow(subject).to receive(:config).and_return(config)
  end

  subject(:game_initializer) { described_class.new(game: game) }

  describe '#initialize_players' do
    it 'creates players' do
      game_initializer.initialize_players
      expect(game).to have_received(:add_player).twice
      expect(game_interface).to have_received(:player_creation_message).twice
    end
  end

  describe '#initialize_ships' do
    it 'places ships for each player' do
      game_initializer.initialize_ships
      expect(game_interface).to have_received(:player_ship_placement).once
      expect(game_interface).to have_received(:wait_to_continue).once
      expect(player).to have_received(:initialize_ship).exactly(5).times
    end
  end
end
