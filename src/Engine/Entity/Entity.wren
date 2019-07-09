import "../Math/Vector" for Vector
import "../Math/Rectangle" for Rectangle

class Entity is Rectangle {
	construct new() {
		super()
		_velocity = Vector.new(0, 0)
		_acceleration = Vector.new(0, 0)
		_name = "Entity"
		_tags = []
		_children = []
		width = 240
		height = 136
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
	children{_children}
	children=(v){_children=v}
	name{_name}
	name=(v){_name=v}
	velocity{_velocity}
	velocity=(v){_velocity=v}
	tags{_tags}
	tags=(v){_tags=v}
	acceleration{_acceleration}
	acceleration=(v){_acceleration=v}

	delete() {
		if (parent) {
			var oldName = _name
			_name = "!DELETE!"
			for (i in 0...parent.children.count) {
				if (parent[i].name == name) {
					parent.removeAt(i)
					_name = oldName
					return true
				}
			}
		}
		return false
	}

	draw() {
		draw(this)
		for (entity in _children) {
			entity.draw(this)
		}
	}

	draw(camera){
		// Nothing
	}

	update() {
		_velocity.x = _velocity.x + _acceleration.x
		_velocity.y = _velocity.y + _acceleration.y
		x = x + _velocity.x
		y = y + _velocity.y

		for (entity in _children) {
			entity.update()
		}
	}

	[index] {
		if (index is Num) {
			return _children[index]
		}

		if (index is String) {
			for (entity in _children) {
				if (entity.name == index) {
					return entity
				}
			}
		}
	}
	removeAt(v) {
		_children.removeAt(v)
	}
	add(v) {
		v.parent = this
		_children.add(v)
	}

	clear() {
		_children.clear()
	}

	getChildren(tag) {
		var out = []
		for (entity in _children) {
			if (entity.hasTag(tag)) {
				out.add(entity)
			}
		}
		return out
	}


	==(other) {
		(x == other.x) && (y == other.y) && (width == other.width) && (height == other.height) && (name == other.name) && (tags == other.tags)
	}
	!=(other) { !(this == other) }

	prioritize(name) {
		// TODO: Figure out true zindex sorting.
		var i = 0
		for (entity in _children) {
			if (entity.name == name) {
				_children.removeAt(i)
				_children.add(entity)
				return this
			}
			i = i + 1
		}
		return this
	}

	toString {
		var coords = x.toString + ", " + y.toString + ", " + width.toString + ", " + height.toString
		return "Entity('" + name + "', " + coords + ")"
	}
}
