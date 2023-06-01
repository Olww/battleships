# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ship do
  describe 'initialization' do
    subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 2]) }

    it 'creates a ship with the correct attributes' do
      expect(ship.instance_variable_get(:@length)).to eq(3)
      expect(ship.instance_variable_get(:@start_coordinate)).to eq([0, 0])
      expect(ship.instance_variable_get(:@end_coordinate)).to eq([0, 2])
      expect(ship.instance_variable_get(:@hit_points)).to eq(3)
    end
  end

  describe 'creation methods' do
    let(:start_coordinate) { [0, 0] }
    let(:end_coordinate) { [0, 2] }

    context '.create_drone_boat' do
      subject(:ship) do
        described_class.create_drone_boat(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
      it 'creates a drone boat with length 1' do
        expect(ship.instance_variable_get(:@length)).to eq(1)
      end
    end

    context '.create_patrol_boat' do
      subject(:ship) do
        described_class.create_patrol_boat(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
      it 'creates a patrol boat with length 2' do
        expect(ship.instance_variable_get(:@length)).to eq(2)
      end
    end

    context '.create_submarine' do
      subject(:ship) do
        described_class.create_submarine(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
      it 'creates a submarine with length 3' do
        expect(ship.instance_variable_get(:@length)).to eq(3)
      end
    end

    context '.create_destroyer' do
      subject(:ship) do
        described_class.create_destroyer(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
      it 'creates a destroyer with length 4' do
        expect(ship.instance_variable_get(:@length)).to eq(4)
      end
    end
  end

  describe '#get_coordinates' do
    context 'for a horizontal ship' do
      subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 2]) }

      it 'returns the correct coordinates' do
        expect(ship.get_coordinates).to eq([[0, 0], [0, 1], [0, 2]])
      end
    end

    context 'for a vertical ship' do
      subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [2, 0]) }

      it 'returns the correct coordinates' do
        expect(ship.get_coordinates).to eq([[0, 0], [1, 0], [2, 0]])
      end
    end
  end

  describe '#valid?' do
    context 'for a horizontal ship with correct length' do
      subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 2]) }

      it 'returns true' do
        expect(ship.valid?).to eq(true)
      end
    end

    context 'for a vertical ship with incorrect length' do
      subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 1]) }

      it 'returns false' do
        expect(ship.valid?).to eq(false)
      end
    end
  end

  describe '#take_hit' do
    subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 2]) }

    it 'reduces hit points' do
      expect { ship.take_hit }.to change { ship.instance_variable_get(:@hit_points) }.by(-1)
    end
  end

  describe '#sunk?' do
    subject(:ship) { described_class.new(length: 3, start_coordinate: [0, 0], end_coordinate: [0, 2]) }

    context 'when the ship is not sunk' do
      it 'returns false' do
        expect(ship.sunk?).to eq(false)
      end
    end

    context 'when the ship is sunk' do
      before do
        3.times { ship.take_hit }
      end

      it 'returns true' do
        expect(ship.sunk?).to eq(true)
      end
    end
  end
end
