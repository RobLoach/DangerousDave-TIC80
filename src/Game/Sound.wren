class Sound {
	static explode() {
		TIC.sfx(6, "C-1", 30, 3)
	}
	static door() {
		TIC.sfx(2, "C-4", -1, 3)
	}
	static menuMove() {
		TIC.sfx(3, "C-6", 2, 3)
	}
	static menuSelect() {
		TIC.sfx(3, "C-3", 15, 2)
	}
	static shoot() {
		TIC.sfx(7, "G-1", -1, 3, 15)
	}
	static walking() {
	//TIC.sfx(4, "C-2")
		if (__toggleWalking == 0) {
			TIC.sfx(4, "C-2", 5, 0, 8)
			__toggleWalking = 5
		} else if (!__toggleWalking) {
			__toggleWalking = 5
		} else {
		   __toggleWalking = __toggleWalking - 1
	   }
	}
	static jetpack() {
		TIC.sfx(4)
	}

	static jumping(velocity) {
		TIC.sfx(3, 5 * 12 + velocity * 24, -1, 0, 4)
	}

	static falling(velocity) {
		TIC.sfx(3, 5 * 12 + -velocity * 24, -1, 0, 4)
	}
}
