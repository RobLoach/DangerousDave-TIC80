import "../Engine/Entity/RectangleEntity" for RectangleEntity

class Highscores is RectangleEntity {
	construct new(manager) {
		super(15, true)
		width = 200
		height = 100
		x = 240 / 2 - width / 2
		y = 136 / 2 - height / 2
		name = "highscores"
		_manager = manager
		_highscoreSize = 5

		_highscores = [
			{
				"name": "ROB",
				"score": 800,
				"level": 1
			},
			{
				"name": "AJR",
				"score": 500,
				"level": 1
			},
			{
				"name": "JDC",
				"score": 300,
				"level": 1
			},
			{
				"name": "TAH",
				"score": 200,
				"level": 1
			}
		]

		loadHighscores()
	}

	addHighscore(highscore) {
		loadHighscores()

		var i = _highscores.count - 1
		var added = false
		while(i >= 0) {
			var current = _highscores[i]
			if (current["score"] > highscore["score"]) {
				_highscores.insert(i+1, highscore)
				added = true
				break
			}
			i = i - 1
		}

		if (!added) {
			_highscores.insert(0, highscore)
		}
		saveHighscores()
	}

	saveHighscores() {
		var start = 1
		var i = 0
		for (highscore in _highscores) {
			var startIndex = start + i * _highscoreSize
			TIC.pmem(startIndex, highscore["name"].bytes[0])
			TIC.pmem(startIndex + 1, highscore["name"].bytes[1])
			TIC.pmem(startIndex + 2, highscore["name"].bytes[2])
			TIC.pmem(startIndex + 3, highscore["score"])
			TIC.pmem(startIndex + 4, highscore["level"])
			i = i + 1
		}
	}

	loadHighscores() {
		var start = 1
		var i = 0
		var startIndex = start + i * _highscoreSize
		while (startIndex <= 250) {
			var char1 = TIC.pmem(startIndex)
			var char2 = TIC.pmem(startIndex + 1)
			var char3 = TIC.pmem(startIndex + 2)
			var score = TIC.pmem(startIndex + 3)
			var level = TIC.pmem(startIndex + 4)
			if (char1 > 0 && char2 > 0 && char3 > 0) {
				var a = String.fromCodePoint(char1)
				var b = String.fromCodePoint(char2)
				var c = String.fromCodePoint(char3)
				var newHighscore = {
					"name": a + b + c,
					"score": score,
					"level": level
				}
				if (i >= _highscores.count) {
					_highscores.add(newHighscore)
				} else {
					_highscores[i] = newHighscore
				}
			}
			i = i + 1
			startIndex = start + i * _highscoreSize
		}

		return _highscores
	}

	draw(camera) {
		super(camera)

		TIC.rectb(x, y, width, height, 0)

		var textWidth = TIC.print("HIGHSCORES", -999, -999)
		TIC.print("HIGHSCORES", centerX - textWidth / 2, top + 5, 0)

		var textOut =       "SCORE    NAME    LEVEL\n"
		textOut = textOut + "-----    ----    -----\n\n"

		var i = 0
		for (highscore in _highscores) {
			i = i + 1
			if (i > 8) {
				break
			}
			var scoreText = highscore["score"].toString
			while (scoreText.count <= 8) {
				scoreText = scoreText + " "
			}

			textOut = textOut + scoreText + highscore["name"] + "       " + highscore["level"].toString + "   \n"
		}
		TIC.print(textOut, left + 30, top + 20, 0, true)
	}

	update() {
		if (TIC.btnp(4) || TIC.btnp(5) || TIC.btnp(6) || TIC.btn(7)) {
			return true
		}

		return false
	}
}
