require("lib/essential")
require("lib/ui/ui")

UIState = class("UIState", State)

function UIState:initialize ()
	super.initialize(self)
	self.ui = UI.load("ui/states/ui/mainvbox.lml")
end

function UIState:update (ref, dt)
	super.update(self, ref, dt)
	love.graphics.setCaption(love.graphics.getCaption() .. ": UI State")
end

function UIState:draw (ref)
	super.draw(self, ref)
end

function UIState:mousepressed (ref, x, y, button)
end

function UIState:mousereleased (ref, x, y, button)
end
