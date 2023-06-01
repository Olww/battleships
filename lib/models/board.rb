require_relative 'cell'
require_relative 'ship_cell'
require_relative '../config'
require_relative '../services/shot_processor'

class Board
  attr_reader :cells, :ships, :board_printer

  include Config

  def initialize
    @cells = Array.new(config['dimensions']) { Array.new(config['dimensions']) { Cell.new } }
    @board_printer = BoardPrinter.new(board: self)
    @ships = []
  end

  def add_ship(ship)
    @ships << ship if ship.instance_of?(Ship)
  end

  def shoot_cell(coordinates)
    process_shot(coordinates)
  end

  def cell_at(coordinates)
    cells[coordinates[0]][coordinates[1]]
  end

  def occupy_cell(coordinates)
    cells[coordinates[0]][coordinates[1]] = ShipCell.new
  end

  def cell_occupied?(coordinates)
    cells[coordinates[0]][coordinates[1]].instance_of?(ShipCell)
  end

  private

  def process_shot(coordinates)
    ShotProcessor.new(board: self, coordinates: coordinates).process
  end
end
