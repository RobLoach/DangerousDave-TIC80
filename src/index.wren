// title:  game title
// author: game developer
// desc:   short description
// script: wren

import "random" for Random
import "Engine/Entity/EntityManager" for EntityManager
import "Engine/Entity/CircleEntity" for CircleEntity
import "Engine/Entity/SpriteEntity" for SpriteEntity
import "Engine/Entity/AnimationEntity" for AnimationEntity
import "Game/Level" for Level
import "Engine/Entity/TextEntity"

class Game is TIC {

	construct new(){
		//_level = Level.new()

		_entities = EntityManager.new()
		var level = Level.new(_entities)
		_entities.add(level)

	}

	TIC(){
		TIC.cls(0)

		_entities.update()
		var player = _entities.getEntity("player")
		var level = _entities.getEntity("MapEntity")




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
