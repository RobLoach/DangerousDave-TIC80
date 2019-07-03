import "../Engine/Entity/SpriteEntity"
import "../Engine/Entity/AnimationEntity"

class Death is AnimationEntity {
	construct new(tile, level, deathName) {
		super([tile])
		_player = null
		_level = level

		name = deathName

		if (name == "fire death") {
			frames = [
				tile,
				SpriteEntity[0, 10, 2],
				SpriteEntity[1, 10, 2],
				SpriteEntity[2, 10, 2]
			]
			animationSpeed = 5
		}

		if (name == "tentacle death") {
			frames = [
				tile,
				SpriteEntity[0, 11, 2],
				SpriteEntity[1, 11, 2],
				SpriteEntity[2, 11, 2]
			]
		}
		tileWidth = 2
		tileHeight = 2
	}

	update() {
		if (!_player) {
			_player = _level["player"]
		} else if (collisionRect(_player)) {
			// TODO: Kill the player.
			TIC.reset()
		}

		super()
	}
}
