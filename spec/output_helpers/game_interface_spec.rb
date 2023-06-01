require 'spec_helper'

RSpec.describe GameInterface do
  subject(:game_interface) { described_class.instance }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  describe "#player_creation_message" do
    it "outputs a message for player creation" do
      game_interface.player_creation_message(0)
      expect($stdout.string).to include("Creating player 1!")
    end
  end

  describe "#puts" do
    it "outputs a message to stdout" do
      game_interface.puts("Hello, world!")
      expect($stdout.string).to include("Hello, world!")
    end
  end

  describe "#print" do
    it "prints a message to stdout" do
      game_interface.print("Hello, world!")
      expect($stdout.string).to include("Hello, world!")
    end
  end

  describe "#wait_to_continue" do
    it "outputs a message to wait and gets user input" do
      allow(game_interface).to receive(:gets).and_return("\n")
      game_interface.wait_to_continue
      expect($stdout.string).to include("Press enter to continue.")
    end
  end
end
