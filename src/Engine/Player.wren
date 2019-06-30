
class Player {
	spritePosition(x, y) {
		return x * 2 + 32 * y
	}

	construct new() {
		_idle = Animation.new([
			spritePosition(1, 8),
			spritePosition(1, 8),
			spritePosition(1, 8),
			spritePosition(5, 6)
		], 50, 2, 2)
		_walking = Animation.new([
			spritePosition(0, 8),
			spritePosition(1, 8),
			spritePosition(2, 8),
			spritePosition(1, 8)
		], 8, 2, 2)
		_currentAnimation = _idle
		_x = 50
		_y = 20
		_movingLeft = 0
	}

	x { _x }
	y { _y }
	x=(value) {_x = value}
	y=(value) {_y = value }

	update() {
		_currentAnimation.update()

		_moving = false
		if (TIC.btn(0) ){
			_y = _y - 1
			_moving = true
		}
		if (TIC.btn(1) ) {
					_y = _y + 1
					_moving = true
				}
		if (TIC.btn(2) ){
					_x = _x - 1
					_moving = true
					_movingLeft = 1
				}
		if (TIC.btn(3) ) {
					_x = _x + 1
					_moving = true
					_movingLeft = 0
				}

		if (_moving) {
			_currentAnimation = _walking
		} else {
			_currentAnimation = _idle
		}
	}
	draw(cameraX, cameraY) {
		_currentAnimation.draw(x - cameraX, y - cameraY, _movingLeft)
	}
}
