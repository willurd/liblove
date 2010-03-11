require('lib/essential')
require('lib/math/vector2')
require('lib/graphics/color')

Rect = class('Rect')

Rect.DEFAULT_POSITION  = Vector2:new(0, 0)
Rect.DEFAULT_WIDTH     = 1
Rect.DEFAULT_HEIGHT    = 1
Rect.DEFAULT_DRAW_MODE = "fill"
Rect.DEFAULT_COLOR     = Color.WHITE

function Rect:initialize (position, width, height, color, drawMode)
	self.position = position or Rect.DEFAULT_POSITION:copy()
	self.width    = width    or Rect.DEFAULT_WIDTH
	self.height   = height   or Rect.DEFAULT_HEIGHT
	self.color    = color    or Rect.DEFAULT_COLOR
	self.drawMode = drawMode or Rect.DEFAULT_DRAW_MODE
end

function Rect:intersectsWithPoint (x, y)
	local p = self.position
	return x >= p.x and
		   y >= p.y and
		   x <= p.x + self.width and
		   y <= p.y + self.height
end

function Rect:intersectsWithRect (rect)
	error("Not implemented")
end

function Rect:intersectsWithCircle (circle)
	local p = self.position
	local hw = self.width / 2
	local hh = self.height / 2
	local dx = math.abs(circle.position.x - p.x - hw)
	local dy = math.abs(circle.position.y - p.y - hh)
	
	if dx > (hw + circle.radius) then return false end
	if dy > (hh + circle.radius) then return false end
	
	if dx <= hw then return true end
	if dy <= hh then return true end
	
	local cd = ((dx - hw) ^ 2) + ((dy - hh) ^ 2)
	return cd <= circle.radius ^ 2
end

function Rect:draw (color)
	local p = self.position
	color = color or self.color
	color:set()
	love.graphics.rectangle(self.drawMode, p.x, p.y, self.width, self.height)
end
