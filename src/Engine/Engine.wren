import "random" for Random

class Engine {

	static start() {
		// Initialize the random number generator.
		__random = Random.new()
	}

	static random(min, max) {
		return __random.int(max) + min
	}

	static random(max) {
		return __random.int(max)
	}

	static loadPalette(paletteString) {
		for (i in 0...16) {
			TIC.trace(Engine.substr(paletteString, i*6, 2))
			TIC.trace("\n")
			TIC.poke(16320+(i*3), Num.fromString(Engine.substr(paletteString, i*6, 2)))
			TIC.poke(16320+(i*3)+1, Num.fromString(Engine.substr(paletteString, (i*6)+2,2)))
			TIC.poke(16320+(i*3)+2, Num.fromString(Engine.substr(paletteString, (i*6)+4,2)))
		}
	}

	static slice(string, start) {
		return slice(string, start, string.count)
	}

	static substr(string, start, length) {
		var result = ""
		for (index in start...length) {
			result = result + string[index]
		}
		return result
	}

}
