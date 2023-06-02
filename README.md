# Battleship Game

This is a simple terminal-based version of the classic Battleship game implemented in Ruby.

## Ruby Version
This application is built using Ruby 3.1.2.

## Class Overview

Below are brief explanations of the key classes in this application:

### `Cell`
A cell on a player's board. It holds state if it was shot or not.

### `Ship`
A ship that can be placed on the game board. This class also checks if the ship is placed horizontally, vertically, or diagonally.

### `Player`
A player of the game, which contains a `board` where ships are placed and shots are registered.

### `BoardDimensionsGetter`
This class is responsible for providing the dimensions of the game board.

### `Board`
A board is composed of cells and keeps track of where ships are placed and whether they have been hit.

### `GameLoop`
Controls the main game loop: alternating between player turns, and checking for a win condition.

### `Game`
The main game class that controls game states and player interactions.

## Game Flow:

1. The `Game` class is used to start the game.
2. It initializes two players and their boards.
3. The game then goes into a loop, managed by `GameLoop`, where players take turns shooting at each other's boards.
4. Each player's move involves choosing a cell to target on the opponent's board.
5. The `ShotProcessor` processes the shot and determines if it was a hit, miss, or if it sunk a ship.
6. This continues until all ships of a player have been sunk, at which point the game ends.
7. Players can then decide whether they want to play again, in which case a new game state is initialized, or end the game.

## Other Classes:

- `GameInitializer`: Used by the `Game` class to initialize the game state.
- `ShipFactory`: Factory for creating ships of different types.
- `ShipPlacementHandler`: Responsible for placing a ship on a player's board.
- `BoardPrinter`, `GameInterface`, `InputHelper`, `TurnPrinter`: Helper classes for handling input/output and printing the state of the game to the console.


## Setup Instructions

Ensure that you have the correct Ruby version (3.1.2) installed on your machine. 

### Running the application

You can start the game with the following command:

```bash
ruby main.rb
```

### Running the tests

You can run the test suite (RSpec) with the following command:

```bash
rspec spec/
```
