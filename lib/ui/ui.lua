require("lib/ui/component")
require("lib/ui/container")
require("lib/ui/canvas")
require("lib/ui/box")
require("lib/ui/vbox")
--require("lib/ui/hbox")
require("lib/ui/label")
--require("lib/ui/button")
require("lib/ui/list")

require("lib/xml/xml")
require("lib/events/event")

UI = class("UI")

UI.COMPONENTS = {
	component = UIComponent,
	container = UIContainer,
	canvas    = UICanvas,
	box       = UIBox,
	vbox      = UIVBox,
	list      = UIList,
	label     = UILabel
}

-- This function is big and gross and should be cleaned up
local function createComponent (xml, parent, namespaces)
	namespaces = namespaces or {}
	
	local namespace, name = string.match(xml.name, "(.*)%:(.*)")
	local ComponentClass = UI.COMPONENTS[xml.name]
	
	if ComponentClass ~= nil then
		local component = ComponentClass:new(parent)
		
		for _,child in ipairs(xml) do
			if child.name == "script" then
				component:doScript(child[1])
			end
		end
		
		component:updateAttrs(xml.attrs)
		
		for _,child in ipairs(xml) do
			if child.name ~= "script" then
				component:addChild(createComponent(child, component, component.namespaces))
			end
		end

		component:dispatchEvent(Event:new(Event.INITIALIZE))
		return component
	elseif namespace then
		local n = table.find(namespaces, function (n) return n[1] == namespace end)
		if n then
			local path = n[2]
			local filename = os.join(n[2], name) .. ".lml"
			if love.filesystem.exists(filename) then
				local component = UI.load(filename)
				component:updateAttrs(xml.attrs)
				return component
			else
				error("File does not exist: " .. filename)
			end
		else
			error("Unknown namespace: " .. namespace)
		end
	else
		error("Unknown UI component: " .. xml.name)
	end
end

function UI.load (filename)
	xml = xml_collect(love.filesystem.read(filename))
	if #xml < 1 then
		error("Trying to load an XML file with no root element")
	elseif #xml > 1 then
		error("Trying to load an XML file with more than one root element")
	end
	
	local root = xml[1]
	return createComponent(root)
end
