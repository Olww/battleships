require 'spec_helper'

RSpec.describe ShipFactory do
  let(:start_coordinate) { [0, 0] }
  let(:end_coordinate) { [0, 0] }

  describe '.build_ship' do
    context 'when length is 1' do
      it 'builds a drone boat' do
        expect(Ship).to receive(:create_drone_boat).with(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
        ShipFactory.build_ship(length: 1, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
    end

    context 'when length is 2' do
      it 'builds a patrol boat' do
        expect(Ship).to receive(:create_patrol_boat).with(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
        ShipFactory.build_ship(length: 2, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
    end

    context 'when length is 3' do
      it 'builds a submarine' do
        expect(Ship).to receive(:create_submarine).with(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
        ShipFactory.build_ship(length: 3, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
    end

    context 'when length is 4' do
      it 'builds a destroyer' do
        expect(Ship).to receive(:create_destroyer).with(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
        ShipFactory.build_ship(length: 4, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
      end
    end

    context 'when length is invalid' do
      it 'raises an ArgumentError' do
        expect { ShipFactory.build_ship(length: 5, start_coordinate: start_coordinate, end_coordinate: end_coordinate) }.to raise_error(ArgumentError, 'Invalid ship length: 5')
      end
    end
  end
end
