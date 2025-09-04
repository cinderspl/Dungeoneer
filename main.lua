function love.load()
	require "cltk"
	game = {}
	game.stored = {} -- things the game has to rememember, like the level list or the player names
	game.state = 1 -- game state 1 is for the title screen, 2 is for gameplay, 3 is for level designing, 4 is for the library. decimals may be used for more specific states (like searching the catalogue when designing a level)
	title = love.graphics.newImage("sprites/menus/logotemp.png")

	bgm = love.audio.newSource("ost/Fate At Your Fingertips.mp3", "static")
	function muswitch(track)
		bgm:stop()
		bgm = love.audio.newSource("ost/" .. track .. ".mp3", "static")
		bgm:setLooping(true)
		bgm:play()
	end
	muswitch("Fate At Your Fingertips")

	function red() love.graphics.setColor(1, 0, 0) end
	function orange() love.graphics.setColor(1, 0.5, 0) end
	function yellow() love.graphics.setColor(1, 1, 0) end
	function green() love.graphics.setColor(0, 1, 0) end
	function blue() love.graphics.setColor(0, 0, 1) end
	function purple() love.graphics.setColor(0.5, 0, 1) end
	function white() love.graphics.setColor(1, 1, 1) end

	dial = {}
	dial.norman = cltk.dialogueInit("dialogue/norman.txt", love)
end

function love.update(dt)
	if game.state == 1 then
		if cltk.button(1, love, 0, 200, 200, 300) then
			game.state = 4
		end
	end
	if game.state == 2 then
	end
	if game.state == 4 then

		if cltk.button(1, love, 25, 525, 75, 575) then
			game.stored.levels = love.filesystem.getDirectoryItems("levels")
			game.stored.levels.names = {}
			for i, v in ipairs(game.stored.levels) do
				local dat = love.filesystem.load("levels/" .. v)()
				game.stored.levels.names[i] = dat.meta.name
			end
		end

		for i, v in ipairs(game.stored.levels) do
			if cltk.button(1, love, 120, 152, i*64, i*64+32) then
				game.state = 4.1
				muswitch("All Aboard")
				game.stored.levels = {}
				game.stored.levels.current = love.filesystem.load("levels/" ..v)()
				bg = love.graphics.newImage("sprites/backgrounds/trainbg.png")
			end
		end

	end
end

function love.draw()
	if game.state == 1 then

		-- Title screen

		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(title, 0, 0)

		red()
		love.graphics.rectangle("fill", 0, 200, 200, 100)
		love.graphics.setColor(0, 0, 1)

		blue()
		love.graphics.rectangle("fill", 0, 350, 200, 100)

	elseif game.state == 2 then

		-- Playing a level

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
end