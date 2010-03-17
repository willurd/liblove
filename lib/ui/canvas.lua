require("lib/essential")
require("lib/ui/container")

UICanvas = class("UICanvas", UIContainer)

function UICanvas:initialize (...)
	super.initialize(self, ...)
end

function UICanvas:update (dt)
	super.update(self, dt)
end

function UICanvas:draw ()
	super.draw(self)
end
