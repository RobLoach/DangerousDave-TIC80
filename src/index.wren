// title:  game title
// author: game developer
// desc:   short description
// script: wren

import "Engine/Entity/EntityManager" for EntityManager
import "Game/Level" for Level

class Game is TIC {

	construct new(){
		_entities = EntityManager.new()
		var level = Level.new(_entities)
		_entities.add(level)
		_entities.prioritize("player")
		_entities.prioritize("trophy gem")
	}

	TIC(){
		TIC.cls(0)

		_entities.update()
		var player = _entities["player"]
		var level = _entities["level"]

		// Bound the camera to the player.
		_entities.centerX = player.centerX
		_entities.centerY = player.centerY
		if (_entities.top < 0) {
			_entities.top = 0
		}
		if (_entities.bottom > level.bottom) {
			_entities.bottom = level.bottom
		}
		if (_entities.left < 0) {
			_entities.left = 0
		}
		if (_entities.right > level.right) {
			_entities.right = level.right
		}

		_entities.draw()
	}
}
