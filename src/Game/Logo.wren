import "../Engine/Entity/SpriteEntity"

class Logo is SpriteEntity {
	construct new(manager) {
		super(SpriteEntity[0, 13, 2], 14, 6)
		name = "logo"
		_manager = manager
		_t = 0
		_done = false
	}

	done{_done}

	update() {
		_t = _t + 0.07
		if (_t > 10000) {
			_t = 0
		}
		y = _t.sin * 3 - 8

		if (TIC.btn(4) || TIC.btn(5)) {
			_done = true
		}
		super()
	}
}
