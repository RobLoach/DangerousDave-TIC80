import "../Engine/Entity/SpriteEntity"

class Logo is SpriteEntity {
	construct new(manager) {
		super(SpriteEntity[0, 13, 2], 14, 6)
		name = "logo"
		_manager = manager
		_t = 0
	}

	update() {
		// Move up and down on the screen.
		_t = _t + 0.07
		y = _t.sin * 3 - 8
		if (_t > 10000) {
			_t = 0
		}

		// Move on when the player hits a button.
		if (TIC.btnp(4) || TIC.btnp(5)) {
			parent["level"].complete = true
		}

		super()
	}
}
