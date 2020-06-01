import "../Engine/Entity/AnimationEntity"
import "../Engine/Entity/SpriteEntity"
import "../Engine/Math/Vector"
import "../Engine/Math/Rectangle"
import "Bullet"
import "Sound"

class Player is AnimationEntity {
	construct new(tile, level) {
		_level = level
		lives = 3
		_score = 0

		super()

		_animations = {
			"none": [
				SpriteEntity[0, 0]
			],
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
			],
			"climbing": [
				SpriteEntity[3, 8, 2],
				SpriteEntity[4, 8, 2],
				SpriteEntity[5, 8, 2]
			],
			"climbing-still": [
				SpriteEntity[3, 8, 2]
			],
			"dying": [
				SpriteEntity[3, 11, 2],
				SpriteEntity[4, 11, 2],
				SpriteEntity[5, 11, 2],
				SpriteEntity[6, 11, 2]
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

	lives{
		var pmemLives = TIC.pmem(255)
		if (pmemLives == null) {
			TIC.pmem(255, 3)
			return 3
		}
		return pmemLives
	}
	lives=(v){
		if (v<0) {
			v = 0
		} else if (v > 1000) {
			v = 1000
		}
		TIC.pmem(255, v)
	}
	score{_score}
	score=(v){_score=v}
	level{_level}

	state{_state}
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
				parent["level"].status = "complete"
			}
			Sound.walking()

			super()
			return
		}

		// Handle the Death state.
		if (_state == "dying") {
			_dieTimer = _dieTimer - 1
			if (_dieTimer <= 0) {
				if (lives == 0) {
					parent["level"].status = "gameover"
				} else {
					lives = lives - 1
					reset()
				}
			}
			if (_dieTimer <= 60) {
				frames = _animations["none"]
			}
			velocity.x = 0
			velocity.y = 0.1
			super()
			return
		}

		// Player movement
		var oldPosition = position

		// Move vertically.
		var gravity = 0.025
		if (_state == "jetpack" || _state == "climbing") {
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

		// See if we can enable Climbing.
		if (_state == "jumping" || _state == "falling" || _state == "idle" || _state == "walking") {
			if (TIC.btn(0)) {
				if (_level.tileCollision(boundingBox(), "tree")) {
					_state = "climbing"
					frames=_animations["climbing"]
				}
			}
		}

		// Climbing Physics
		if (_state == "climbing") {
			frames = _animations["climbing"]
			if (TIC.btn(0)) {
				y = y - 1
			} else if (TIC.btn(1)) {
				y = y + 1
			} else if (TIC.btn(2) || TIC.btn(3)) {
				// Nothing
			} else {
				// Not moving, so climbing still
				frames = _animations["climbing-still"]
			}

			// Climbing has no gravity.
			velocity.y = 0

			// Check if we are no longer on a tree.
			if (!_level.tileCollision(boundingBox(), "tree")) {
				_state = "falling"
				frames = _animations["falling"]
				velocity.y = 0.375 // Gravity * 15
			}

			// Allow Jumping off
			if (TIC.btnp(5) || TIC.btnp(6)) {
				_state = "jumping"
				frames = _animations["jumping"]
				velocity.y = -0.9
			}
		} else if (_state == "jumping" || _state == "falling") {
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
			// Allow Jumping?
			if (TIC.btnp(0) || TIC.btnp(5) || TIC.btnp(6)) {
				// Don't allow jumping when on top of the level
				if (top > _level.top) {
					_state = "jumping"
					frames = _animations["jumping"]
					velocity.y = -0.9
				}
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

		// Keep the player in the level bounds.
		if (top > _level.bottom + height) {
			bottom = _level.top - height
			return
		}
		if (bottom < _level.top) {
			bottom = _level.top
			return
		}
		if (left < _level.left) {
			left = _level.left
		} else if (right > _level.right) {
			right = _level.right
		}

		// Enable the sound effects.
		if (_state == "walking") {
			Sound.walking()
		}
		if (_state == "jumping") {
			Sound.jumping(velocity.y)
		}
		if (_state == "falling") {
			Sound.falling(velocity.y)
		}
		if (_state == "jetpack") {
			Sound.jetpack()
		}

		// Apply the desired y change.
		y = y + velocity.y

		// Test allowing the vertical move.
		var xPadding = 4
		var collide = boundingBox()
		var collisionRect = _level.tileCollision(collide, "wall")
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
				velocity.y = gravity * 7
			}
			frames = _animations["falling"]
			_state = "falling"
		}

		// Move horizontally.
		var horizontalSpeed = 1
		if (TIC.btn(3)) {
			x = x + horizontalSpeed
			flip = 0
			if (_state == "idle" || _state == "walking") {
				_state = "walking"
				frames = _animations["walking"]
			}
		} else if (TIC.btn(2)) {
			x = x - horizontalSpeed
			flip = 1
			if (_state == "idle" || _state == "walking") {
				frames = _animations["walking"]
				_state = "walking"
			}
		}

		// Test to make sure it's possible.
		collide = boundingBox()
		collisionRect = _level.tileCollision(collide, "wall")
		if (collisionRect) {
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
			Sound.shoot()
		}
	}

	die() {
		if (_state != "dying") {
			Sound.explode()
			_dieTimer = 180
			_state = "dying"
			frames = _animations["dying"]
			animationSpeed = 10
		}
	}

	reset() {
		_state = "idle"
		position = _level.start
		animationSpeed = 5
	}
}
