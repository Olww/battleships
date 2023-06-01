require 'singleton'

class GameInterface
  include Singleton

  def player_creation_message(player_number)
    puts "Creating player #{player_number + 1}!"
  end

  def player_ship_placement(player_name)
    clear_screen
    puts "Player #{player_name} has to place ships.\n\n"
  end

  def ship_placement_message(ship_length)
    puts "Place ship length #{ship_length}."
  end

  def ship_placement_error_message
    puts "Ship placement is invalid. Please choose a different position.\n\n"
  end

  def name_entrance_message
    puts 'Please, enter your name:'
  end

  def enter_coordinates_message(purpose = '')
    puts "Enter #{purpose} coordinate in format 'A1':"
  end

  def incorrect_input_message
    puts 'Incorrect input! Please try again.'
  end

  def goodbye_message
    puts 'Thanks for playing!'
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def puts(message)
    Kernel.puts(message)
  end

  def print(message)
    Kernel.print(message)
  end

  def wait_to_continue
    puts 'Press enter to continue.'
    gets
  end
end