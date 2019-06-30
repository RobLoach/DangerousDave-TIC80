import "RectangleEntity" for RectangleEntity

class CircleEntity is RectangleEntity {
	construct new() {
		super()
	}

	draw(camera) {
		if (fill) {
			TIC.circ(centerX - camera.x, centerY - camera.y, width / 2, color)
		} else {
			TIC.circb(centerX - camera.x, centerY - camera.y, width / 2, color)
		}
	}
}
