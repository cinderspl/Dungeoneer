function love.load()
	require "cltk"
	game = {}
<<<<<<< HEAD
	game.player = {}

	if love.filesystem.getInfo("stored/player.lua") then
		game.player = love.filesystem.load("stored/player.lua")()
	end

	game.stored = {} -- things the game has to rememember, like the level list or the player names
	game.stored.current = {}
	game.state = 1 -- game state 1 is for the title screen, 2 is for gameplay, 3 is for level designing, 4 is for the library. decimals may be used for more specific states (like searching the catalogue when designing a level)
=======
	game.stored = {} -- things the game has to rememember, like the level list or the player names
	game.state = 1 -- game state 1 is for the title screen, 2 is for gameplay, 3 is for level designing, 4 is for the library. decimals may be used for more specific states (like searching the catalogue when designing a level)
	title = love.graphics.newImage("sprites/menus/logotemp.png")
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7

	bgm = love.audio.newSource("ost/Fate At Your Fingertips.mp3", "static")
	function muswitch(track)
		bgm:stop()
		bgm = love.audio.newSource("ost/" .. track .. ".mp3", "static")
		bgm:setLooping(true)
		bgm:play()
<<<<<<< HEAD
		mutext = {track, 3}
=======
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
	end
	muswitch("Fate At Your Fingertips")

	function red() love.graphics.setColor(1, 0, 0) end
	function orange() love.graphics.setColor(1, 0.5, 0) end
	function yellow() love.graphics.setColor(1, 1, 0) end
	function green() love.graphics.setColor(0, 1, 0) end
	function blue() love.graphics.setColor(0, 0, 1) end
	function purple() love.graphics.setColor(0.5, 0, 1) end
<<<<<<< HEAD
	function magenta() love.graphics.setColor(1, 0, 1) end
	function pink() love.graphics.setColor(1, 0.8, 1) end
	function white() love.graphics.setColor(1, 1, 1) end

	char = {}

	char.norman = {
		br = 0.8, bg = 3, bb = 0,
		r = 0.7, g = 0, b = 0.9
	}

	char.sign = {
		br = 0.5, bg = 0.5, bb = 0.5,
		r = 0, g = 0, b = 0
	}

=======
	function white() love.graphics.setColor(1, 1, 1) end

>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
	dial = {}
	dial.norman = cltk.dialogueInit("dialogue/norman.txt", love)
end

function love.update(dt)
<<<<<<< HEAD

	-- Constant, usually minor actions

	if mutext then
		mutext[2] = mutext[2] - dt
		if mutext[2] < 0 then mutext = nil end
	end

	if love.audio.getVolume() * 100 ~= game.player.audio.vol then
		love.audio.setVolume(game.player.audio.vol / 100)
	end

	if game.state == 1 then

		-- Title screen

		if cltk.button(1, love, 0, 200, 200, 300) then
			cltk.sfx("sfx/confirm.mp3", love)
			game.stored.levels = love.filesystem.getDirectoryItems("levels")
			game.stored.levels.names = {}
			for i, v in ipairs(game.stored.levels) do
				local dat = love.filesystem.load("levels/" .. v)()
				game.stored.levels.names[i] = dat.meta.name
			end
			game.state = 4
			love.timer.sleep(0.1)
		end
		if cltk.button(1, love, 704, 768, 504, 568) then
			cltk.sfx("sfx/confirm.mp3", love)
			game.state = 1.1
			love.timer.sleep(0.1)
		end
	end

	if game.state == 1.1 then
		if cltk.button(1, love, 32, 96, 504, 568) then
			cltk.sfx("sfx/cancel.mp3", love)
			game.state = 1
			love.timer.sleep(0.1)
		end
		if cltk.button(1, love, 200, 600, 50, 100) then
			game.player.audio.vol = ((love.mouse.getX() - 200) / 4)
			cltk.sfx("sfx/select.mp3", love)
			love.timer.sleep(0.1)
		end
	end

	if game.state == 2 then

		if love.keyboard.isScancodeDown(game.player.controls.move_down) then
			game.player.y = game.player.y + game.player.speed / 48
			if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "down" end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_up) then
			game.player.y = game.player.y - game.player.speed / 48
			if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "up" end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_left) then
			game.player.x = game.player.x - game.player.speed / 48
			if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "left" end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_right) then
			game.player.x = game.player.x + game.player.speed / 48
			if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "right" end
		end

		for y, row in ipairs(map) do
			for x, tile in ipairs(row) do
				if tile ~= 0 then
					for i, v in ipairs(tile) do
						if v.type == "Sign" then
							if math.abs((x - game.player.x)^2 +(y - game.player.y)^2) < 1 and love.keyboard.isScancodeDown(game.player.controls.interact) then
								
							end
						end
					end
				end
			end
		end

	end

	if game.state == 4 then

		if cltk.button(1, love, 725, 775, 525, 575) then
			cltk.sfx("sfx/cancel.mp3", love)
			game.state = 1
			love.timer.sleep(0.1)
		end

		if cltk.button(1, love, 25, 75, 525, 575) then
			cltk.sfx("sfx/confirm.mp3", love)
=======
	if game.state == 1 then
		if cltk.button(1, love, 0, 200, 200, 300) then
			game.state = 4
		end
	end
	if game.state == 2 then
	end
	if game.state == 4 then

		if cltk.button(1, love, 25, 525, 75, 575) then
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
			game.stored.levels = love.filesystem.getDirectoryItems("levels")
			game.stored.levels.names = {}
			for i, v in ipairs(game.stored.levels) do
				local dat = love.filesystem.load("levels/" .. v)()
				game.stored.levels.names[i] = dat.meta.name
			end
