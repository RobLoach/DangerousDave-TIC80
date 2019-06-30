import "PixelEntity" for PixelEntity

class RectangleEntity is PixelEntity {
	construct new() {
		super()
		rectEntityInit()
	}

	construct new(col) {
		super()
		rectEntityInit()
		color = col
	}

	construct new(col, fill) {
		super()
		rectEntityInit()
		color = col
		_fill = fill
	}

	rectEntityInit() {
		tags.add("RectangleEntity")
		_fill = false
	}

	fill{_fill}
	fill=(v){_fill=v}

	draw(camera) {
		if (_fill) {
			TIC.rect(x - camera.x, y - camera.y, color)
		} else {
			TIC.rectb(x - camera.x, y - camera.y, color)
		}
	}
}
