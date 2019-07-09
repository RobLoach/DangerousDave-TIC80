import "../Engine/Entity/SpriteEntity"
import "Death"
import "Bullet"

class Enemy is Death {
	construct new(tile, deathName) {
		super(tile, deathName)

		tags.add("enemy")
		_shootTimerStart = 150

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
		if (name == "sun enemy") {
			frames = [
				SpriteEntity[4, 12, 2],
				SpriteEntity[5, 12, 2]
			]

			tileWidth = 2
			tileHeight = 2
		}
		if (name == "baton enemy") {
			frames = [
				SpriteEntity[6, 12, 2],
				SpriteEntity[7, 12, 2]
			]

			tileWidth = 2
			tileHeight = 2
		}
		if (name == "saucer enemy") {
			frames = [
				SpriteEntity[4, 12],
				SpriteEntity[8, 18],
				SpriteEntity[10, 18],
				SpriteEntity[12, 18]
			]

			tileWidth = 2
			tileHeight = 1
		}
		if (name == "sandwich enemy") {
			frames = [
				SpriteEntity[4, 13],
				SpriteEntity[8, 19],
				SpriteEntity[10, 19]
			]

			tileWidth = 2
			tileHeight = 1
		}
		if (name == "green enemy") {
			frames = [
				SpriteEntity[3, 6, 2],
				SpriteEntity[7, 10, 2]
			]

			tileWidth = 2
			tileHeight = 2
		}
		if (name == "grey disk enemy") {
			frames = [
				SpriteEntity[4, 5, 2],
				SpriteEntity[6, 8, 2],
				SpriteEntity[7, 8, 2],
				SpriteEntity[7, 9, 2]
			]

			tileWidth = 2
			tileHeight = 2
		}
		_t = 0
		_shootTimer = _shootTimerStart
	}

	update() {

		// Move up and down on the screen.
		// TODO: Figure out the correct pattern.
		if (name == "spider enemy") {
			_t = _t + 0.06
			velocity.y = _t.sin * 1
			velocity.x = _t.cos * 1.8
		} else if (name == "slicer enemy") {
			_t = _t + 0.02
			velocity.y = _t.sin * 1
			velocity.x = _t.cos * 1.6
		} else if (name == "sun enemy") {
			_t = _t + 0.07
			velocity.y = _t.sin * 1
			velocity.x = _t.cos * 1.6
		} else if (name == "baton enemy") {
			_t = _t + 0.07
			velocity.y = 0
			velocity.x = _t.sin * 3
		} else if (name == "saucer enemy") {
			_t = _t + 0.08
			velocity.y = _t.cos * 4
			velocity.x = _t.sin * -1.2
		} else if (name == "sandwich enemy") {
			_t = _t + 0.05
			velocity.y = _t.cos * 2
			velocity.x = _t.sin * -2
		} else if (name == "green enemy") {
			_t = _t + 0.08
			velocity.y = 0
			velocity.x = _t.sin * 3
		} else if (name == "grey disk enemy") {
			_t = _t + 0.1
			velocity.y = 0
			velocity.x = _t.sin * 4
		}

		if (_t > 10000) {
			_t = 0
		}

		if (!_player) {
			_player = parent["player"]
		} else {
			flip = (_player.centerX > centerX) ? 0 : 1
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
