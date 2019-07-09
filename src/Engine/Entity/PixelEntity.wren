import "Entity" for Entity

class PixelEntity is Entity {
	construct new() {
		super()
		pixelEntityInit()
	}

	construct new(color) {
		super()
		pixelEntityInit()
		_color = color
	}

	pixelEntityInit() {
		tags.add("PixelEntity")
		_color = 0
		width = 1
		height = 1
	}

	color{_color}
	color=(v){_color=v}

	draw(camera) {
		TIC.pix(x - camera.x, y - camera.y, _color)
	}
}
