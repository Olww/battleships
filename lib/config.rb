require 'yaml'

module Config
  CONFIG_PATH = 'config/game_config.yaml'

  def load_config
    YAML.load(File.read(CONFIG_PATH))
  end

  def config
    @config ||= load_config['battleship']
  end
end