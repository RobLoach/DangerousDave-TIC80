import "Vector" for Vector

class Rectangle is Vector {
	construct new() {
		super()
		_size = Vector.new(1, 1)
	}
	construct new(x, y) {
		super(x, y)
		_size = Vector.new(1, 1)
	}
	construct new(x, y, w, h) {
		super(x, y)
		_size = Vector.new(w, h)
	}

	size{_size}
	size=(v){_size=v}
	width{_size.x}
	height{_size.y}
	width=(v) {_size.x = v}
	height=(v) {_size.y = v}
	position{Vector.new(x, y)}
	position=(v){
		x = v.x
		y = v.y
		v
	}
	set(x,y,w,h) {
		_x=x
		_y=y
		width=w
		height=h
	}

	right{x+width}
	right=(v){x=v-width}
	bottom{y+height}
	bottom=(v){y=v-height}
	left{x}
	left=(v){x=v}
	top{y}
	top=(v){y=v}
	centerX{x + width / 2}
	centerX=(v){x = v - width / 2}
	centerY{y + height / 2}
	centerY=(v){y = v - height / 2}
	center{Vector.new(centerX, centerY)}
	center=(v){
		centerX = v.x
		centerY = v.y
		v
	}

	collisionRect(rect2) {
		return x < rect2.right && right > rect2.x && y < rect2.y + rect2.height && bottom > rect2.y
	}
	collisionRect(rectX, rectY, rectWidth, rectHeight) {
		var x_overlaps = (left < rectX + rectWidth) && (right > rectX)
		var y_overlaps = (top < rectY+rectHeight) && (bottom > rectY)
		return x_overlaps && y_overlaps
	}
	collisionCircle(circle2X, circle2Y, circle2Radius) {
		var dx = centerX - circle2X
		var dy = centerY - circle2Y
		var distance = (dx * dx + dy * dy).sqrt

		return distance < width / 2 + circle2Radius
	}

	toString {
		var coords = x.toString + ", " + y.toString + ", " + width.toString + ", " + height.toString
		return "Rectangle(" + coords + ")"
	}

	==(other) { (x == other.x) && (y == other.y) && (width == other.width) && (height == other.height) }
	!=(other) { !(this == other) }

	perimiter() {
		2 * (x + y)
	}

	area() {
		2*x + 2*y
	}
	union(rect) {
		if (!collisionRect(rect)) {
			return null
		}

		var base_x = (rect.x..x).max
		var base_y = (rect.y..y).max
		var max_x = (rect.width..width).min
		var max_y = (rect.height..height).min

		return Rectangle.new(base_x, base_y, max_x, max_y)
	}
	toList { [x, y, width, height] }
}
