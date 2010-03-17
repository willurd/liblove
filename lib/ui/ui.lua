require("lib/ui/component")
require("lib/ui/container")
--require("lib/ui/canvas")
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
	box       = UIBox,
	vbox      = UIVBox,
	list      = UIList,
	label     = UILabel
}

local function createComponent (xml, isroot)
	isroot = isroot ~= nil and isroot or false
	local ComponentClass = UI.COMPONENTS[xml.name]
	
	if ComponentClass == nil then
		error("Unknown component: " .. xml.name)
	end
	
	local component = ComponentClass:new(xml.attrs, nil, isroot)
	
	for _,child in ipairs(xml) do
		if child.name == "script" then
			local script = string.gsub(child[1], "^%s*<!%[CDATA%[(.*)%]%]>%s*$", "%1")
			component:doScript(script)
		else
			component:addChild(createComponent(child))
		end
	end
	
	component:initAttrs()
	component:dispatchEvent(Event:new(Event.INITIALIZE))
	return component
end

function UI.load (filename)
	xml = xml_collect(love.filesystem.read(filename))
	if #xml < 1 then
		error("Trying to load an XML file with no root element")
	elseif #xml > 1 then
		error("Trying to load an XML file with more than one root element")
	end
	
	local root = xml[1]
	return createComponent(root, true)
end
