# frozen_string_literal: true

class ShotProcessor
  def initialize(board:, coordinates:)
    @board = board
    @coordinates = coordinates
  end

  def process
    cell_under_attack = board.cell_at(coordinates)

    return :hit_before if cell_under_attack.shot?

    cell_under_attack.shoot

    if all_ships_sunk?
      :win
    elsif cell_under_attack.instance_of?(Cell)
      :miss
    else
      ship_under_attack(coordinates).take_hit
      ship_under_attack(coordinates).sunk? ? :sunk : :hit
    end
  end

  private

  attr_reader :board, :coordinates

  def all_ships_sunk?
    board.cells.flatten.select { |cell| cell.instance_of?(ShipCell) }.all?(&:shot?)
  end

  def ship_under_attack(coordinates)
    board.ships.find { |ship| ship.get_coordinates.include?(coordinates) }
  end
end
