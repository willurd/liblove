require("lib/essential")
require("lib/xml/xml")
require("lib/events/eventdispatcher")
require("lib/graphics/rect")
require("lib/graphics/color")
require("lib/math/vector2")

UIComponent = class("UIComponent", EventDispatcher)

local function autoField (value)
	if type(value) == "number" then return value end
	if value:match("%%") then return value end
	if value == "auto" then return value end
	return tonumber(value)
end

UIComponent.ATTR_HANDLERS = {
	color = function (value)
		return Color.fromString(value)
	end,
	x = tonumber,
	y = tonumber,
	width = autoField,
	height = autoField,
	paddingTop = tonumber,
	paddingRight = tonumber,
	paddingBottom = tonumber,
	paddingLeft = tonumber,
	fontSize = tonumber
}

function UIComponent:initialize (parent)
	super.initialize(self)
	self.children = {}
	self.parent = parent
	self.attrs = {}
	self.namespaces = {}
	self.mouseIsOver = false
	
	-- Default attributes
	self:updateAttrs({
		x = 0,
		y = 0,
		width = 0, -- "auto" ?
		height = 0, -- "auto" ?
		paddingTop = 0,
		paddingRight = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		fontSize = 12,
		color = "#ffffff",
		drawMode = "fill"
	})
end

function UIComponent:handleAttr (name, value, class)
	class = class or self.class
	if class.ATTR_HANDLERS then
		for key,handler in pairs(class.ATTR_HANDLERS) do
			if key == name then
				return handler(value), true
			end
		end
	end
	class = class.superclass
	if class and class.handleAttr then
		return class.handleAttr(self, name, value, class)
	end
	return nil, false
end

function UIComponent:updateAttrs (attrs)
	if not attrs then return end
	table.update(self.attrs, attrs)
	for key,value in pairs(attrs) do
		local namespaceMatch = string.match(key, "^xmlns:(.*)$")
		local eventListenerMatch = string.match(key, "^on(%u.*)$")
		if namespaceMatch then
			table.insert(self.namespaces, {namespaceMatch, value})
		elseif eventListenerMatch then
			self:addEventListener(Event[eventListenerMatch:upper()], self, value)
		else
			local newValue, matched = self:handleAttr(key, value)
			self[key] = matched and newValue or value
		end
	end
end

function UIComponent:doScript (script)
	script = string.gsub(script, "^%s*<!%[CDATA%[(.*)%]%]>%s*$", "%1")
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
	local b = self:getBounds()
	local mx, my = love.mouse.getPosition()
	if b:intersectsWithPoint(mx, my) then
		if not self.mouseIsOver then
			self.mouseIsOver = true
			self:dispatchEvent(Event:new(Event.MOUSEOVER, {x=mx, y=my}))
		end
	else
		if self.mouseIsOver then
			self.mouseIsOver = false
			self:dispatchEvent(Event:new(Event.MOUSEOUT, {x=mx, y=my}))
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
	if child.id then
		self[child.id] = child
	end
end

-- getters and setters
UIComponent:getterSetter("x", 0)
UIComponent:getterSetter("y", 0)
UIComponent:setter("width")
UIComponent:setter("height")

function UIComponent:getBounds ()
	return Rect:new(Vector2:new(self:getX(), self:getY()),
		self:getWidth(), self:getHeight())
end

function UIComponent:getWidth ()
	local w = self.width and self.width or "auto"
	if type(w) == "number" then return w end
	if w == "auto" then w = "100%" end
	local p = w:match("^(.*)%%")
	local width = 0
	if self.parent then
		local b = self.parent:getBounds()
		print(b)
		width = b.width
	else
		local w, h = dimensions()
		width = w
	end
	return width * (p / 100)
end

function UIComponent:getHeight ()
	local h = self.height and self.height or "auto"
	if type(h) == "number" then return h end
	if h == "auto" then h = "100%" end
	local p = h:match("^(.*)%%")
	local height
	if self.parent then
		local b = self.parent:getBounds()
		height = b.height
	else
		local w, h = dimensions()
		height = h
	end
	return height * (p / 100)
end
