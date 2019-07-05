import "../Math/Vector" for Vector
import "../Math/Rectangle" for Rectangle

class Entity is Rectangle {
	construct new() {
		super()
		_velocity = Vector.new(0, 0)
		_acceleration = Vector.new(0, 0)
		_name = "Entity"
		_tags = []
	}

	hasTag(v){
		for (tag in tags) {
			if (tag == v) {
				return true
			}
		}
		return false
	}

	parent{_parent}
	parent=(v){_parent=v}
	name{_name}
	name=(v){_name=v}
	velocity{_velocity}
	velocity=(v){_velocity=v}
	tags{_tags}
	tags=(v){_tags=v}
	acceleration{_acceleration}
	acceleration=(v){_acceleration=v}

	delete() {
		var oldName = _name
		_name = "!DELETE!"
		for (i in 0...parent.entities.count) {
			if (parent[i].name == name) {
				parent.removeAt(i)
				_name = oldName
				return
			}
		}
	}

	draw() {
		draw(Vector.new())
	}

	draw(camera){
		// Nothing
	}

	update() {
		_velocity.x = _velocity.x + _acceleration.x
		_velocity.y = _velocity.y + _acceleration.y
		x = x + _velocity.x
		y = y + _velocity.y
	}
}
