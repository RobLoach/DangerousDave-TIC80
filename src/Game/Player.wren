import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/SpriteEntity"
import "../Engine/Math/Vector"
import "../Engine/Math/Rectangle"
import "Bullet"

class Player is AnimationEntity {
	construct new(tile, level) {
		_level = level

		super()

		_animations = {
			"idle": [
				SpriteEntity[1, 8, 2],
				SpriteEntity[1, 8, 2],
				SpriteEntity[1, 8, 2]
			],
			"walking":[
				SpriteEntity[0, 8, 2],
				SpriteEntity[1, 8, 2],
				SpriteEntity[2, 8, 2],
				SpriteEntity[1, 8, 2]
			],
			"jumping":[
				SpriteEntity[3, 9, 2]
			],
			"jetpack": [
				SpriteEntity[0, 9, 2],
				SpriteEntity[1, 9, 2],
				SpriteEntity[2, 9, 2]
			],
			"falling": [
				SpriteEntity[0, 8, 2]
			]
		}

		animationSpeed = 5
		frames = _animations["idle"]
		tileWidth = 2
		tileHeight = 2
		name = "player"
		_state = "idle"
		currentFrame=frames[0]
		_automated = false

		_jetpack = 0
		_ammo = 0
		_reloadTimer = 0
		_reloadTimerStart = 60 * 1
	}

	level{_level}

	ammo{_ammo}
	ammo=(v){_ammo=v}
	jetpack{_jetpack}
	jetpack=(v){_jetpack=v}

	automated{_automated}
	automated=(v){
		_automated=v
		if (v) {
			frames = _animations["walking"]
			_state = "walking"
			velocity.x = 1
		}
	}

	update() {
		if (_automated) {
			if (right >= 240) {
				parent["level"].complete = true
			}
			super()
			return
		}

		// Player movement
		var oldPosition = position

		// Move vertically.
		var gravity = 0.025
		if (_state == "jetpack") {
			gravity = 0
		}

		velocity.y = velocity.y + gravity
		if (velocity.y > 2) {
			velocity.y = 2
		}

		// Jetpack
		if (_state == "jetpack") {
			// Move vertically
			if (TIC.btn(0)) {
				y = y - 1
			}
			if (TIC.btn(1)) {
				y = y + 1
			}
		}

		// Jumping or Falling
		if (_state == "jumping" || _state == "falling") {
			if (TIC.btnp(0) || TIC.btnp(5) || TIC.btnp(6)) {
				// Can we engage the jetpack?
				if (_jetpack > 0) {
					_state = "jetpack"
					frames = _animations["jetpack"]
					velocity.y = 0
				}
			}
		// Idle or Walking
		} else if (_state == "idle" || _state == "walking") {
			// Allow Jumping
			if (TIC.btnp(0) || TIC.btnp(5) || TIC.btnp(6)) {
				_state = "jumping"
				frames = _animations["jumping"]
				velocity.y = -0.9
			}
		// Jetpack
		} else if (_state == "jetpack") {
			// Disengage the jetpack.
			if (TIC.btnp(5) || TIC.btnp(6)) {
				_state = "falling"
				frames = _animations["falling"]
			} else {
				// Use up some Jetpack fuel.
				_jetpack = _jetpack - 1
				if (_jetpack <= 0) {
					_state = "falling"
					frames = _animations["falling"]
					velocity.y = 0.375 // Gravity * 15
				}
			}
		}

		TIC.print(_jetpack.toString)

		// Apply the desired y change.
		y = y + velocity.y

		// Test allowing the vertical move.
		var xPadding = 4
		var collide = boundingBox()
		var collisionRect = tilemap_collision(collide)
		if(collisionRect) {
			y = oldPosition.y
			if (y < collisionRect.y) {
				bottom = collisionRect.top
				_state = "idle"
				velocity.y = 0
				frames = _animations["idle"]
			} else {
				top = collisionRect.bottom - 1
				velocity.y = 0
			}
		}
		if (velocity.y > 0) {
			// If the player was on the ground, and fell off a ledge.
			if (_state == "idle" || _state == "walking") {
				velocity.y = gravity * 15
			}
			frames = _animations["falling"]
			_state = "falling"
		}

		// Move horizontally.
		var horizontalSpeed = 1
		if (TIC.btn(2)) {
			x = x - horizontalSpeed
			flip = 1
			if (_state == "idle" || _state == "walking") {
				frames = _animations["walking"]
				_state = "walking"
			}
		}
		if (TIC.btn(3)) {
			x = x + horizontalSpeed
			flip = 0
			if (_state == "idle" || _state == "walking") {
				_state = "walking"
				frames = _animations["walking"]
			}
		}

		// Test to make sure it's possible.
		collide = boundingBox()
		collisionRect = tilemap_collision(collide)
		if(collisionRect) {
			x = oldPosition.x

			if (x < collisionRect.x) {
				right = collisionRect.left + xPadding
			} else {
				left = collisionRect.right - xPadding
			}
		}

		// Shoot
		if (_reloadTimer > 0) {
			_reloadTimer = _reloadTimer - 1
		}
		if (TIC.btnp(4) || TIC.btnp(7)) {
			shoot()
		}

		super()
	}

	boundingBox() {
		var xPadding = 4
		var yTopPadding = 1
		return Rectangle.new(x + xPadding, y + yTopPadding, width - xPadding * 2, height - yTopPadding)
	}

	shoot() {
		if (_reloadTimer <= 0 && _ammo > 0) {
			_ammo = _ammo - 1
			var bullet = Bullet.new(this, "player")
			parent.add(bullet)
			_reloadTimer = _reloadTimerStart
		}
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

	reset() {
		position = _level.start
	}
}
