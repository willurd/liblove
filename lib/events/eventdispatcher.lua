require("lib/essential")

EventDispatcher = class("EventDispatcher")

function EventDispatcher:initialize ()
	self.events = {}
end

function EventDispatcher:addEventListener (type, instance, callback)
	if not self.events[type] then
		self.events[type] = {}
	end
	table.insert(self.events[type], {instance, callback})
	return true
end

function EventDispatcher:removeEventListener (type, callback)
	if not self.events[type] then return nil end
	local index = table.find(self.events[type], callback)
	if index == -1 then return false end
	table.remove(self.events[type], index)
	return true
end

function EventDispatcher:dispatchEvent (event)
	if not self.events[event.type] then return nil end
	for _,table in ipairs(self.events[event.type]) do
		local instance, callback = unpack(table)
		if instance[callback] then
			instance[callback](instance, event)
		else
			printff("Error: Attempt to call field '%s' on instance '%s'",
				tostring(callback), tostring(instance))
		end
	end
	return true
end
