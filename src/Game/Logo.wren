import "../Engine/Entity/SpriteEntity"
import "Highscores"

class Logo is SpriteEntity {
	construct new(manager) {
		super(SpriteEntity[0, 13, 2], 14, 6)
		name = "logo"
		_manager = manager
		_t = 0

		_selection = 0
		_menuShown = false
		_highscores = null

		_menuList = [
			"Start Game",
			"Continue",
			"Highscores",
			"Quit"
		]
	}

	update() {
		// Move up and down on the screen.
		_t = _t + 0.07
		y = _t.sin * 3 - 8
		if (_t > 10000) {
			_t = 0
		}

		// Move on when the player hits a button.
		if (!_menuShown) {
			if (TIC.btnp(4) || TIC.btnp(5) || TIC.btnp(6) || TIC.btnp(7)) {
				_menuShown = true
			}
			super()
			return
		}

		if (_highscores) {
			super()
			if (_highscores.update()) {
				_highscores = null
			}
			return
		}

		// Menu input
		if (TIC.btnp(0)) {
			_selection = _selection - 1
		} else if (TIC.btnp(1)) {
			_selection = _selection + 1
		}

		// Keep selection in bounds.
		if (_selection < 0) {
			_selection = 0
		} else if (_selection >= _menuList.count) {
			_selection = _menuList.count - 1
		}

		// Menu is selected
		if (TIC.btnp(4) || TIC.btnp(5) || TIC.btnp(6) || TIC.btnp(7)) {
			if (_menuList[_selection] == "Start Game") {
				parent["level"].status = "complete"
			} else if (_menuList[_selection] == "Continue") {
				var canLoad = TIC.pmem(0)
				if (canLoad > 0) {
					parent["level"].status = "load"
				}
			} else if (_menuList[_selection] == "Highscores") {
				_highscores = Highscores.new(_manager)
			} else if (_menuList[_selection] == "Quit") {
				TIC.exit()
				return
			}
		}

		super()
	}

	draw(camera) {
		super(camera)

		// Display the Menu.
		if (!_menuShown) {
			return
		}

		if (_highscores) {
			_highscores.draw()
			return
		}

		var maxWidth = 240
		var maxHeight = 136
		var menuLocation = Rectangle.new(maxWidth / 4, maxHeight / 3, maxWidth / 2, _menuList.count * 10 + 15)
		TIC.rect(menuLocation.x, menuLocation.y, menuLocation.width, menuLocation.height, 15)
		TIC.rectb(menuLocation.x, menuLocation.y, menuLocation.width, menuLocation.height, 0)

		var index = 0
		var levelToLoad = TIC.pmem(0)
		for (item in _menuList) {
			var color = 0
			if (item == "Continue" && levelToLoad == 0) {
				color = 3
			}

			var padding = 10
			var menuItemText = ""
			if (_selection == index) {
				menuItemText = "> %(item)"
			} else {
				menuItemText = "  %(item)"
			}
			TIC.print(menuItemText, menuLocation.x+padding, menuLocation.y + padding + 10 * index, color)
			index = index + 1
		}
	}
}
