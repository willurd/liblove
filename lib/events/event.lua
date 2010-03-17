require("lib/essential")

Event = class("Event")

Event.INITIALIZE = "initialize"

function Event:initialize (type)
	self.type = type
end

function Event:copy ()
	return Event:new(self.type)
end
