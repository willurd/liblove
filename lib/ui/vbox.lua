require("lib/essential")
require("lib/ui/box")
require("lib/graphics/color")

UIVBox = class("UIVBox", UIBox)

function UIVBox:initialize (...)
	super.initialize(self, ...)
	self.color = Color.WHITE
end

function UIVBox:update (dt)
	super.update(self, dt)
end

function UIVBox:draw ()
	super.draw(self)
	self.color:set()
	
	local x = tonumber(self.x)
	local y = tonumber(self.y)
	local width = tonumber(self.width)
	local height = tonumber(self.height)
	love.graphics.rectangle(self.drawMode, x, y, width, height)
end
