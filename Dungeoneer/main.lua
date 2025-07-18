sprite = require "sprite"

function love.load()
  players = {}
  loadplayer({head=1, torso=1, legs=1, eyes=1, name="Rosa", color1={1, 0.6, 0.8}, color2={0.5, 0.6, 1}, color3={1, 0.9, 0.6}, color4={0.9, 0.3, 0.8}, color5={1, 0.7, 1}})
end

function loadplayer(data)
	local temp = {}
	temp = data
	temp.X = 400
	temp.Y = 300
	temp.legs = love.graphics.newImage("sprites/" .. sprite.l[temp.legs])
	temp.torso = love.graphics.newImage("sprites/" .. sprite.t[temp.torso])
	temp.hair = love.graphics.newImage("sprites/" .. sprite.ha[temp.head])
	temp.head = love.graphics.newImage("sprites/" .. sprite.h[temp.head])
	temp.eyes = love.graphics.newImage("sprites/" .. sprite.e[temp.eyes])
	players[#players+1] = temp
end

function love.update(dt)
end

function love.draw()
	for i, v in ipairs(players) do
		love.graphics.setColor(v.color1[1], v.color1[2], v.color1[3])
		love.graphics.draw(v.torso, v.X-16, v.Y-12)
		love.graphics.printf(v.name, v.X-16, v.Y-48, 100)
		love.graphics.setColor(v.color2[1], v.color2[2], v.color2[3])
		love.graphics.draw(v.legs, v.X-16, v.Y+12)
		love.graphics.setColor(v.color3[1], v.color3[2], v.color3[3])
		love.graphics.draw(v.head, v.X-16, v.Y-36)
		love.graphics.setColor(v.color5[1], v.color5[2], v.color5[3])
		love.graphics.draw(v.eyes, v.X-16, v.Y-36)
		love.graphics.setColor(v.color4[1], v.color4[2], v.color4[3])
		love.graphics.draw(v.hair, v.X-16, v.Y-36)
	end
end