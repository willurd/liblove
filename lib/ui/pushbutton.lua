require("lib/essential")
require("lib/math/vector2")
require("lib/graphics/color")
require("lib/graphics/rect")
require("lib/graphics/circle")

PushButton = class("PushButton")

PushButton.DEFAULT_POSITION   = Vector2:new(0, 0)
PushButton.DEFAULT_RADIUS     = 20
PushButton.DEFAULT_MAX_HEIGHT = 10
PushButton.DEFAULT_COLOR      = Color.WHITE:copy()
PushButton.DEFAULT_SEGMENTS   = 50

function PushButton:initialize (position, radius, maxHeight, color, segments)
	self.position  = position  or PushButton.DEFAULT_POSITION:copy()
	self.radius    = radius    or PushButton.DEFAULT_RADIUS
	self.maxHeight = maxHeight or PushButton.DEFAULT_MAX_HEIGHT
	self.color     = color     or PushButton.DEFAULT_COLOR
	self.segments  = segments  or PushButton.DEFAULT_SEGMENTS
	
	local p = self.position
	self.rect   = Rect:new(Vector2:new(0, 0), self.radius*2, 20, self.color)
	self.circle = Circle:new(Vector2:new(p.x, p.y), self.radius, self.segments, self.color)
	self.bottomCircle = Circle:new(Vector2:new(p.x, p.y), self.radius, self.segments, self.color)
	
	self.pressed = false
	
	self:setHeight(0)
end

function PushButton:intersectsWithPoint (x, y)
	return self.circle:intersectsWithPoint(x, y)
end

function PushButton:setHeight (height)
	self.height = height
	local h = self.height
	local p = self.position
	self.bottomCircle.position = p
	self.circle.position = Vector2:new(p.x, p.y - h)
	self.rect.position = Vector2:new(p.x - self.radius, p.y - self.height)
end

function PushButton:update (dt)
	
end

function PushButton:draw ()
	love.graphics.push()
	love.graphics.scale(1, 0.5)
	love.graphics.translate(0, self.position.y)
	if not self.pressed and self.height ~= 0 then
		local c = self.color
		c = Color:new(c.r-40, c.g-40, c.b-40, c.a)
		self.rect.color = c
		self.bottomCircle.color = c
		self.rect:draw()
		self.bottomCircle:draw()
	end
	self.circle.color = self.color
	self.circle:draw()
	love.graphics.pop()
end

function PushButton:press ()
	self.pressed = true
	self.savedHeight = self.height
	self:setHeight(0)
end

function PushButton:release ()
	self.pressed = false
	self:setHeight(self.savedHeight)
	self.savedHeight = nil
end
