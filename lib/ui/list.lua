require("lib/essential")
require("lib/ui/component")

UIList = class("UIList", UIComponent)

function UIList:initialize (...)
	super.initialize(self, ...)
end

function UIList:update (dt)
	super.update(self, dt)
end

function UIList:draw ()
	super.draw(self)
end
