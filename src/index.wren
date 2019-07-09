// title: Dangerous Dave
// author: RobLoach
// desc: Remake of the 1988 PC classic, Dangerous Dave
// saveid: dangerousdave
// script: wren

import "Engine/Entity/SpriteEntity" for SpriteEntity
import "Game/Level" for Level
import "Game/Highscores" for Highscores

class Game is TIC {

	construct new(){
		_currentLevel = 0
		var testroom = ["test", 0, 26, 26, 8]
		var transition = ["transition", 0, 19, 30, 6]
		_levels = [
			//testroom,
			["MainMenu", 0, 34, 30, 17],
			["Level1", 0, 0, 38, 19],
			transition,
			["Level2", 0, 51, 101, 19],
			transition,
			["Level3", 0, 70, 197, 19],
			transition,
			["Level4", 0, 89, 197, 19],
			transition,
			["Level5", 0, 108, 197, 19],
			transition,
			["Level6", 38, 0, 127, 19],
			transition
		]
		loadLevel()

		_tester = true
	}

	currentLevelNumber() {
		return levelsLeft() * -1 + 7
	}

	levelsLeft() {
		var numTransitions = 4
		var menuCount = 1
		var levelsLeft = 0

		// Count how many levels are left.
		for (i in _currentLevel..._levels.count) {
			if (_levels[i][0].startsWith("Level")) {
				levelsLeft = levelsLeft + 1
			}
		}
		return levelsLeft
	}

	/**
	 * Get the text for the transition screens.
	 */
	levelsLeftText() {
		var left = levelsLeft()
		if (left == 1) {
			return "THIS IS THE LAST LEVEL!!!"
		}
		if (left == 0) {
			return "YES! YOU FINISHED THE GAME!"
		}
		return "GOOD WORK! ONLY %(left) TO GO!"
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
		} else if (status == "gameover") {
			// TODO: Provide a game over screen.

			var playa = _game["player"]

			// TODO: Allow custom highscore names.
			var highscores = Highscores.new()
			highscores.addHighscore({
				"name": "DAV",
				"score": playa.score,
				"level": currentLevelNumber()
			})

			_currentLevel = 0
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

		// Handle the GUI
		gui()
	}

	loadLevel() {
		// Ensure we are loading a valid level.
		if (_currentLevel >= _levels.count) {
			_currentLevel = 0

			// TODO: Provide a WIN screen?
			TIC.reset()
		}

		// Save existing state if needed.
		var score = 0
		var lives = 3
		if (_game) {
			var player = _game["player"]
			if (player) {
				score = player.score
				lives = player.lives
			}
		}

		// Set up the correct game state.
		var levelCoords = _levels[_currentLevel]
		_game = Entity.new()
		_game.name = "game"
		var theLevel = Level.new(_game, levelCoords[1], levelCoords[2], levelCoords[3], levelCoords[4])
		theLevel.tags.add(levelCoords[0])
		_game.add(theLevel)

		// Fix the display order of the entities.
		_game.prioritize("player")
		_game.prioritize("logo")
		_game.prioritize("TrophyItem")

		// Center the camera and save the data.
		var newplayer = _game["player"]
		if (newplayer) {
			//_game.center = newplayer.center
			newplayer.lives = lives
			newplayer.score = score
		}

		if (_currentLevel > 0) {
			TIC.pmem(0, _currentLevel)
		}
	}

	gui() {
		if (!_game) {
			return
		}

		var player = _game["player"]
		if (!player) {
			return
		}

		var xpadding = 2
		var ypadding = 1

		TIC.print("SCORE: %(player.score.toString)", xpadding, ypadding, 0)
		TIC.print("SCORE: %(player.score.toString)", 0, 0, 11)

		var level = currentLevelNumber()
		var levelText = "LEVEL: %(level)"
		var levelWidth = TIC.print(levelText, -999, -999)
		TIC.print(levelText, 240 / 2 - levelWidth / 2 + xpadding, ypadding, 0)
		TIC.print(levelText, 240 / 2 - levelWidth / 2, 0, 11)

		var davesWidth = TIC.print("DAVES: ", -999, -999)
		var daveSpriteWidth = 8
		TIC.print("DAVES: ", 240 - davesWidth - daveSpriteWidth * 3 + xpadding, ypadding, 0)
		TIC.print("DAVES: ", 240 - davesWidth - daveSpriteWidth * 3, 0, 11)

		for (i in 0..player.lives) {
			TIC.spr(495, 240 - daveSpriteWidth * i, 0, 1, 1, 0, 0, 1, 1)
		}
	}
}
