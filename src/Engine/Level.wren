import "WorldMap"

class Level {
	construct new() {
		_player = Player.new()

		_map = WorldMap.new(0, 0, 19, 10)


		setup()
		reset()
	}

	setup() {
		_map.draw(0, 0)
		_startX = _map.daveStartX * 8
		_startY = _map.daveStartY * 8

		TIC.trace(_startX)
		TIC.trace(_startY)
	}

	reset() {
		_player.x = _startX
		_player.y = _startY
	}

	draw() {


		var CameraX = _player.x - 10 * 8
		var CameraY = _player.y - 8 * 8

		if (CameraX < 0) {
			CameraX = 0
		}
		if (CameraY < 0) {
			CameraY = 0
		}
		if (CameraX + 240 > _map.width * 8) {
			CameraX = _map.width * 8 - 240
		}
		if (CameraY + 136 > _map.height * 8) {
			CameraY = _map.height * 8 - 136
		}


		_map.draw(CameraX, CameraY)
		_player.draw(CameraX, CameraY)
	}

	update() {
		_player.update()
	}
}