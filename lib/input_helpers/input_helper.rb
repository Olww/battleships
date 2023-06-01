require_relative '../output_helpers/game_interface'

class InputHelper
  def get_player_name
    game_interface.name_entrance_message
    gets.chomp
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end
end
