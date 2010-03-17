require("lib/essential")
require("lib/ui/box")
require("lib/graphics/color")

UIVBox = class("UIVBox", UIBox)

UIVBox.ATTR_HANDLERS = {
	verticalGap = tonumber
}

function UIVBox:initialize (...)
	super.initialize(self, ...)
	
	-- Default attributes
	self:updateAttrs({
		verticalGap = 0,
	})
end

function UIVBox:update (dt)
	local y = self.y + self.paddingTop
	for _,child in ipairs(self.children) do
		child.x = self.x + self.paddingLeft
		child.y = y
		y = y + child.height + self.verticalGap
	end
	super.update(self, dt)
end

function UIVBox:draw ()
	self.color:set()
	local width = tonumber(self.width)
	local height = tonumber(self.height)
	love.graphics.rectangle(self.drawMode, self.x, self.y, width, height)
	super.draw(self)
end
