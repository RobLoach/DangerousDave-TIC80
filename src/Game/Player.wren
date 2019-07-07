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
		_onground = true
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
			frames = _walking
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

		velocity.y = velocity.y + gravity
		if (velocity.y > 2) {
			velocity.y = 2
		}

		// Jump
		if (_onground) {
			if (TIC.btnp(0) || TIC.btnp(5) || TIC.btnp(6)) {
				_onground = false
				frames = _animations["jumping"]
				velocity.y = -0.9
			}
		}

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
				_onground = true
				velocity.y = 0
				frames = _animations["idle"]
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
			frames = _animations["falling"]
			_onground = false
		}

		// Move horizontally.
		var horizontalSpeed = 1
		if (TIC.btn(2)) {
			x = x - horizontalSpeed
			flip = 1
			if (_onground) {
				frames = _animations["walking"]
			}
		}
		if (TIC.btn(3)) {
			x = x + horizontalSpeed
			flip = 0
			if (_onground) {
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
		return Rectangle.new(x + xPadding, y, width - xPadding * 2,height)
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
