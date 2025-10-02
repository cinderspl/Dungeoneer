-- Cinder's Love2D Toolkit
-- No copyright :3 CinderSPL 2025
-- Notice: The entire Love2D engine must be passed as an argument in every function - else Love2D wouldn't be recognized; even if the Love2D interpreter is used. Take a shot every time I say Love2D. For the functions here, this is always the second argument.

cltk = {}

function cltk.button(button, love, lx, rx, ty, by)
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  if love.mouse.isDown(button) and x > lx and x < rx and y > ty and y < by then
    return true
  else
    return false
  end
end

function cltk.dialogueInit(file, love)
  full = {}
  for i in love.filesystem.lines(file) do
    table.insert(full,i)
  end
  return full
end

function cltk.dialogue (char, love, lx, rx, ty, by, i, sx, sy)
  local line = char.text[i]
  local sx = sx or 1
  local sy = sy or 1
  -- char: the dialogue data of the character making the statement
  love.graphics.setColor(char.br, char.bg, char.bb)
  love.graphics.rectangle("fill", lx, ty, rx-lx, by-ty)
  love.graphics.setColor(char.r, char.g, char.b)
  love.graphics.printf(line, lx, ty, (rx-lx)/2, "left", 0, sx, sy)
  love.graphics.setColor(1,1,1)
end

function cltk.bossbar (name, love, hp, maxhp)
  local height, width = love.window.getMode()
  love.graphics.setColor(1,0.5,0.5)
  love.graphics.printf(name, width/2, 0, width/2, "center")
  love.graphics.setColor(0.5,0,0)
  local rpercent = (hp / maxhp)
  local rwidth = width - (width / 10)
  rpercent = rpercent * rwidth
  love.graphics.rectangle("fill", width/10, 20, rwidth, 20)
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("fill", width/10, 20, rpercent, 20)
  love.graphics.setColor(1,1,1)
end

function cltk.sfx(filepath, love)
  local s = love.audio.newSource(filepath, "static")
  s:play()
  s = nil
end

function cltk.distance(x1, x2, y1, y2)
  return math.abs((x1 - x2)^2 + (y1 - y2)^2)
end


return cltk