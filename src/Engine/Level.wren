import "WorldMap"

class Level {
	construct new() {
		_player = Player.new()

		_map = WorldMap.new(0, 0, 18, 10)


		setup()
		reset()
	}

	setup() {
		_startX = 2
		_startY = 8
	}

	reset() {
		_player.x = _startX * 8 * 2
		_player.y = _startY * 8 * 2
	}

	draw() {


		var CameraX = _player.x - 10 * 8
		var CameraY = _player.y - 8 * 8


		_map.draw(CameraX, CameraY)
		_player.draw(CameraX, CameraY)
	}

	update() {
		_player.update()
	}
}