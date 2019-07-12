import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/SpriteEntity"
import "../Engine/Math/Rectangle"
import "Sound"

class Bullet is AnimationEntity {
	construct new(source, bulletType) {
		super()

		// Bullet index.
		if (__index == null) {
			__index = 0
		}
		__index = __index + 1

		// Set up the initial properties.
		name = "bullet" + __index.toString
		tags.add("bullet")
		velocity.x = 2.1
		_bulletType = bulletType

		// Flip the bullet direction if needed.
		if (source.flip == 1) {
			velocity.x = -velocity.x
			flip = 1
		}

		_life = 100

		// Figure out the bullet type.
		if (_bulletType == "player") {
			frames = [
				SpriteEntity[7, 15, 2]
			]
			tileWidth = 1
			tileHeight = 1
		}

		if (_bulletType == "enemy") {
			frames = [
				SpriteEntity[14, 31]
			]
			tileWidth = 2
			tileHeight = 1
		}

		// Position
		center = source.center
	}

	update() {
		_life = _life - 1

		if (_life <= 0) {
			return delete()
		}

		var collide = Rectangle.new(x, y, width, height / 2)
		if (!_level) {
			_level = parent["level"]
		} else if (_level.tileCollision(this, "wall")) {
			return delete()
		}

		if (_bulletType == "player") {
			var enemies = parent.getEntities("enemy")
			for (enemy in enemies) {
				if (enemy.collisionRect(collide)) {
					// TODO: Death animation
					enemy.delete()
					Sound.explode()
					return delete()
				}
			}
		}

		if (_bulletType == "enemy") {
			if (!_player) {
				_player = parent["player"]
			} else {
				if (_player.boundingBox().collisionRect(collide)) {
					// TODO: Death animation
					_player.die()
					Sound.explode()
					return delete()
				}
			}
		}
		super()
	}
}
