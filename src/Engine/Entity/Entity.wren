import "../Math/Vector" for Vector
import "../Math/Rectangle" for Rectangle

class Entity is Rectangle {
	construct new() {
		super()
		_velocity = Vector.new(0, 0)
		_name = "Entity"
		_tags = []
	}

	name{_name}
	name=(v){_name=v}
	velocity{_velocity}
	velocity=(v){_velocity=v}
	tags{_tags}
	tags=(v){_tags=v}

	draw() {
		draw(Vector.new())
	}

	draw(camera){
		// Nothing
	}

	update() {
		x = x + _velocity.x
		y = y + _velocity.y
	}
}
