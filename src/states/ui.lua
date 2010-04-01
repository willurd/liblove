require("lib/essential")
require("lib/states/state")
require("lib/ui/ui")

UIState = class("UIState", State)

function UIState:initialize ()
	super.initialize(self)
	self.ui = UI.load("ui/states/ui/acanvas.lml")
end

function UIState:update (ref, dt)
	super.update(self, ref, dt)
	love.graphics.setCaption(love.graphics.getCaption() .. ": UI State")
	self.ui:update(dt)
end

function UIState:draw (ref)
	super.draw(self, ref)
	self.ui:draw()
end

function UIState:mousepressed (ref, x, y, button)
end

function UIState:mousereleased (ref, x, y, button)
end
