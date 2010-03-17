require("lib/essential")
require("lib/ui/component")

UIContainer = class("UIContainer", UIComponent)

function UIContainer:initialize (...)
	super.initialize(self, ...)
end

function UIContainer:update (dt)
	super.update(self, dt)
end

function UIContainer:draw ()
	super.draw(self)
end