<<<<<<< HEAD
			love.timer.sleep(0.1)
=======
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
		end

		for i, v in ipairs(game.stored.levels) do
			if cltk.button(1, love, 120, 152, i*64, i*64+32) then
<<<<<<< HEAD
				cltk.sfx("sfx/confirm.mp3", love)
				game.state = 4.1
				muswitch("All Aboard!")
				game.stored.levels = {}
				game.stored.levels.current = love.filesystem.load("levels/" ..v)()
				map = game.stored.levels.current.data.map
				bg = love.graphics.newImage("sprites/backgrounds/trainbg.png")
				love.timer.sleep(0.1)
=======
				game.state = 4.1
				muswitch("All Aboard")
				game.stored.levels = {}
				game.stored.levels.current = love.filesystem.load("levels/" ..v)()
				bg = love.graphics.newImage("sprites/backgrounds/trainbg.png")
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
			end
		end

	end
<<<<<<< HEAD

	if game.state == 4.1 then
		if cltk.button(1, love, 725, 775, 525, 575) then
			cltk.sfx("sfx/lockin.mp3", love)
			local lvl = game.stored.levels.current
			game.stored.levels = {}
			game.stored.levels.current = lvl

			-- Preparing the player

			game.player.x = game.stored.levels.current.data.startpos[1]
			game.player.y = game.stored.levels.current.data.startpos[2]
			game.player.speed = 5
			game.player.dir = "down"

			game.state = 2
			muswitch(game.stored.levels.current.settings.track)
			love.timer.sleep(0.1)
		end
	end
=======
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
end

function love.draw()
	if game.state == 1 then

		-- Title screen

<<<<<<< HEAD
		if not title then
			title = love.graphics.newImage("sprites/menus/logotemp.png")
		end
		if not settingsbutton then
			settingsbutton = love.graphics.newImage("sprites/menus/settingsenter.png")
		end

		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(settingsbutton, 704, 504)
=======
		love.graphics.setColor(1, 1, 1)
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
		love.graphics.draw(title, 0, 0)

		red()
		love.graphics.rectangle("fill", 0, 200, 200, 100)
		love.graphics.setColor(0, 0, 1)

		blue()
		love.graphics.rectangle("fill", 0, 350, 200, 100)

<<<<<<< HEAD
	elseif game.state == 1.1 then
		blue()
		love.graphics.rectangle("fill", 0, 0, 800, 600)
		purple()
		love.graphics.rectangle("fill", 200, 50, 400, 50)
		red()
		love.graphics.rectangle("fill", 200, 50, 4 * game.player.audio.vol, 50)
		yellow()
		love.graphics.printf("Master Volume", 200, 50, 4 * game.player.audio.vol, "left", 0, 3 * (game.player.audio.vol / 100))
		love.graphics.printf("" .. game.player.audio.vol, 200 + 4 * game.player.audio.vol, 50, 50, "left", 0, 3)

		white()
		if not returnbutton then
			returnbutton = love.graphics.newImage("sprites/menus/return.png")
		end
		love.graphics.draw(returnbutton, 32, 504)
=======
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
	elseif game.state == 2 then

		-- Playing a level

<<<<<<< HEAD
		for y, row in ipairs(map) do
			for x, tile in ipairs(row) do
				if tile ~= 0 then
					for i, v in ipairs(tile) do
						if v.type == "Sign" then
							orange()
							love.graphics.rectangle("fill", x*48, y*48, 48, 48)
							if cltk.distance(x, game.player.x, y, game.player.y) < 1 and love.keyboard.isScancodeDown(game.player.controls.interact) then
								char.sign.text = {}
								char.sign.text[1] = v.text
								cltk.dialogue(char.sign, love, (x-1)*48, (x+2)*48, (y-2)*48, (y)*48, 1)
								char.sign.text = nil
							end
						end
					end
				end
			end
		end

		white()
		love.graphics.rectangle("fill", game.player.x*48, game.player.y*48, 64, 96)
		love.graphics.printf(game.player.meta.display, game.player.x*48, game.player.y*48-20, 64, "justify")

=======
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
	elseif game.state == 3 then

		-- Designing a level 

	elseif game.state == 4 then

		-- Library

		orange()
		love.graphics.rectangle("fill", 0, 0, 100, 600)
		love.graphics.rectangle("fill", 700, 0, 800, 600)
		white()

		local ntable = love.graphics.newImage("sprites/norman/table.png")
		love.graphics.draw(ntable, 150, 450, 0, 2)
		local fetch = love.graphics.newImage("sprites/menus/fetchlevelsbutton.png")
		love.graphics.draw(fetch, 25, 525)

		for i, v in ipairs(game.stored.levels.names) do
			blue()
			love.graphics.rectangle("fill", 120, i*64, 32, 32)
			love.graphics.printf(v, 168, i*64, 632)
		end

		elseif game.state == 4.1 then

			-- Preparing to enter level

			white()
			love.graphics.draw(bg, 0, 0)

			love.graphics.setColor(1, 1, 1, 0.5)
			love.graphics.rectangle("fill", 450, 50, 300, 300)
	end
<<<<<<< HEAD


	-- Popup stuff like music text

	if mutext then
		love.graphics.setColor(1, 0, 0, mutext[2]/2)
		love.graphics.printf("cinderspl ~" .. mutext[1], 0, 568, 300, "left", 0, 2, 2)
	end
	white()

end

function love.quit()

end

=======
end
>>>>>>> 4603fa5dfc443e3ee2f6cbb6c31ec054333647b7
