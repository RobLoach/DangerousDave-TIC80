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
		spriteId = _frames[_currentFrame]
		_animationSpeed = animationSpeed
	}

	animationEntityInit() {
		_currentFrame = 0
		_frames = []
		_animationSpeed = 20
		_t = 0
		tags.add("AnimationEntity")
	}

	animationSpeed{_animationSpeed}
	animationSpeed=(v){_animationSpeed=v}
	frames{_frames}
	frames=(v){
		_frames=v
		updateFrame()
	}
	currentFrame{_currentFrame}
	currentFrame=(v){_currentFrame=v}
	updateFrame() {
		if (_currentFrame >= _frames.count) {
			_currentFrame = 0
		}
		spriteId = _frames[_currentFrame]
	}

	update() {
		super()
		_t = _t + 1
		if (_t > _animationSpeed) {
			_currentFrame = _currentFrame + 1
			_t = 0
			updateFrame()
		}
	}
}
