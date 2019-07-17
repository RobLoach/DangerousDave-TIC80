import "../Engine/Entity/SpriteEntity"
import "../Engine/Entity/AnimationEntity"
import "../Engine/Engine"

class Death is AnimationEntity {
	construct new(tile, deathName) {
		super([tile])

		name = deathName
		_state = "active"

		if (name == "fire death") {
			frames = [
				tile,
				SpriteEntity[0, 10, 2],
				SpriteEntity[1, 10, 2],
				SpriteEntity[2, 10, 2]
			]
			animationSpeed = 5
			currentFrame = Engine.random(frames.count - 1)
		}

		if (name == "tentacle death") {
			frames = [
				tile,
				SpriteEntity[0, 11, 2],
				SpriteEntity[1, 11, 2],
				SpriteEntity[2, 11, 2]
			]
			currentFrame = Engine.random(frames.count - 1)
			animationSpeed = 7
		}

		if (name == "water death") {
			frames = [
				tile,
				SpriteEntity[5, 3, 2],
				SpriteEntity[6, 3, 2],
				SpriteEntity[7, 3, 2],
				SpriteEntity[0, 4, 2]
			]
			currentFrame = Engine.random(frames.count - 1)
			animationSpeed = 6
		}

		tileWidth = 2
		tileHeight = 2
	}

	state{_state}
	state=(v){_state=v}

	update() {
		if (_state == "dying") {
			super()
			return
		}

		if (!_player) {
			_player = parent["player"]
		} else if (collisionRect(_player.boundingBox())) {
			// TODO: Animated death of the player.
			_player.die()
		}

		super()
	}
}
