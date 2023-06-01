require 'singleton'

class GameInterface
  include Singleton

  def player_creation_message(player_number)
    puts "Creating player #{player_number + 1}!"
  end

  def name_entrance_message
    puts 'Please, enter your name:'
  end

  def incorrect_input_message
    puts 'Incorrect input! Please try again.'
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