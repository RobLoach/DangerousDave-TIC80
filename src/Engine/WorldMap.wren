
class WorldMap {
	construct new(worldX, worldY, width, height) {
		_worldx = worldX
		_worldy = worldY
		_width = width * 2
		_height = height * 2
		_colorkey = 1
		_scale = 1
		_daveStartX = -1
		_daveStartY = -1

		_remap = Fn.new { |tileIndex, x, y|
			var tileType = _tileTypes[tileIndex]
			if (tileType == "dave") {
				if (_daveStartX == -1) {
					_daveStartX = x
					_daveStartY = y
				}
				return 0
			}
		}

		_tileTypes = {
			getIndex(14, 10): "blue gem",
			getIndex(15, 10): "blue gem",
			getIndex(14, 11): "blue gem",
			getIndex(15, 11): "blue gem",
			getIndex(10, 12): "dave",
			getIndex(11, 12): "dave",
			getIndex(10, 13): "dave",
			getIndex(11, 13): "dave"
		}
	}

	daveStartX {_daveStartX}
	daveStartY {_daveStartY}

	getIndex(x, y) {
		return x + 16 * y
	}

	width {_width}
	height{_height}

	draw(x, y) {
		TIC.map(_worldx, _worldy, _width, _height, -x, -y, _colorkey, _scale, _remap)
	}
}