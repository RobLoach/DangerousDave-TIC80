-- script: moon
export init=->
	export player = Player()

export TIC=->
	cls(3)
	player\update!
	player\draw!

export class Animation
	new: (frames = {}, speed = 5, width = 1, height = 1, colorkey = 1, scale = 1, flip = 0, rotate = 0) =>
		@currentFrame = 0
		@frames = frames
		@speed = speed
		@width = width
		@height = height
		@t = speed
		@startTime = speed
		@colorkey = colorkey
		@scale = scale
		@flip = flip
		@rotate = rotate

	update: () =>
		@t = @t - 1
		if (@t < 0) then
			@currentFrame = @currentFrame + 1
			if (@currentFrame > #@frames) then
				@currentFrame = 0
			@t = @startTime

	draw: (x, y, flip = 0) =>
		--print('a', x, y)
		spr(@frames[@currentFrame], x, y, @colorkey, @scale, flip, @rotate, @width, @height)

export class Player 
	spritePosition: (x, y, width = 2, height = 2) =>
		ypos = y * height * 16 / height
		return ypos + x * width

	new: () =>
		@idle = Animation({0, 2, 4, 2, 0, 2, 4, 6, 4, 2, 0}, 20, 2, 2)
		@walking = Animation({
			@spritePosition(0, 2),
			@spritePosition(1, 2),
			@spritePosition(2, 2),
			@spritePosition(0, 2),
			@spritePosition(1, 2)
		}, 8, 2, 2)
		@currentAnimation = @idle
		@x = 20
		@y = 20
		@movingLeft = 0

	update: =>
		@currentAnimation\update!

		@moving = false
		if btn(0) then
			@y -= 1
			@moving = true
		if btn(1) then
			@y += 1
			@moving = true
		if btn(2) then
			@x -= 1
			@moving = true
			@movingLeft = 1
		if btn(3) then
			@x += 1
			@moving = true
			@movingLeft = 0

		if (@moving) then
			@currentAnimation = @walking
		else
			@currentAnimation = @idle
	draw: =>
		@currentAnimation\draw(@x, @y, @movingLeft)
		
init!
