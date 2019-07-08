import "../Engine/Entity/SpriteEntity"
import "Death"
import "Bullet"

class Enemy is Death {
	construct new(tile, deathName) {
		super(tile, deathName)

		tags.add("enemy")

		if (name == "spider enemy") {
			frames = [
				SpriteEntity[0, 12, 2]
			]

			tileWidth = 4
			tileHeight = 2
		}
		if (name == "slicer enemy") {
			frames = [
				SpriteEntity[2, 12, 2]
			]

			tileWidth = 4
			tileHeight = 2
		}
		_t = 0
		_shootTimerStart = 150
		_shootTimer = _shootTimerStart
	}

	update() {

		// Move up and down on the screen.
		// TODO: Figure out the correct pattern.
		if (name == "spider enemy") {
			_t = _t + 0.06
			velocity.y = _t.sin * 1
			velocity.x = _t.cos * 1.8
		}

		if (name == "slicer enemy") {
			_t = _t + 0.02
			velocity.y = _t.sin * 1
			velocity.x = _t.cos * 1.6
		}

		if (_t > 10000) {
			_t = 0
		}

		if (!_player) {
			_player = parent["player"]
		} else {
			flip = (_player.centerX < _player.centerX) ? 0 : 1
		}

		_shootTimer = _shootTimer - 1
		if (_shootTimer <= 0) {
			_shootTimer = _shootTimerStart
			var bullet = Bullet.new(this, "enemy")
			bullet.flip = flip
			parent.add(bullet)
		}

		super()
	}

}
