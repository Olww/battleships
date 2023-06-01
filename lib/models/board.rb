require_relative 'cell'
require_relative 'ship_cell'
require_relative '../config'

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

  def cell_at(coordinates)
    cells[coordinates[0]][coordinates[1]]
  end

  def occupy_cell(coordinates)
    cells[coordinates[0]][coordinates[1]] = ShipCell.new
  end

  def cell_occupied?(coordinates)
    cells[coordinates[0]][coordinates[1]].instance_of?(ShipCell)
  end
end
