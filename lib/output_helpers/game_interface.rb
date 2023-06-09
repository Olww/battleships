# frozen_string_literal: true

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
    puts 'Ship placement is invalid. Please choose a different position.'
  end

  def hit_before_status_message
    puts 'This cell has been shot already!'
  end

  def hit_status_message
    clear_screen
    puts 'You hit a ship!'
    wait_to_continue
  end

  def miss_status_message
    clear_screen
    puts 'You missed!'
    wait_to_continue
  end

  def sunk_status_message
    clear_screen
    puts 'You sunk a ship!'
    wait_to_continue
  end

  def win_status_message(player_name)
    clear_screen
    puts "Player #{player_name} won the game!"
    wait_to_continue
  end

  def ask_for_rematch_message
    puts 'Do you want to play again? (y/n)'
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

  def hint_message(hint)
    puts "Hint for the next shot: #{hint}"
    wait_to_continue
  end

  def best_of_3_finished_message(name)
    puts "Congratulations, #{name}! You won the best of 3!"
  end

  def score_message(players)
    puts "Current score: #{players[0].name} - #{players[0].score} : #{players[1].score} - #{players[1].name}"
    wait_to_continue
  end
end
