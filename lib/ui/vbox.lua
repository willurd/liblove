require("lib/essential")
require("lib/ui/box")

UIVBox = class("UIVBox", UIBox)

function UIVBox:initialize (...)
	super.initialize(self, ...)
end

function UIVBox:update (dt)
	super.update(self, dt)
end

function UIVBox:draw ()
	super.draw(self)
end
