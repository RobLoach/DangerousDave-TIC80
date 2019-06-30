import "SpriteEntity" for SpriteEntity

class AnimationEntity is SpriteEntity {
	construct new() {
		super()
		animationEntityInit()
	}
	construct new(frames) {
		super()
		animationEntityInit()
		_frames = frames
		spriteId = _frames[_currentFrame]
	}
	construct new(frames, animationSpeed) {
		super()
		animationEntityInit()
		_frames = frames
		_animationSpeed = animationSpeed
		spriteId = _frames[_currentFrame]
	}

	animationEntityInit() {
		_currentFrame = 0
		_frames = []
		_animationSpeed = 20
		_t = 0
		tags.add("AnimationEntity")
	}

	frames{_frames}
	frames=(v){_frames=v}
	currentFrame{_currentFrame}
	currentFrame=(v){_currentFrame=v}

	update() {
		super()
		_t = _t + 1
		if (_t > _animationSpeed) {
			_currentFrame = _currentFrame + 1
			if (_currentFrame >= _frames.count) {
				_currentFrame = 0
			}
			spriteId = _frames[_currentFrame]
			_t = 0
		}
	}
}
