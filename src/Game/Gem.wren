import "../Engine/Entity/SpriteEntity"
import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/TextEntity"

class Gem is AnimationEntity {
	construct new(tile, level, gemName) {
		super([tile])
		_active = true
		_player = null
		_level = level
		_sound = 0

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

		_pointAmount = {
			"purple gem": 50,
			"blue gem": 100,
			"red gem": 150,
			"ring gem": 200,
			"crown gem": 300,
			"scepter gem": 500,
			"trophy gem": 1000
		}

		_points = _pointAmount.containsKey(name) ? _pointAmount[name] : 0

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
		} else if (collisionRect(_player)) {
			_active = false
			TIC.sfx(_sound)

			if (name == "gun gem") {
				_player.ammo = 10
			}
			if (name == "jetpack gem") {
				_player.jetpack = 300
			}
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
