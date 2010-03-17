require("lib/essential")
require("lib/xml/xml")
require("lib/events/eventdispatcher")
require("lib/graphics/rect")
require("lib/math/vector2")

UIComponent = class("UIComponent", EventDispatcher)

function UIComponent:initialize (attrs, children, isRoot)
	super.initialize(self)
	self.attrs    = attrs    or {}
	self.children = children or {}
	self.isRoot   = isRoot   or false
	
	self.mouseIsOver = false
	
	-- Default parameters
	self.x = 0
	self.y = 0
	self.width = 0 -- "auto"
	self.height = 0 -- "auto"
	self.drawMode = "fill"
end

function UIComponent:initAttrs ()
	for key,value in pairs(self.attrs) do
		local match = string.match(key, "^on(%u.*)$")
		if match then
			self:addEventListener(Event[match:upper()], self, value)
		else
			self[key] = value
		end
	end
end

function UIComponent:doScript (script)
	local t = _G.self
	_G.self = self
	assert(loadstring(script))()
	_G.self = t
end

function UIComponent:update (dt)
	self:dispatchEvent(Event:new(Event.UPDATE, {dt=dt}))
	for _,child in ipairs(self.children) do
		child:update(dt)
	end
	local x = tonumber(self.x)
	local y = tonumber(self.y)
	local width = tonumber(self.width)
	local height = tonumber(self.height)
	local rect = Rect:new(Vector2:new(x, y), width, height)
	if rect:intersectsWithPoint(love.mouse.getPosition()) then
		if not self.mouseIsOver then
			self.mouseIsOver = true
			self:dispatchEvent(Event:new(Event.MOUSEOVER))
		end
	else
		if self.mouseIsOver then
			self.mouseIsOver = false
			self:dispatchEvent(Event:new(Event.MOUSEOUT))
		end
	end
end

function UIComponent:draw ()
	self:dispatchEvent(Event:new(Event.DRAW))
	for _,child in ipairs(self.children) do
		child:draw(dt)
	end
end

function UIComponent:addChild (child)
	table.insert(self.children, child)
end
