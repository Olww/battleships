# frozen_string_literal: true

require 'yaml'

module Config
  CONFIG_PATH = 'config/game_config.yaml'

  def load_config
    YAML.safe_load(File.read(CONFIG_PATH))
  end

  def config
    @config ||= load_config['battleship']
  end
end
