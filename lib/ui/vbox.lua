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
	local b = self:getBounds()
	local p = b.position
	local y = p.y + self.paddingTop
	for _,child in ipairs(self.children) do
		child.x = p.x + self.paddingLeft
		child.y = y
		y = y + child:getHeight() + self.verticalGap
	end
	super.update(self, dt)
end

function UIVBox:draw ()
	self.color:set()
	local b = self:getBounds()
	local p = b.position
	love.graphics.rectangle(self.drawMode, p.x, p.y, b.width, b.height)
	super.draw(self)
end
