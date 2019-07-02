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

	mapWidth{_worldMapCellWidth}
	mapHeight{_worldMapCellHeight}

	[x, y] {
		return TIC.mget(_worldMapCellX + x, _worldMapCellY + y)
	}

	[x, y]=(v) {
		TIC.mset(_worldMapCellX + x, _worldMapCellY + y, v)
		return v
	}

	draw(camera) {
		TIC.map(_worldMapCellX, _worldMapCellY, _worldMapCellWidth, _worldMapCellHeight, x - camera.x, y - camera.y, colorkey, scale, _remap)
	}

	remap(tileIndex, x, y) {
		// Nothing
	}
}
