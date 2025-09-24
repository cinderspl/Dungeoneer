function love.load()

	function round(x)
		-- taken from lume, remind me to credit them before the game releases
		return math.ceil(x - 0.5)
	end

	require "cltk"
	game = {}
	game.player = {}

	if love.filesystem.getInfo("stored/player.lua") then
		game.player = love.filesystem.load("stored/player.lua")()
	end

	game.stored = {} -- things the game has to rememember, like the level list or the player names
	game.stored.current = {}
	game.state = 1 -- game state 1 is for the title screen, 2 is for gameplay, 3 is for level designing, 4 is for the library. decimals may be used for more specific states (like searching the catalogue when designing a level)

	bgm = love.audio.newSource("ost/Fate At Your Fingertips.mp3", "static")
	function muswitch(track)
		bgm:stop()
		bgm = love.audio.newSource("ost/" .. track .. ".mp3", "static")
		bgm:setLooping(true)
		bgm:play()
		mutext = {track, 3}
	end

	function setstate(state)
		if state == 1 then
			rel_x = 64
			rel_y = 64
			game.state = 1
			muswitch("Fate At Your Fingertips")

		elseif state == 1.1 then
			if not returnbutton then
				returnbutton = love.graphics.newImage("sprites/menus/return.png")
			end
			game.state = 1.1

		elseif state == 1.2 then
			if not returnbutton then
				returnbutton = love.graphics.newImage("sprites/menus/return.png")
			end
			game.state = 1.2

		elseif state == 2 then

			-- Loading sprites the game will need constantly so they don't have to be loaded each frame
			game.stored.sprites = {}
			game.stored.sprites.head = love.graphics.newImage("sprites/player/head.png")
			game.stored.sprites.torso = love.graphics.newImage("sprites/player/torso.png")
			game.stored.sprites.rarm = love.graphics.newImage("sprites/player/rarm.png")
			game.stored.sprites.rarm_raised = love.graphics.newImage("sprites/player/rarm_raised.png")
			game.stored.sprites.larm = love.graphics.newImage("sprites/player/larm.png")
			game.stored.sprites.larm_raised = love.graphics.newImage("sprites/player/larm_raised.png")
			game.stored.sprites.legs = love.graphics.newImage("sprites/player/legs.png")

			local lvl = game.stored.levels.current
			game.stored.levels = {}
			game.stored.levels.current = lvl

			-- Loads every sprite the level needs so it doesn't need to be constantly loaded
			for y, row in ipairs(lvl.data.map) do
				for x, tile in ipairs(row) do
					if tile ~= 0 then
						load('game.stored.sprites.' .. tile.type .. ' = ' .. 'love.graphics.newImage("sprites/elements/' .. game.stored.levels.current.settings.theme .. "_" .. tile.type .. '.png")')()
					end
				end
			end

			game.player.x = game.stored.levels.current.data.startpos[1]
			game.player.y = game.stored.levels.current.data.startpos[2]
			game.player.speed = 5
			game.player.dir = "down"

			muswitch(game.stored.levels.current.settings.track)
			bg = love.graphics.newImage("sprites/backgrounds/" .. game.stored.levels.current.settings.theme .. ".png")
			game.state = 2

		elseif state == 3 then
			map = {}
			for y=0, 30 do
				map[y] = {}
				for x=0, 30 do
					map[y][x] = 0
				end
			end
			game.stored.selectedtile = "Sign"
			game.state = 3

		elseif state == 4 then
			if not returnbutton then
				returnbutton = love.graphics.newImage("sprites/menus/return.png")
			end
			game.stored.levels = love.filesystem.getDirectoryItems("levels")
			game.stored.levels.names = {}
			for i, v in ipairs(game.stored.levels) do
				local dat = love.filesystem.load("levels/" .. v)()
				game.stored.levels.names[i] = dat.meta.name
			end
			bg = love.graphics.newImage("sprites/backgrounds/library.png")
			muswitch("Library")
			game.state = 4

		elseif state == 4.1 then
			map = game.stored.levels.current.data.map
			bg = love.graphics.newImage("sprites/backgrounds/trainbg.png")
			muswitch("All Aboard!")
			game.state = 4.1
		end
		love.timer.sleep(0.5)
	end

	function red() love.graphics.setColor(1, 0, 0) end
	function orange() love.graphics.setColor(1, 0.5, 0) end
	function yellow() love.graphics.setColor(1, 1, 0) end
	function green() love.graphics.setColor(0, 1, 0) end
	function blue() love.graphics.setColor(0, 0, 1) end
	function purple() love.graphics.setColor(0.5, 0, 1) end
	function magenta() love.graphics.setColor(1, 0, 1) end
	function pink() love.graphics.setColor(1, 0.8, 1) end
	function white() love.graphics.setColor(1, 1, 1) end
	function gray() love.graphics.setColor(0.5, 0.5, 0.5) end
	function black() love.graphics.setColor(0, 0, 0) end

	function hex2rgb(hex)
		-- Credit to Jason Bradley!
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)) .. "_" ..  tonumber("0x"..hex:sub(3,4)) .. "_" .. tonumber("0x"..hex:sub(5,6))
end

	camera = require "camera"

	char = {}

	char.norman = {
		br = 0.8, bg = 3, bb = 0,
		r = 0.7, g = 0, b = 0.9
	}

	char.sign = {
		br = 0.5, bg = 0.5, bb = 0.5,
		r = 0, g = 0, b = 0
	}

	dial = {}
	dial.norman = cltk.dialogueInit("dialogue/norman.txt", love)

	cltk.sfx("sfx/cinderSPL Presents~.mp3", love)
	love.timer.sleep(1)

	setstate(1)
