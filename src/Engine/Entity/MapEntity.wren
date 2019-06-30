import "SpriteEntity" for SpriteEntity

class MapEntity is SpriteEntity {
	construct new(worldMapCellX, worldMapCellY, worldMapCellWidth, worldMapCellHeight) {
		super()
		_worldMapCellX = worldMapCellX
		_worldMapCellY = worldMapCellY
		_worldMapCellWidth = worldMapCellWidth
		_worldMapCellHeight = worldMapCellHeight

		tags.add("MapEntity")

		_remap = Fn.new { |tileIndex, x, y|
			remap(tileIndex, x, y)
			/*var tileType = _tileTypes[tileIndex]
			if (tileType == "dave") {
				if (_daveStartX == -1) {
					_daveStartX = x
					_daveStartY = y
				}
				return 0
			}*/
		}
	}

	width{_worldMapCellWidth * 8 * scale}
	height{_worldMapCellHeight * 8 * scale}

	[x, y] {
		return mget(_worldMapCellX + x, _worldMapCellY + y)
	}

	draw(camera) {
		TIC.map(_worldMapCellX, _worldMapCellY, _worldMapCellWidth, _worldMapCellHeight, x - camera.x, y - camera.y, colorkey, scale, _remap)
	}

	remap(tileIndex, x, y) {
		// Nothing
	}
}
