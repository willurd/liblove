require('lib/essential')
require('lib/graphics/color')
require('lib/math/vector2')

Circle = class('Circle')

Circle.DEFAULT_POSITION  = Vector2:new(0, 0)
Circle.DEFAULT_RADIUS    = 1
Circle.DEFAULT_SEGMENTS  = 8
Circle.DEFAULT_DRAW_MODE = "fill"
Circle.DEFAULT_COLOR     = Color.WHITE

function Circle:initialize (position, radius, segments, color, drawMode)
	self.position = position or Circle.DEFAULT_POSITION:copy()
	self.radius   = radius   or Circle.DEFAULT_RADIUS
	self.segments = segments or Circle.DEFAULT_SEGMENTS
	self.color    = color    or Circle.DEFAULT_COLOR
	self.drawMode = drawMode or Circle.DEFAULT_DRAW_MODE
end

function Circle:intersectsWithPoint (x, y)
	local point = (not y and type(x) == "table") and x or Vector2:new(x, y)
	return (self.position - point):length() <= self.radius
end

function Circle:intersectsWithCircle (circle)
	error("Not implemented")
	--[[ something like this...
	local mid = Vector2:new({x=self.x, y=self.y})
	local othermid = Vector2:new({x=circle.x, y=circle.y})
	return (mid - othermid):length() <= (self.radius * 2)
	--]]
end

function Circle:intersectsWithRect (rect)
	return rect:intersectsWithCircle(self)
end

function Circle:draw (color)
	color = color or self.color
	color:set()
	love.graphics.circle(self.drawMode, self.position.x, self.position.y,
		self.radius, self.segments)
end
