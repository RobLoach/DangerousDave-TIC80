class Animation {
	construct new(frames, speed, width, height) {
		_currentFrame = 0
		_frames = frames
		_speed = speed
		_width = width
		_height = height
		_t = speed
		_startTime = speed
		_colorkey = 1
		_scale = 1
		_flip = 0
		_rotate = 0
	}

	update() {
		_t = _t - 1
		if (_t < 0) {
			_currentFrame = _currentFrame + 1
			if (_currentFrame >= _frames.count) {
				_currentFrame = 0
			}
			_t = _speed
		}
	}

	draw(x, y, flip) {
		TIC.spr(_frames[_currentFrame], x, y, _colorkey, _scale, flip, _rotate, _width, _height)
	}
}
