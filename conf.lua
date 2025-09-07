function love.conf(t)
	t.modules.physics = false

	t.identity = "Dungeoneer"

	t.window.title = "Dungeoneer"
	t.window.icon = "sprites/icon.png"
	t.window.resizable = true
	t.window.minheight = 600
	t.window.minwidth = 800
end