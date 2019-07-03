// title: Dangerous Dave
// author: RobLoach
// desc: Remake of the 1988 PC classic, Dangerous Dave
// script: wren

import "Engine/Entity/EntityManager" for EntityManager
import "Game/Level" for Level

class Game is TIC {

	construct new(){
		_mainMenu = EntityManager.new()
		_mainMenu.name = "MainMenu"
		var mainMenuLevel = Level.new(_mainMenu, 0, 34, 30, 17)
		_mainMenu.add(mainMenuLevel)
		_mainMenu.prioritize("logo")


		_game = EntityManager.new()
		_game.name = "Game"
		var level = Level.new(_game, 0, 0, 38, 20)
		_game.add(level)
		_game.prioritize("player")
		_game.prioritize("trophy gem")

		_state = _mainMenu
	}

	TIC(){
		TIC.cls(0)
		_state.update()

		if (_state.name == "MainMenu") {
			if (_state["logo"].done) {
				_state = _game
			}
		} else if (_state.name == "Game") {
			var player = _game["player"]
			var level = _game["level"]

			if (player && level) {
				// Bound the camera to the player.
				_game.centerX = player.centerX
				_game.centerY = player.centerY
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

		_state.draw()
	}
}
