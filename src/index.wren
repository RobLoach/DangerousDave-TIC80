// title: Dangerous Dave
// author: RobLoach
// desc: Remake of the 1988 PC classic, Dangerous Dave
// saveid: dangerousdave
// script: wren

import "Engine/Entity/EntityManager" for EntityManager
import "Game/Level" for Level

class Game is TIC {

	construct new(){
		_currentLevel = 0
		var testroom = ["test", 0, 26, 26, 8]
		var transition = ["transition", 0, 20, 30, 6]
		_levels = [
			//testroom,
			["MainMenu", 0, 34, 30, 17],
			["Level1", 0, 0, 38, 20],
			transition,
			["Level2", 0, 51, 101, 19],
			transition,
			["Level3", 0, 70, 197, 19],
			transition,
			["Level4", 0, 89, 197, 19],
			transition
		]
		loadLevel()
	}

	/**
	 * Get the text for the transition screens.
	 */
	levelsLeftText() {
		var numTransitions = 4
		var menuCount = 1
		var levelsLeft = 0

		// Count how many levels are left.
		for (i in _currentLevel..._levels.count) {
			if (_levels[i][0].startsWith("Level")) {
				levelsLeft = levelsLeft + 1
			}
		}

		if (levelsLeft == 1) {
			return "THIS IS THE LAST LEVEL!!!"
		}
		if (levelsLeft == 0) {
			return "YES! YOU FINISHED THE GAME!"
		}
		return "GOOD WORK! ONLY %(levelsLeft) TO GO!"
	}

	TIC(){
		// Clear the screen to Black.
		TIC.cls(0)

		// Check if the level has been completed.
		var status = _game["level"].status
		if (status == "complete") {
			_currentLevel = _currentLevel + 1
			loadLevel()
		} else if (status == "load") {
			_currentLevel = TIC.pmem(0)
			loadLevel()
		}

		// Update the game state.
		_game.update()

		// Fix the camera position.
		var level = _game["level"]
		if (level) {
			var player = _game["player"]

			// Transition Screen
			if (level.hasTag("transition")) {
				_game.center = level.center
				var text = levelsLeftText()
				var textWidth = TIC.print(text, -100, -100, 15)
				TIC.print(text, 240 / 2 - textWidth / 2, -_game.top - 10, 15)
			} else if (player) {
				_game.center = player.center
				if (_game.top < 0) {
					_game.top = 0
				}
				if (_game.bottom > level.bottom) {
					_game.bottom = level.bottom
				}
				if (_game.left < 0) {
					_game.left = 0
				}
				if (_game.right > level.right) {
					_game.right = level.right
				}
			}
		}

		// Render the game on the screen.
		_game.draw()
	}

	loadLevel() {
		// Ensure we are loading a valid level.
		if (_currentLevel >= _levels.count) {
			_currentLevel = 0

			// TODO: Provide a WIN screen?
			TIC.reset()
		}

		// Set up the correct game state.
		var levelCoords = _levels[_currentLevel]
		_game = EntityManager.new()
		_game.name = "game"
		var theLevel = Level.new(_game, levelCoords[1], levelCoords[2], levelCoords[3], levelCoords[4])
		theLevel.tags.add(levelCoords[0])
		_game.add(theLevel)

		// Fix the display order of the entities.
		_game.prioritize("player")
		_game.prioritize("logo")
		_game.prioritize("trophy gem")

		// Center the camera.
		var player = _game["player"]
		if (player) {
			_game.center = player.center
		}

		if (_currentLevel > 0) {
			TIC.pmem(0, _currentLevel)
		}
	}
}
