import "../Engine/Entity/SpriteEntity"

class Door is SpriteEntity {
	construct new(tile, manager) {
		super(tile, 2, 2)
		name = "door"
		_manager = manager
		_player = null
		_trophy = null

		_sound = 2
		_channel = 3
	}

	update() {
		if (!_player) {
			_player = _manager["player"]
		}
		if (!_trophy) {
			_trophy = _manager["TrophyItem"]
		} else if (_player) {
			if (!_trophy.active && collisionRect(_player.boundingBox())) {
				parent["level"].status = "complete"

				TIC.sfx(_sound, 3 * 12, -1, 3)
			}
		}
	}
}
