// title:  game title
// author: game developer
// desc:   short description
// script: wren

import "random" for Random
import "Engine/Animation" for Animation

import "Engine/Level" for Level
import "Engine/Player" for Player


class Game is TIC {

	construct new(){
		_level = Level.new()
	}
	
	TIC(){
		TIC.cls(0)
		_level.update()


		_level.draw()

	}
}