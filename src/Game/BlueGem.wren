import "../Engine/Entity/SpriteEntity"

class BlueGem is SpriteEntity {
	construct new(tile, level) {
		super(tile, 2, 2)
		_active = true
		_player = null
		_level = level
	}
	construct new() {
		super(SpriteEntity[7,5,2], 2, 2)
	}

	update() {
		if (!_player) {
			_player = _level.getEntity("player")
		}

		if (collisionRect(_player)) {
			_active = false
		}
	}

	draw(camera) {
		if (_active) {
			super(camera)
		}
	}
}
