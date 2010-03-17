require("lib/essential")
require("lib/ui/box")

UIVBox = class("UIVBox", UIBox)

function UIVBox:initialize (...)
	super.initialize(self, ...)
end

function UIVBox:update (dt)
	
end

function UIVBox:draw ()
	
end

function UIVBox:dosomething ()
	print('in dosomething(): ' .. tostring(self.verticalGap))
end
