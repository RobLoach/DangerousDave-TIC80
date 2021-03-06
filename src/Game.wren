/**
 * TODO: Color Palette
 * The following is a color palette that may work, but needs tweaking:
 * pal: 0000004424340000e34e4a4fcb7d4d047d007d0000757161007dcfffaa5def000041ff41e800e85dbefffff700efefef
 */

import "Engine/Entity/EntityManager" for EntityManager
import "Engine/Entity/SpriteEntity" for SpriteEntity
import "Game/Level" for Level
import "Game/Highscores" for Highscores
import "Engine/Engine"

class Game is TIC {
	construct new() {
		Engine.start()
		// Set up the list of levels. Each level is an array of...
		// [name, x, y, width, height, levelNum]
		var transition = ["transition", 0, 19, 30, 6, -1]
		_levels = [
			//["TestRoom", 0, 25, 32, 9, 99],
			["MainMenu", 166, 0, 20, 17, 0],
			["Level1", 0, 0, 38, 19, 1],
			transition,
			["Level2", 0, 38, 101, 19, 2],
			transition,
			["Level3", 0, 57, 197, 19, 3],
			transition,
			["Level4", 0, 76, 197, 19, 4],
			transition,
			["Level5", 0, 95, 197, 19, 5],
			transition,
			["Level6", 38, 0, 127, 19, 6],
			transition,
			["Level7", 30, 19, 158, 19, 7],
			transition,
			["Level8", 0, 114, 197, 19, 8],
			transition,
			["Level9", 102, 38, 138, 19, 9],
			transition,
			["Level10", 198, 57, 42, 79, 10],
			transition
		]

		// Finally, load the main menu as the initial "level".
		_currentLevel = 0
		loadLevel()
	}

	/**
	 * Get the current level.
	 */
	currentLevelNumber() {
		var currentLevelNum = _levels[_currentLevel][5]
		// Check if it's a transition screen.
		if (currentLevelNum == -1) {
			return _levels[_currentLevel - 1][5]
		}
		return currentLevelNum
	}

	/**
	 * Retrieve the amount of levels that are left.
	 */
	levelsLeft() {
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

	/**
	 * Called every tick to update game state, and render.
	 *
	 * @see https://github.com/nesbox/TIC-80/wiki/tic
	 */
	TIC(){
		// Clear the screen to Black.
		TIC.cls(0)

		// Check if the level has been completed.
		var status = _game["level"].status

		// The player finished a level.
		if (status == "complete") {
			var prevLevel = currentLevelNumber()
			_currentLevel = _currentLevel + 1

			// Check if the player completed the game.
			if(_currentLevel >= _levels.count) {
				// Get the player's score, and show the highscore screen.
				var playa = _game["player"]
				var highscores = Highscores.new(this)
				highscores.addHighscore({
					"name": "DAV",
					"score": playa.score,
					"level": prevLevel
				})

				// Load up the main menu screen.
				_currentLevel = 0
			}

			// Load the new menu, and shoe highscores if needed.
			loadLevel()
			var logo = _game["logo"]
			if (logo) {
				logo.showHighscores()
			}
		// Load the game from a previous state.
		} else if (status == "load") {
			if (Engine.saveGameEnabled) {
				_currentLevel = TIC.pmem(0)
			} else {
				_currentLevel = 1
			}
			loadLevel()
		// The player lost all their lives.
		} else if (status == "gameover") {
			var playa = _game["player"]
			var highscores = Highscores.new(this)
			highscores.addHighscore({
				"name": "DAV",
				"score": playa.score,
				"level": currentLevelNumber()
			})

			_currentLevel = 0
			loadLevel()
			var logo = _game["logo"]
			if (logo) {
				logo.showHighscores()
			}

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
			} else {
				_game.center = level.center
			}
		}

		// Render the game on the screen.
		_game.draw()
	}

	/**
	 * Set up the new level based on what's in _currentLevel.
	 */
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
		_game = EntityManager.new()
		_game.name = "game"
		var theLevel = Level.new(_game, levelCoords[1], levelCoords[2], levelCoords[3], levelCoords[4])
		theLevel.tags.add(levelCoords[0])
		_game.add(theLevel)

		// Fix the display order of the entities.
		var enemies = _game.getEntities("enemy")
		for (enemy in enemies) {
			enemy.prioritize()
		}
		_game.prioritize("player")
		_game.prioritize("logo")
		_game.prioritize("TrophyItem")

		// Center the camera and save the data.
		var newplayer = _game["player"]
		if (newplayer) {
			_game.center = newplayer.center
			newplayer.lives = lives
			newplayer.score = score
		}

		// Save the game
		if (_currentLevel > 0 && Engine.saveGameEnabled) {
			TIC.pmem(0, _currentLevel)
		}
	}

	/**
	 * Display the heads-up display GUI.
	 *
	 * @see https://github.com/nesbox/TIC-80/wiki/OVR
	 */
	OVR() {
		if (!_game) {
			return
		}

		// Only show the GUI if there's a player on the screen.
		var player = _game["player"]
		if (!player) {
			return
		}

		// Text shadow padding
		var xpadding = 1
		var ypadding = 1

		// Score
		TIC.print("SCORE: %(player.score.toString)", xpadding, ypadding, 0)
		TIC.print("SCORE: %(player.score.toString)", 0, 0, 11)

		// Level
		var level = currentLevelNumber()
		var levelText = "LEVEL: %(level)"
		var levelWidth = TIC.print(levelText, -999, -999)
		TIC.print(levelText, 240 / 2 - levelWidth / 2 + xpadding, ypadding, 0)
		TIC.print(levelText, 240 / 2 - levelWidth / 2, 0, 11)

		// Daves
		var davesWidth = TIC.print("DAVES: ", -999, -999)
		var daveSpriteWidth = 8
		TIC.print("DAVES: ", 240 - davesWidth - daveSpriteWidth * 3 + xpadding, ypadding, 0)
		TIC.print("DAVES: ", 240 - davesWidth - daveSpriteWidth * 3, 0, 11)
		if (player.lives >= 0) {
			for (i in 0...player.lives) {
				TIC.spr(495, 240 - daveSpriteWidth * 3 + daveSpriteWidth * i, 0, 1, 1, 0, 0, 1, 1)
			}
		}

		// Jetpack
		if (player.jetpack > 0) {
			var maxjetpack = 60*20
			var jetpackbarWidth = 40
			var percent = player.jetpack / maxjetpack * jetpackbarWidth

			var jetpackTextWidth = TIC.print("JETPACK", -999, -999, 15, false, 1, true)
			TIC.print("JETPACK", xpadding, 136 - 5 + ypadding, 0, false, 1, true)
			TIC.print("JETPACK", 0, 136 - 5, 11, false, 1, true)
			TIC.rect(jetpackTextWidth + 5, 136 - 5, jetpackbarWidth, 5, 14)
			TIC.rect(jetpackTextWidth + 6, 136 - 4, percent - 2, 3, 6)
		}

		// Gun
		if (player.ammo > 0) {
			var gunTextWidth = TIC.print("GUN", -999, -999, 15, false, 1, true)
			TIC.print("GUN", 240 - gunTextWidth - 16 + xpadding, 136 - 5 + ypadding, 0, false, 1, true)
			TIC.print("GUN", 240 - gunTextWidth - 16, 136 - 5, 11, false, 1, true)
			TIC.spr(SpriteEntity[15, 26], 240 - 12, 136 - 8, 1, 1, 0, 0, 1, 1)
		}
	}
}
