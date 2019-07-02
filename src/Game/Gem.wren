import "../Engine/Entity/SpriteEntity"
import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/TextEntity"

class Gem is AnimationEntity {
	construct new(tile, level, gemName) {
		super([tile])
		_active = true
		_player = null
		_level = level

		name = gemName

		if (name == "trophy gem") {
			frames = [
				tile,
				SpriteEntity[3, 10, 2],
				SpriteEntity[4, 10, 2],
				SpriteEntity[5, 10, 2],
				SpriteEntity[6, 10, 2]
			]
			animationSpeed = 5
		}
		tileWidth = 2
		tileHeight = 2
	}

	active{_active}
	active=(v){_active=v}

	update() {
		if (!_active) {
			return
		}
		if (!_player) {
			_player = _level["player"]
		}
		if (collisionRect(_player)) {
			_active = false
		}

		super()
	}

	draw(camera) {
		if (_active) {
			super(camera)
			return
		}

		// If the Trophy was taken, display a message.
		if (name == "trophy gem") {
 			var textWidth = TIC.print("GET TO THE DOOR!", -999, -999, 14)
 			TIC.print("GO THRU THE DOOR", 240 / 2 - textWidth / 2, 136 / 2 + 5, 14)
		}
	}
}
