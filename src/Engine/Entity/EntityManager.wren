import "Entity" for Entity

class EntityManager is Entity {
	construct new() {
		super()
		_entities = []
		tags.add("EntityManager")
		// Screen size.
		width = 240
		height = 136
	}

	draw() {
		for (entity in _entities) {
			entity.draw(this)
		}
	}

	update() {
		super.update()
		for (entity in _entities) {
			entity.update()
		}
	}

	[index] {
		if (index is Num) {
			return _entities[index]
		} else if (index is String) {
			for (entity in _entities) {
				if (entity.name == index) {
					return entity
				}
			}
		}
		return null
	}
	add(v) {
		v.parent = this
		_entities.add(v)
	}
	clear() {
		_entities.clear()
	}

	entities{_entities}
	getEntities(tag) {
		var out = []
		for (entity in _entities) {
			if (entity.hasTag(tag)) {
				out.add(entity)
			}
		}
		return out
	}

	prioritize(name) {
		// TODO: Figure out true zindex sorting.
		var i = 0
		for (entity in _entities) {
			if (entity.name == name) {
				_entities.removeAt(i)
				_entities.add(entity)
				return this
			}
			i = i + 1
		}
		return this
	}
}
