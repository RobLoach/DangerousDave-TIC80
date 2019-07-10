class Sound {
	static explode() {
		TIC.sfx(6, 2 * 12, 30, 3, 15, -1)
	}
	static door() {
		TIC.sfx(2, 3 * 12, -1, 3)
	}
	static menuMove() {
		TIC.sfx(3, 6 * 12, 2, 3, 15)
	}
	static menuSelect() {
		TIC.sfx(3, 3 * 12, 15, 2, 15, -1)
	}
	static shoot() {
		TIC.sfx(2, 2*8, 50, 3, 15, 2)
	}
	static walking() {
		TIC.sfx(1)
	}
	static jetpack() {
		TIC.sfx(4)
	}

	static jumping(velocity) {
		TIC.sfx(3, 5 * 12 + velocity * 24, -1, 0)
	}

	static falling(velocity) {
		TIC.sfx(3, 5 * 12 + -velocity * 24, -1, 0)
	}
}
