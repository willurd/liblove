require("lib/essential")

Event = class("Event")

Event.INITIALIZE = "event_initialize"
Event.UPDATE = "event_update"
Event.DRAW = "event_draw"
Event.MOUSEOVER = "event_mouseOver"
Event.MOUSEOUT = "event_mouseOut"

function Event:initialize (type, params)
	self.type = type
	self.params = params or {}
end

function Event:copy ()
	return Event:new(self.type, self.params)
end