end

function love.update(dt)

	rel_x = love.graphics.getWidth() / 12.5
	rel_y = love.graphics.getHeight() / 9.375

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
			setstate(4)
			love.timer.sleep(0.5)
		end
		if cltk.button(1, love, 0, 200, 300, 400) then
			cltk.sfx("sfx/lockin.mp3", love)
			setstate(3)
		end
		if cltk.button(1, love, 704, 768, 504, 568) then
			cltk.sfx("sfx/confirm.mp3", love)
			setstate(1.1)
			love.timer.sleep(0.5)
		end
	end

	if game.state == 1.1 then
		if cltk.button(1, love, 32, 96, 504, 568) then
			cltk.sfx("sfx/cancel.mp3", love)
			game.state = 1
			love.timer.sleep(0.5)
		end
		if cltk.button(1, love, 200, 600, 50, 100) then
			game.player.audio.vol = ((love.mouse.getX() - 200) / 4)
			cltk.sfx("sfx/select.mp3", love)
			love.timer.sleep(0.5)
		end
		if cltk.button(1, love, 704, 768, 440, 504) then
			cltk.sfx("sfx/confirm.mp3", love)
			game.state = 1.2
			love.timer.sleep(0.5)
		end
	end

	if game.state == 1.2 then
		if cltk.button(1, love, 32, 96, 504, 568) then
			cltk.sfx("sfx/cancel.mp3", love)
			game.state = 1.1
			love.timer.sleep(0.5)
		end
		if cltk.button(1, love, 100, 200, 200, 250) then
			game.player.video.fov = ((love.mouse.getX() - 100))
			cltk.sfx("sfx/select.mp3", love)
			love.timer.sleep(0.5)
		end
	end

	if game.state == 2 then

		camera:setPosition(game.player.x*rel_x-(love.graphics.getWidth()/2 - rel_x/2)*game.player.video.fov/100, game.player.y*rel_y-(love.graphics.getHeight()/2 - rel_y/2)*game.player.video.fov/100)
		camera.scaleX = game.player.video.fov/100
		camera.scaleY = game.player.video.fov/100

		local fy = math.floor(game.player.y)
		local cy = math.ceil(game.player.y)
		local ry = round(game.player.y)
		local fx = math.floor(game.player.x)
		local cx = math.ceil(game.player.x)
		local rx = round(game.player.x)
		local near = map[ry][rx]
		local ul = map[fy][fx]
		local ur = map[fy][cx]
		local dl = map[cy][fx]
		local dr = map[cy][cx]

		if love.keyboard.isScancodeDown(game.player.controls.move_down) then
			if dl ~= nil and dr ~= nil then
				if dl ~= 0 or dr ~= 0 then
					if (ul == 0 or dl.type ~= "Wall") and (dr == 0 or dr.type ~= "Wall") then
						game.player.y = game.player.y + game.player.speed / 64
						if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "down" end
					end
				else
					game.player.y = game.player.y + game.player.speed / 64
					if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "down" end
				end
			end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_up) then
			if ul ~= nil and ur ~= nil then
				if ul ~= 0 or ur ~= 0 then
					if (ul == 0 or ul.type ~= "Wall") and (ur == 0 or ur.type ~= "Wall") then
						game.player.y = game.player.y - game.player.speed / 64
						if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "up" end
					end
				else
					game.player.y = game.player.y - game.player.speed / 64
					if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "up" end
				end
			end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_left) then
			if ul ~= nil and dl ~= nil then
				if ul ~= 0 or dl ~= 0 then
					if (ul == 0 or ul.type ~= "Wall") and (dl == 0 or dl.type ~= "Wall") then
						game.player.x = game.player.x - game.player.speed / 64
						if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "left" end
					end
				else
					game.player.x = game.player.x - game.player.speed / 64
					if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "left" end
				end
			end
		end

		if love.keyboard.isScancodeDown(game.player.controls.move_right) then
			if ur ~= nil and dr ~= nil then
				if ur ~= 0 or dr ~= 0 then
					if (ur == 0 or ur.type ~= "Wall") and (dr == 0 or dr.type ~= "Wall") then
						game.player.x = game.player.x + game.player.speed / 64
						if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "right" end
					end
				else
					game.player.x = game.player.x + game.player.speed / 64
					if not love.keyboard.isScancodeDown(game.player.controls.strafe) then game.player.dir = "right" end
				end
			end
		end

		if love.keyboard.isScancodeDown(game.player.controls.exit) then
			setstate(1)
		end

		for y, row in ipairs(map) do
			for x, tile in ipairs(row) do
				if tile and tile ~= 0 then
					if tile.type == "Sign" then
						if math.abs((x - game.player.x)^2 +(y - game.player.y)^2) < 1 and love.keyboard.isScancodeDown(game.player.controls.interact) then
								
						end
					end
				end
			end
		end
		if near ~= 0 then
			if near.type == "Water" then
				if near.direction == "down" then
					game.player.y = game.player.y + 4*dt
				elseif near.direction == "up" then
					game.player.y = game.player.y - 4*dt
				elseif near.direction == "right" then
					game.player.x = game.player.x + 4*dt
				elseif near.direction == "left" then
					game.player.x = game.player.x - 4*dt
				end
			end
		end

	end

	if game.state == 3 then
		if love.mouse.isDown(1) then
			map[math.floor(love.mouse.getY()/64)][math.floor(love.mouse.getX()/64)] = {type="Sign"}
		end
	end

	if game.state == 4 then

		if cltk.button(1, love, 725, 775, 525, 575) then
			cltk.sfx("sfx/cancel.mp3", love)
			setstate(1)
		end

		if cltk.button(1, love, 25, 75, 525, 575) then
			cltk.sfx("sfx/confirm.mp3", love)
			game.stored.levels = love.filesystem.getDirectoryItems("levels")
			game.stored.levels.names = {}
			for i, v in ipairs(game.stored.levels) do
				local dat = love.filesystem.load("levels/" .. v)()
				game.stored.levels.names[i] = dat.meta.name
			end
			love.timer.sleep(0.5)
		end

		for i, v in ipairs(game.stored.levels) do
			if cltk.button(1, love, 120, 152, i*64, i*64+32) then
				cltk.sfx("sfx/confirm.mp3", love)
				game.stored.levels = {}
				game.stored.levels.current = love.filesystem.load("levels/" ..v)()
				setstate(4.1)
			end
		end

	end

	if game.state == 4.1 then
		if cltk.button(1, love, 725, 775, 525, 575) then
			cltk.sfx("sfx/lockin.mp3", love)
			setstate(2)
		end
	end
