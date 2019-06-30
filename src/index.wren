// title:  game title
// author: game developer
// desc:   short description
// script: wren

import "random" for Random
import "Engine/Entity/EntityManager" for EntityManager
import "Engine/Entity/CircleEntity" for CircleEntity
import "Engine/Entity/SpriteEntity" for SpriteEntity
import "Engine/Entity/AnimationEntity" for AnimationEntity
import "Engine/Entity/MapEntity" for MapEntity
import "Engine/Entity/TextEntity"

class Game is TIC {

	construct new(){
		//_level = Level.new()

		_entities = EntityManager.new()
		_player = CircleEntity.new()
		_player.x = 50
		_player.tags.add("player")
		_player.y = 50
		_player.color = 9
		_entities.add(_player)

		var sprite = SpriteEntity.new(SpriteEntity[0, 8], 2, 2)
		sprite.tags.add("player")
		_entities.add(sprite)

		var anim = AnimationEntity.new([
			SpriteEntity[0, 8, 2],
			SpriteEntity[1, 8, 2],
			SpriteEntity[2, 8, 2],
			SpriteEntity[1, 8, 2],
		])
		anim.tileWidth = 2
		anim.tileHeight = 2
		anim.x = 100
		anim.y = 100
		_entities.add(anim)


		var level = MapEntity.new(0, 0, 38, 20)
		_entities.add(level)

		var t = level[0,0]
		TIC.trace(t)
		TIC.trace(level[0,0] = 2)

		var text = TextEntity.new("Hello\nWorld!")
		text.center = _entities.center
		text.color = 15
		text.smallfont = true
		text.text = "Hello World!\n\nHow are you?"
		_entities.add(text)
	}

	TIC(){
		TIC.cls(0)

		_entities.update()
		var player = _entities.getEntity("player")
		var level = _entities.getEntity("MapEntity")


		if (TIC.btn(0)) {
			player.velocity.y = -1
		} else if (TIC.btn(1)) {
			player.velocity.y = 1
		} else {
			player.velocity.y = 0
		}
		if (TIC.btn(2)) {
			player.velocity.x = -1
		} else if (TIC.btn(3)) {
			player.velocity.x = 1
		} else {
			player.velocity.x = 0
		}


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
