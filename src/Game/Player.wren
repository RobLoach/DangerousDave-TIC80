import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/SpriteEntity"
import "../Engine/Math/Vector"
import "../Engine/Math/Rectangle"

class Player is AnimationEntity {
	construct new(tile, level) {
		_level = level

		super()
		_idle = [
			SpriteEntity[1, 8, 2],
			SpriteEntity[1, 8, 2],
			SpriteEntity[1, 8, 2]
		]

		_walking = [
			SpriteEntity[0, 8, 2],
			SpriteEntity[1, 8, 2],
			SpriteEntity[2, 8, 2],
			SpriteEntity[1, 8, 2]
		]

		_jumping = [
			SpriteEntity[3, 9, 2]
		]

		_falling = [
			SpriteEntity[0, 8, 2]
		]

		animationSpeed = 5
		frames = _idle
		tileWidth = 2
		tileHeight = 2
		tags.add("player")
		_state = "standing"
		currentFrame=frames[0]

		_onground = true

	}

	update() {
		var oldPosition = position

		// Move vertically.
		/*if (TIC.btn(0)) {
			y = y - 1
		}
		if (TIC.btn(1)) {
			y = y + 1
		}*/

		var gravity = 0.025

		velocity.y = velocity.y + gravity
		if (velocity.y > 2) {
			velocity.y = 2
		}

		// Jump
		if (_onground) {
			if (TIC.btn(0)) {
				_onground = false
				frames = _jumping
				velocity.y = -0.9
			}
		}

		// Apply the desired y change.
		y = y + velocity.y

		// Test allowing the vertical move.
		var collide = Rectangle.new(x, y, width,height)
		var collisionRect = tilemap_collision(collide)
		if(collisionRect) {
			y = oldPosition.y
			if (y < collisionRect.y) {
				bottom = collisionRect.top
				_onground = true
				velocity.y = 0
				frames = _idle
			} else {
				top = collisionRect.bottom
				velocity.y = 0
			}
		}
		if (velocity.y > 0) {
			// If the player was on the ground, and fell off a ledge.
			if (_onground) {
				velocity.y = gravity * 15
			}
			frames = _falling
			_onground = false
		}

		// Move horizontally.
		var horizontalSpeed = 1
		if (TIC.btn(2)) {
			x = x - horizontalSpeed
			flip = 1
			if (_onground) {
				frames = _walking
			}
		}
		if (TIC.btn(3)) {
			x = x + horizontalSpeed
			flip = 0
			if (_onground) {
				frames = _walking
			}
		}

		// Test to make sure it's possible.
		collide = Rectangle.new(x, y, width,height)
		collisionRect = tilemap_collision(collide)
		if(collisionRect) {
			x = oldPosition.x

			if (x < collisionRect.x) {
				right = collisionRect.left
			} else {
				left = collisionRect.right
			}
		}

		super()
	}

	tilemap_collision(rect) {
		for(i in 0..._level.mapWidth) {
			for(j in 0..._level.mapHeight) {
				var t = _level[i, j]
				if(_level.tileTypes[t] == "wall") {
					if (rect.collisionRect(i * 8, j * 8, 8, 8)) {
						return Rectangle.new(i*8,j*8, 8, 8)
					}
				}
			}
		}
	}
}
