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

	[index] {_entities[index]}
	add(v) {
		_entities.add(v)
	}
	clear() {
		_entities.clear()
	}

	getEntities() {_entities}
	getEntities(tag) {
		var out = []
		for (entity in _entities) {
			if (entity.hasTag(tag)) {
				out.add(entity)
			}
		}
		return out
	}

	getEntity(tag) {
		var out = getEntities(tag)
		if (out.count > 0) {
			return out[0]
		}
		return null
	}
}
