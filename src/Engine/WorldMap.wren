
class WorldMap {
	construct new(worldX, worldY, width, height) {
		_worldx = worldX
		_worldy = worldY
		_width = width * 2
		_height = height * 2
		_colorkey = 1
		_scale = 1

		_remap = Fn.new { |tile_index, mi, mj|
			TIC.trace(tile_index)
		}
	}

	draw(x, y) {
		TIC.map(_worldx, _worldy, _width, _height, -x, -y, _colorkey, _scale, _remap)
	}
}