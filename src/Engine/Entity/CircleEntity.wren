import "RectangleEntity" for RectangleEntity

class CircleEntity is RectangleEntity {
	construct new() {
		super()
		tags.add("CircleEntity")
		width = 10
		height = 10
	}

	draw(camera) {
		if (fill) {
			TIC.circ(centerX - camera.x, centerY - camera.y, width / 2, color)
		} else {
			TIC.circb(centerX - camera.x, centerY - camera.y, width / 2, color)
		}
	}
}
