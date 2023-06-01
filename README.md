### Ruby version
ruby-3.1.2
### Run rspec
rpsec spec/

## Architecture Plan

### Game Structure

1. **Game (Singleton)**

    - Main controller class to control the flow of the game
    - Handles player creation, ship placement, and game loop
    - Holds game state (current player, game finished status, etc.)

2. **GameInitializer**

    - Class used to set up the initial game state
    - Handles player creation and ship initialization for each player

3. **GameLoop**

    - Main game loop handler
    - Manages player turns and checks for win conditions

### Player and Game Board

1. **Player**

    - Represents a game participant
    - Maintains player-specific information like name, board, and score
    - Responsible for initializing ships and handling player turns

2. **Board**

    - Represents the game board for a player
    - Manages a grid of Cell instances and handles shooting at cells, and cell occupancy

3. **Cell**

    - Represents a single cell on the game board
    - Tracks if a cell has been shot before

### Ship Management

1. **ShipFactory**

    - Factory pattern used to create ships of different lengths

2. **Ship**

    - Represents a ship on the board
    - Tracks the ship's start/end coordinates, length, and hit points
    - Can determine if it's sunk based on its hit points

3. **ShipPlacementHandler**

    - Handles the placement of ships on the board during game setup

### Shot Processing

1. **ShotProcessor**

    - Handles the processing of a shot on the game board
    - Determines if a shot is a hit, miss, sunk a ship, or resulted in a win condition

### Input/Output Handlers

