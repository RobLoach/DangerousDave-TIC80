import "Entity" for Entity
import "../Math/Vector" for Vector

class SpriteEntity is Entity {
	construct new() {
		super()
		spriteEntityInit()
	}
	construct new(id) {
		super()
		spriteEntityInit()
		_spriteid = id
	}
	construct new(id, tileWidth, tileHeight) {
		super()
		spriteEntityInit()
		_spriteid = id
		_tileWidth = tileWidth
		_tileHeight = tileHeight
	}

	spriteEntityInit() {
		tags.add("SpriteEntity")
		_colorkey = 1
		_scale = 1
		_flip = 0
		_rotate = 0
		_tileWidth = 1
		_tileHeight = 1
		_spriteid = 0
	}

	/**
	 * Return the X/Y coordinates from the given sprite index.
	 */
	static [i] {
		return Vector.new(i % 16, i / 16)
	}

	/**
	 * Retrieve the index of the given sprite.
	 */
	static [x, y] {
		return x + 16 * y
	}

	/**
	 * Retrieve the index of the given sprite.
	 */
	static [x, y, tilesize] {
		return x * tilesize + 16 * tilesize * y
	}

	/**
	 * Retrieve the index of the given sprite.
	 */
	static [x, y, tileWidth, tileHeight] {
		return x * tileWidth + 16 * tileHeight * y
	}

	spriteId=(v){_spriteid=v}
	spriteId{_spriteid}

	tileWidth=(v){_tileWidth=v}
	width{_tileWidth * 8 * _scale}
	height{_tileHeight * 8 * _scale}
	tileWidth{_tileWidth}
	tileHeight=(v){_tileHeight=v}
	tileHeight{_tileHeight}
	colorkey{_colorkey}
	colorkey=(v){_colorkey=v}
	rotate{_rotate}
	rotate=(v){_rotate=v}
	flip{_flip}
	flip=(v){_flip=v}
	scale{_scale}
	scale=(v){_scale=v}

	draw(camera) {
		TIC.spr(_spriteid, x - camera.x, y - camera.y, _colorkey, _scale, _flip, _rotate, _tileWidth, _tileHeight)
	}
}
