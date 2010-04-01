love.filesystem.setIdentity("liblovedemo")

function love.conf (c)
	c.title = "liblove demo"
	c.author = "willurd"
	
	c.modules.audio 	= false
	c.modules.event 	= true
	c.modules.graphics 	= true
	c.modules.image 	= true
	c.modules.joystick 	= false
	c.modules.keyboard 	= true
	c.modules.mouse 	= true
	c.modules.physics 	= false
	c.modules.sound 	= false
	c.modules.timer 	= true
	
	c.screen.fsaa = 0
	c.screen.fullscreen = false
	c.screen.height = 600
	c.screen.width = 800
	c.screen.vsync = true
end
