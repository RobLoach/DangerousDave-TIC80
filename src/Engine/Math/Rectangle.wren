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
	}

	toString {
		var coords = x.toString + ", " + y.toString + ", " + width.toString + ", " + height.toString
		return "Rectangle(" + coords + ")"
	}
}
