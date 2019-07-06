import "../Engine/Entity/MapEntity" for MapEntity
import "../Engine/Entity/SpriteEntity" for SpriteEntity
import "../Engine/Math/Vector" for Vector

import "Gem"
import "Player"
import "Door"
import "Logo"
import "Death"
import "Enemy"

class Level is MapEntity {

	construct new (manager, mapX, mapY, mapWidth, mapHeight) {
		super(mapX, mapY, mapWidth, mapHeight)
		name = "level"
		_complete = false
		_died = false

		_tileTypes = {
			SpriteEntity[2, 0]: "wall", // Dirt Dark
			SpriteEntity[3, 0]: "wall",
			SpriteEntity[2, 1]: "wall",
			SpriteEntity[3, 1]: "wall",
			SpriteEntity[0, 4]: "wall", // Pipe down
			SpriteEntity[1, 4]: "wall",
			SpriteEntity[0, 5]: "wall",
			SpriteEntity[1, 5]: "wall",
			SpriteEntity[2, 4]: "wall", // Red Blick
			SpriteEntity[3, 4]: "wall",
			SpriteEntity[2, 5]: "wall",
			SpriteEntity[3, 5]: "wall",
			SpriteEntity[4, 4]: "wall", // Dirt Greyish
			SpriteEntity[5, 4]: "wall",
			SpriteEntity[4, 5]: "wall",
			SpriteEntity[5, 5]: "wall",
			SpriteEntity[6, 4]: "wall", // Purple Pipe Up/Down
			SpriteEntity[7, 4]: "wall",
			SpriteEntity[6, 5]: "wall",
			SpriteEntity[7, 5]: "wall",
			SpriteEntity[8, 4]: "wall", // Purple Pipe Left/Right
			SpriteEntity[9, 4]: "wall",
			//SpriteEntity[6, 5]: "wall", // Purple Pipe Left/Right bottom
			//SpriteEntity[7, 5]: "wall",
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
			SpriteEntity[6, 2]: "wall", // Blue Wall Thing?
			SpriteEntity[6, 3]: "wall",
			SpriteEntity[7, 2]: "wall",
			SpriteEntity[7, 3]: "wall",
			SpriteEntity[8, 2]: "gun gem", // Gun
			SpriteEntity[8, 3]: "body",
			SpriteEntity[9, 2]: "body",
			SpriteEntity[9, 3]: "body",
			SpriteEntity[10, 2]: "wall", // Wall bottom left
			//SpriteEntity[10, 3]: "wall",
			SpriteEntity[11, 2]: "wall",
			SpriteEntity[11, 3]: "wall",
			SpriteEntity[12, 2]: "wall", // Wall top left
			SpriteEntity[12, 3]: "wall",
			SpriteEntity[13, 2]: "wall",
			//SpriteEntity[13, 3]: "wall",
			SpriteEntity[14, 2]: "wall", // Pipe Right
			SpriteEntity[14, 3]: "wall",
			SpriteEntity[15, 2]: "wall",
			SpriteEntity[15, 3]: "wall",
			SpriteEntity[0, 10]: "purple gem", // Purple Circle
			SpriteEntity[0, 11]: "body",
			SpriteEntity[1, 10]: "body",
			SpriteEntity[1, 11]: "body",
			SpriteEntity[2, 10]: "red gem", // Red Gem
			SpriteEntity[2, 11]: "body",
			SpriteEntity[3, 10]: "body",
			SpriteEntity[3, 11]: "body",
			SpriteEntity[4, 10]: "crown gem", // Crown
			SpriteEntity[4, 11]: "body",
			SpriteEntity[5, 10]: "body",
			SpriteEntity[5, 11]: "body",
			SpriteEntity[6, 10]: "PlayerAuto", // Automated Player
			SpriteEntity[6, 11]: "body",
			SpriteEntity[7, 10]: "body",
			SpriteEntity[7, 11]: "body",
			SpriteEntity[12, 0]: "fire death", // Fire
			SpriteEntity[13, 0]: "body",
			SpriteEntity[12, 1]: "body",
			SpriteEntity[13, 1]: "body",
			//SpriteEntity[0, 2]: "wall", // Bottom Right Wall
			SpriteEntity[1, 2]: "wall",
			SpriteEntity[0, 3]: "wall",
			SpriteEntity[1, 3]: "wall",
			SpriteEntity[2, 2]: "tentacle death", // Purple tentacles?
			SpriteEntity[2, 3]: "body",
			SpriteEntity[3, 2]: "body",
			SpriteEntity[3, 3]: "body",
			SpriteEntity[8, 6]: "water death", // Water
			SpriteEntity[8, 7]: "body",
			SpriteEntity[9, 6]: "body",
			SpriteEntity[9, 7]: "body",
			SpriteEntity[4, 0]: "door", // Door
			SpriteEntity[5, 0]: "body",
			SpriteEntity[4, 1]: "body",
			SpriteEntity[5, 1]: "body",
			SpriteEntity[6, 0]: "wall", // Panel
			SpriteEntity[7, 0]: "wall",
			SpriteEntity[6, 1]: "wall",
			SpriteEntity[7, 1]: "wall",
			SpriteEntity[8, 0]: "jetpack gem", // Jetpack
			SpriteEntity[9, 0]: "body",
			SpriteEntity[8, 1]: "body",
			SpriteEntity[9, 1]: "body",
			SpriteEntity[10, 0]: "wall", // Blue Wall
			SpriteEntity[11, 0]: "wall",
			SpriteEntity[10, 1]: "wall",
			SpriteEntity[11, 1]: "wall",
			SpriteEntity[14, 0]: "wall", // Top Right Wall
			SpriteEntity[15, 0]: "wall",
			//SpriteEntity[14, 1]: "wall",
			SpriteEntity[15, 1]: "wall",
			SpriteEntity[0,12]: "logo", // Logo
			SpriteEntity[0,13]: "body",
			SpriteEntity[1,12]: "body",
			SpriteEntity[1,13]: "body",
			SpriteEntity[2,12]: "spider enemy", // Spider
			SpriteEntity[12, 4]: "ring gem", // Ring
			SpriteEntity[13, 4]: "body",
			SpriteEntity[12, 5]: "body",
			SpriteEntity[13, 5]: "body",
			SpriteEntity[14, 4]: "scepter gem", // Scepter
			SpriteEntity[15, 4]: "body",
			SpriteEntity[14, 5]: "body",
			SpriteEntity[15, 5]: "body"
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
						entity = Death.new(currentTile, tile)
					} else if (tile.endsWith("enemy")) {
						entity = Enemy.new(currentTile, tile)
					} else if (tile == "door") {
						entity = Door.new(currentTile, manager)
					} else if (tile == "player") {
						entity = Player.new(currentTile, this)
						_start = Vector.new(x * 8, y * 8)
					} else if (tile == "PlayerAuto") {
						entity = Player.new(currentTile, this)
						_start = Vector.new(x * 8, y * 8)
						entity.automated = true
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

	start{_start}
	start=(v){_start=v}

	complete{_complete}
	complete=(v){
		_complete = v
		if (v) {
			reset()
		}
	}

	tileTypes{_tileTypes}
}
