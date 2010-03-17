require("lib/essential")
require("lib/ui/container")

UIBox = class("UIBox", UIContainer)

function UIBox:initialize (...)
	super.initialize(self, ...)
end

function UIBox:update (dt)
	super.update(self, dt)
end

function UIBox:draw ()
	super.draw(self)
end
