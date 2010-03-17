require("lib/essential")
require("lib/xml/xml")
require("lib/events/eventdispatcher")

UIComponent = class("UIComponent", EventDispatcher)

function UIComponent:initialize (attrs, children, isRoot)
	super.initialize(self)
	self.attrs    = attrs    or {}
	self.children = children or {}
	self.isRoot   = isRoot   or false
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
end

function UIComponent:draw ()
	self:dispatchEvent(Event:new(Event.DRAW))
end

function UIComponent:addChild (child)
	table.insert(self.children, child)
end
