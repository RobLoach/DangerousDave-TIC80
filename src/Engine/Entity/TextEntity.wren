import "PixelEntity" for PixelEntity

class TextEntity is PixelEntity {
	// TODO: Add Sprite Font support.
	construct new() {
		super()
		textEntityInit()
	}

	construct new(textToDisplay) {
		super()
		textEntityInit()
		text = textToDisplay
	}

	construct new(textToDisplay, col) {
		super()
		textEntityInit()
		text = textToDisplay
		color = col
	}

	textEntityInit() {
		tags.add("TextEntity")
		_text = ""
		_fixed = false
		_scale = 1
		_smallfont=false
	}

	updateSize() {
		// Ensure there is some text available.
		if (text.count == 0) {
			return width = height = 0
		}

		// Get the width of the text, off-screen.
		width = TIC.print(_text, -999, -999, color, _fixed, _scale, _smallfont)

		// Find the height based on how many newlines there are.
		height = _text.split("\n").count * 5
	}

	text{_text}
	text=(v){
		_text = v
		updateSize()
	}

	fixed{_fixed}
	fixed=(v){
		_fixed=v
		updateSize()
	}

	scale{_scale}
	scale=(v){
		_scale=v
		updateSize()
	}

	smallfont{_smallfont}
	smallfont=(v){
		_smallfont=v
		updateSize()
	}

	draw(camera) {
		TIC.print(_text, x - camera.x, y - camera.y, color, _fixed, _scale, _smallfont)
	}
}
