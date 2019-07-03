import "../Engine/Entity/MapEntity" for MapEntity
import "../Engine/Entity/SpriteEntity" for SpriteEntity

import "Gem"
import "Player"
import "Door"
import "Logo"
import "Death"

class Level is MapEntity {

	construct new (manager, mapX, mapY, mapWidth, mapHeight) {
		super(mapX, mapY, mapWidth, mapHeight)
		name = "level"

		_tileTypes = {
			SpriteEntity[2, 0]: "wall", // Dirt Dark
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
			SpriteEntity[14, 8]: "blue gem", // Blue Gem
			SpriteEntity[15, 8]: "body",
			SpriteEntity[14, 9]: "body",
			SpriteEntity[15, 9]: "body",
			SpriteEntity[10, 10]: "player", // player
			SpriteEntity[11, 10]: "body",
			SpriteEntity[10, 11]: "body",
			SpriteEntity[11, 11]: "body",
			SpriteEntity[4, 2]: "trophy gem", // Trophy
			SpriteEntity[4, 3]: "body",
			SpriteEntity[5, 2]: "body",
			SpriteEntity[5, 3]: "body",
			SpriteEntity[0, 10]: "purple gem", // Purple Circle
			SpriteEntity[0, 11]: "body",
			SpriteEntity[1, 10]: "body",
			SpriteEntity[1, 11]: "body",
			SpriteEntity[2, 10]: "red gem", // Red Gem
			SpriteEntity[2, 11]: "body",
			SpriteEntity[3, 10]: "body",
			SpriteEntity[3, 11]: "body",
			SpriteEntity[2, 10]: "crown gem", // Crown
			SpriteEntity[2, 11]: "body",
			SpriteEntity[3, 10]: "body",
			SpriteEntity[3, 11]: "body",
			SpriteEntity[12, 0]: "fire death", // Fire
			SpriteEntity[13, 0]: "body",
			SpriteEntity[12, 1]: "body",
			SpriteEntity[13, 1]: "body",
			SpriteEntity[2, 2]: "tentacle death", // Purple tentacles?
			SpriteEntity[2, 3]: "body",
			SpriteEntity[3, 2]: "body",
			SpriteEntity[3, 3]: "body",
			SpriteEntity[4, 0]: "door", // Door
			SpriteEntity[5, 0]: "body",
			SpriteEntity[4, 1]: "body",
			SpriteEntity[5, 1]: "body",
			SpriteEntity[0,12]: "logo", // Logo
			SpriteEntity[0,13]: "body",
			SpriteEntity[1,12]: "body",
			SpriteEntity[1,13]: "body"
		}

		for (x in 0...mapWidth) {
			for (y in 0...mapHeight) {
				var currentTile = this[x, y]
				var tile = _tileTypes[currentTile]
				var entity = null
				if (tile) {
					if (tile.endsWith("gem")) {
						entity = Gem.new(currentTile, manager, tile)
					} else if (tile.endsWith("death")) {
						entity = Death.new(currentTile, manager, tile)
					} else if (tile == "door") {
						entity = Door.new(currentTile, manager)
					} else if (tile == "player") {
						entity = Player.new(currentTile, this)
					} else if (tile == "logo") {
						entity = Logo.new(manager)
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
