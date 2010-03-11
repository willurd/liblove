-- This example illustrates some basic usage of MiddleClass, which is an
-- OOP implementation for Lua, in Lua

require('lib/essential')

Person = class('Person')

function Person:initialize (name)
	self.name = name
end

function Person:speak (what)
	printff('%s says: %s\n', self.name, what or '')
end
