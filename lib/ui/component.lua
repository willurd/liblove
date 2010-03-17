require("lib/essential")
require("lib/xml/xml")
require("lib/events/eventdispatcher")
require("lib/graphics/rect")
require("lib/graphics/color")
require("lib/math/vector2")

UIComponent = class("UIComponent", EventDispatcher)

UIComponent.ATTR_HANDLERS = {
	color = function (value)
		return Color.fromString(value)
	end,
	x = tonumber,
	y = tonumber,
	paddingTop = tonumber,
	paddingRight = tonumber,
	paddingBottom = tonumber,
	paddingLeft = tonumber,
	fontSize = tonumber
}

function UIComponent:initialize (children, isRoot)
	super.initialize(self)
	self.children = children or {}
	self.isRoot = isRoot   or false
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
		color = "#ffffff",
		drawMode = "fill"
	})
end

function UIComponent:handleAttr (name, value, class)
	class = class or self.class
	if self.class.ATTR_HANDLERS then
		for key,handler in pairs(self.class.ATTR_HANDLERS) do
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
	if child.id then
		self[child.id] = child
	end
end
