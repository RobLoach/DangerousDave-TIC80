import "../Engine/Entity/SpriteEntity"

class Door is SpriteEntity {
	construct new(tile, manager) {
		super(tile, 2, 2)
		name = "door"
		_manager = manager
		_player = null
		_trophy = null
	}

	update() {
		if (!_player) {
			_player = _manager["player"]
		}
		if (!_trophy) {
			_trophy = _manager["trophy gem"]
		} else if (_player) {
			if (!_trophy.active && collisionRect(_player.boundingBox())) {
				parent["level"].status = "complete"
			}
		}
	}
}