end

function love.draw()
	if game.state == 1 then

		-- Title screen

		if not title then
			title = love.graphics.newImage("sprites/menus/logotemp.png")
		end
		if not settingsbutton then
			settingsbutton = love.graphics.newImage("sprites/menus/settingsenter.png")
		end
		if not musicbutton then
			musicbutton = love.graphics.newImage("sprites/menus/ostenter.png")
		end		

		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(musicbutton, 704, 440)
		love.graphics.draw(settingsbutton, 704, 504)
		love.graphics.draw(title, 0, 0)

		red()
		love.graphics.rectangle("fill", 0, 200, 200, 100)
		love.graphics.setColor(0, 0, 1)

		blue()
		love.graphics.rectangle("fill", 0, 350, 200, 100)

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
		love.graphics.draw(returnbutton, 32, 504)
		love.graphics.draw(settingsbutton, 704, 440)
	elseif game.state == 1.2 then
		blue()
		love.graphics.rectangle("fill", 0, 0, 800, 600)

		purple()
		love.graphics.rectangle("fill", 100, 200, 100, 50)
		red()
		love.graphics.rectangle("fill", 100, 200, game.player.video.fov, 50)
		yellow()
		love.graphics.printf("FOV", 100, 200, 4 * game.player.video.fov, "left", 0, 3 * (game.player.video.fov / 100))
		love.graphics.printf("" .. game.player.video.fov, 100 + game.player.video.fov, 200, 50, "left", 0, 3)

		white()
		love.graphics.draw(returnbutton, 32, 504)
	elseif game.state == 2 then

		-- Playing a level

		camera:set()

		for x=math.floor(game.player.x-8), math.ceil(game.player.x+8) do
  		for y=math.floor(game.player.y-6), math.ceil(game.player.y+6) do
    		love.graphics.draw(bg, (x-1)*rel_x, (y-1)*rel_y, 0, rel_x/64, rel_y/64)
	  	end
		end

		for y, row in ipairs(map) do
			for x, tile in ipairs(row) do
				if tile ~= 0 then
					sp = load("return game.stored.sprites." .. tile.type .. "")
					love.graphics.draw(sp(), x*rel_x, y*rel_y, 0, rel_x/64, rel_y/64)
					if tile.type == "Sign" then
						if cltk.distance(x, game.player.x, y, game.player.y) < 1 and love.keyboard.isScancodeDown(game.player.controls.interact) then
							char.sign.text = {}
							char.sign.text[1] = tile.text
							cltk.dialogue(char.sign, love, (x-1)*64, (x+2)*64, (y-2)*64, (y)*64, 1)
							char.sign.text = nil
						end
					end
				end
			end
		end

		white()
		local c = hex2rgb(game.player.meta.tone)
		local _, _, c1, c2, c3 = string.find(c, "(%d+)_(%d+)_(%d+)")
		love.graphics.setColor(c1/255, c2/255, c3/255)
		love.graphics.draw(game.stored.sprites.head, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		love.graphics.draw(game.stored.sprites.torso, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		if love.keyboard.isScancodeDown(game.player.controls.atk) then
			love.graphics.draw(game.stored.sprites.rarm_raised, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		else
			love.graphics.draw(game.stored.sprites.rarm, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		end
		love.graphics.draw(game.stored.sprites.larm, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		love.graphics.draw(game.stored.sprites.legs, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
		love.graphics.printf(game.player.meta.display, game.player.x*rel_x, game.player.y*rel_y-20, rel_x, "justify", 0, rel_x/64, rel_y/64)
		for k, t in pairs(game.player.gear) do
			for i, v in ipairs(t) do
				local c = hex2rgb(v.color)
				local _, _, c1, c2, c3 = string.find(c, "(%d+)_(%d+)_(%d+)")
				love.graphics.setColor(c1/255, c2/255, c3/255)
				local sp = love.graphics.newImage("sprites/player/" .. v.id .. ".png")
				love.graphics.draw(sp, game.player.x*rel_x, game.player.y*rel_y, 0, rel_x/64, rel_y/64)
			end
		end
		camera:unset()

	elseif game.state == 3 then

		-- Designing a level 
		
		for y, row in ipairs(map) do
			for x, tile in ipairs(row) do
				if tile ~= 0 then
					if tile.type == "Sign" then
						local sp = love.graphics.newImage("sprites/elements/sign.png")
						love.graphics.draw(sp, x*64, y*64)
					end
				end
			end
		end

	elseif game.state == 4 then

		-- Library
		white()
		love.graphics.draw(bg, 0, 0, 0, 4, 4)

		local ntable = love.graphics.newImage("sprites/norman/table.png")
		love.graphics.draw(ntable, 150, 450, 0, 2)
		local fetch = love.graphics.newImage("sprites/menus/fetchlevelsbutton.png")
		love.graphics.draw(fetch, 25, 525)

		for i, v in ipairs(game.stored.levels.names) do
			blue()
			love.graphics.rectangle("fill", 120, i*64, 32, 32)
			love.graphics.printf(v, 168, i*64, 632)
		end

		red()
		love.graphics.rectangle("fill", 725, 525, 50, 50)

		elseif game.state == 4.1 then

			-- Preparing to enter level

			white()
			love.graphics.draw(bg, 0, 0)

			love.graphics.setColor(1, 1, 1, 0.5)
			love.graphics.rectangle("fill", 450, 50, 300, 300)

			red()
			love.graphics.rectangle("fill", 725, 525, 50, 50)
	end


	-- Popup stuff like music text

	if mutext then
		love.graphics.setColor(1, 0, 0, mutext[2]/2)
		love.graphics.printf("cinderspl ~ " .. mutext[1], 0, 568, 300, "left", 0, 2, 2)
	end
	white()

end

function love.quit()

end

