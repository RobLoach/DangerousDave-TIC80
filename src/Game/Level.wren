import "../Engine/Entity/MapEntity" for MapEntity
import "../Engine/Entity/SpriteEntity" for SpriteEntity

import "BlueGem"
import "Player"

class Level is MapEntity {
	construct new (manager) {
		super(0, 0, 38, 20)

		_tileTypes = {
			SpriteEntity[2, 0]: "wall", // Dirt Dart
			SpriteEntity[3, 0]: "wall",
			SpriteEntity[2, 1]: "wall",
			SpriteEntity[3, 1]: "wall",
			SpriteEntity[6, 4]: "wall", // Dirt Greyish
			SpriteEntity[7, 4]: "wall",
			SpriteEntity[6, 5]: "wall",
			SpriteEntity[7, 5]: "wall",
			SpriteEntity[2, 4]: "wall", // Red Blick
			SpriteEntity[3, 4]: "wall",
			SpriteEntity[2, 5]: "wall",
			SpriteEntity[3, 5]: "wall",
			SpriteEntity[0, 4]: "wall", // Pipe down
			SpriteEntity[1, 4]: "wall",
			SpriteEntity[0, 5]: "wall",
			SpriteEntity[1, 5]: "wall",
			SpriteEntity[14, 2]: "wall", // Pipe Right
			SpriteEntity[15, 2]: "wall",
			SpriteEntity[14, 3]: "wall",
			SpriteEntity[15, 3]: "wall",
			SpriteEntity[14, 10]: "blue gem",
			SpriteEntity[15, 10]: "blue gem body",
			SpriteEntity[14, 11]: "blue gem body",
			SpriteEntity[15, 11]: "blue gem body",
			SpriteEntity[10, 12]: "player",
			SpriteEntity[11, 12]: "player body",
			SpriteEntity[10, 13]: "player body",
			SpriteEntity[11, 13]: "player body"
		}

		for (x in 0...mapWidth) {
			for (y in 0...mapHeight) {
				var currentTile = this[x, y]
				var tile = _tileTypes[currentTile]
				var entity = null
				if (tile) {
					if (tile == "blue gem") {
						entity = BlueGem.new(currentTile, manager)
					} else if (tile == "player") {
						entity = Player.new(currentTile, this)
					} else if (tile.contains("body")) {
						this[x,y] = 0
					}
				}

				if (entity) {
					this[x,y] = 0
					entity.x = x * 8
					entity.y = y * 8
					manager.add(entity)
				}
			}
		}
	}

	tileTypes{_tileTypes}
}
