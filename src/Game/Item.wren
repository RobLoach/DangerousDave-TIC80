import "../Engine/Entity/SpriteEntity"
import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/TextEntity"

class Item is AnimationEntity {
	construct new(tile, level, itemName) {
		super([tile])
		_active = true
		_player = null
		_level = level
		_sound = 0
		_channel = 3

		name = itemName

		if (name == "TrophyItem") {
			frames = [
				tile,
				SpriteEntity[3, 10, 2],
				SpriteEntity[4, 10, 2],
				SpriteEntity[5, 10, 2],
				SpriteEntity[6, 10, 2]
			]
			animationSpeed = 5
			_sound = 5
		}

		_pointAmount = {
			"PurpleGemItem": 50,
			"BlueGemItem": 100,
			"RedGemItem": 150,
			"RingItem": 200,
			"CrownItem": 300,
			"ScepterItem": 500,
			"TrophyItem": 1000
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
		} else if (_player.state != "dying") {
			if (collisionRect(_player.boundingBox())) {
				_active = false
				TIC.sfx(_sound, "F-7", -1, _channel)

				if (name == "GunItem") {
					_player.ammo = 9999
				} else if (name == "JetpackItem") {
					_player.jetpack = 60*20
				}

				_player.score = _player.score + _points
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
		if (name == "TrophyItem") {
			var ybottom = 5
 			var textWidth = TIC.print("GET TO THE DOOR!", -999, -999, 14)
 			TIC.print("GO THRU THE DOOR", 240 / 2 - textWidth / 2 + 1, 136 - ybottom + 1, 0)
 			TIC.print("GO THRU THE DOOR", 240 / 2 - textWidth / 2, 136 - ybottom, 11)
		}
	}
}
