require("lib/essential")
require("lib/states/state")
require('lib/graphics/rect')
require('lib/graphics/color')
require('src/movingcircle')

PhysicsState = class("PhysicsState", State)

function PhysicsState:initialize ()
	super.initialize(self)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	self.circle = MovingCircle:new(nil, Vector2:new(430, 230), 20, 50, Color.BLUE:copy(), "fill")
	self.rect = Rect:new(Vector2:new(width/2, height/2), 60, 40, Color.WHITE:copy(), "fill")
end

function PhysicsState:update (ref, dt)
	super.update(self, ref, dt)
	love.graphics.setCaption(love.graphics.getCaption() .. ": Physics State")
	self.circle:update(dt, self.rect)
end

function PhysicsState:draw (ref)
	super.draw(self, ref)
	self.rect:draw()
	self.circle:draw()
	if self.circle:intersectsWithRect(self.rect) then
		Color.WHITE:set()
		love.graphics.print("Circle intersects with rect", 30, 30)
	end
end
