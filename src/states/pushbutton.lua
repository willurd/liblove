require("lib/essential")
require("lib/graphics/utils")
require("lib/graphics/color")
require("lib/states/state")
require("lib/ui/pushbutton")

PushButtonState = class("PushButtonState", State)

function PushButtonState:initialize ()
	super.initialize(self)
	local width, height = dimensions()
	self.pushbutton = PushButton:new(Vector2:new(width/2, height/2), 40, 20, Color.WHITE:copy(), 50)
	self.pushbutton:setHeight(20)
end

function PushButtonState:update (ref, dt)
	super.update(self, ref, dt)
	self.pushbutton:update(dt)
end

function PushButtonState:draw (ref)
	super.draw(self, ref)
	self.pushbutton:draw()
end

function PushButtonState:mousepressed (ref, x, y, button)
	if button ~= "l" then return end
	if self.pushbutton:intersectsWithPoint(x, y) then
		self.pushbutton:press()
	end
end

function PushButtonState:mousereleased (ref, x, y, button)
	if button ~= "l" then return end
	if self.pushbutton.pressed then
		self.pushbutton:release()
	end
end
