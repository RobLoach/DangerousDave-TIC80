class Vector {
	construct new() { set(0, 0) }
	construct new(v) { set(v, v) }
	construct new(x, y) { set(x, y) }

	x { _x }
	y { _y }
	x=(v) { _x = v }
	y=(v) { _y = v }


	set(x, y) {
		_x = x
		_y = y
	}

	+(other) {
		var result
		if (other is Num) {
			result = Vector.new(x + other, y + other)
		} else {
			result = Vector.new(x + other.x, y + other.y)
		}
		return result
	}

	- { Vector.new(-x, -y) }

	-(other) { this + -other }

	*(v) { Vector.new(x * v, y * v) }
	/(v) { Vector.new(x / v, y / v) }

	==(other) { (x == other.x) && (y == other.y) }
	!=(other) { !(this == other) }

	distanceTo(other) { Vector.distance(this, other) }
	static distance(a, b) {
		var xdiff = a.x - b.x
		var ydiff = a.y - b.y
		return ((xdiff * xdiff) + (ydiff * ydiff)).sqrt
	}

	toList { [x, y] }
	toString {
		var coords = x.toString + ", " + y.toString
		return "Vector(" + coords + ")"
	}
}
