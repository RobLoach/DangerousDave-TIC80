import "SpriteEntity" for SpriteEntity

class MapEntity is SpriteEntity {
	construct new(worldMapCellX, worldMapCellY, worldMapCellWidth, worldMapCellHeight) {
		super()
		_worldMapCellX = worldMapCellX
		_worldMapCellY = worldMapCellY
		_worldMapCellWidth = worldMapCellWidth
		_worldMapCellHeight = worldMapCellHeight

		tags.add("MapEntity")

		_tilemapOriginal = []
		for (y in 0..._worldMapCellHeight) {
			for (x in 0..._worldMapCellWidth) {
				_tilemapOriginal.add(TIC.mget(_worldMapCellX + x, _worldMapCellY + y))
			}
		}
	}

	width{_worldMapCellWidth * 8 * scale}
	height{_worldMapCellHeight * 8 * scale}

	mapWidth{_worldMapCellWidth}
	mapHeight{_worldMapCellHeight}

	reset() {
		for (y in 0..._worldMapCellHeight) {
			for (x in 0..._worldMapCellWidth) {
				this[x,y] = _tilemapOriginal[x + _worldMapCellWidth * y]
			}
		}
	}

	[x, y] {
		return TIC.mget(_worldMapCellX + x, _worldMapCellY + y)
		//return _tilmapOriginal[x + _worldMapCellWidth * y]
	}

	[x, y]=(v) {
		TIC.mset(_worldMapCellX + x, _worldMapCellY + y, v)
		return v
	}

	draw(camera) {
		TIC.map(_worldMapCellX, _worldMapCellY, _worldMapCellWidth, _worldMapCellHeight, x - camera.x, y - camera.y, colorkey, scale)
	}
}
