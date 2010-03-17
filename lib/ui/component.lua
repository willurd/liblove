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

function UIComponent:update (dt)
	
end

function UIComponent:draw ()
	
end

function UIComponent:initAttrs ()
	for key,value in pairs(self.attrs) do
		local match = string.match(key, "on(%u.*)")
		if match then print(10, match, match:upper()) end
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
	script = loadstring(script)
	script()
	_G.self = t
end

function UIComponent:addChild (child)
	table.insert(self.children, child)
end
