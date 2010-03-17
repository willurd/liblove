require("lib/essential")
require("lib/ui/component")
require("lib/graphics/color")

UILabel = class("UILabel", UIComponent)

function UILabel:initialize (...)
	super.initialize(self, ...)
	self.color = Color.BLACK:copy()
end

function UILabel:updateAttrs (attrs)
	super.updateAttrs(self, attrs)
	if attrs.fontSize then
		love.graphics.setFont(self.fontSize)
		self.font = love.graphics.getFont()
		self.height = self.font:getHeight()
	end
end

function UILabel:update (dt)
	
end

function UILabel:draw ()
	self.color:set()
	love.graphics.setFont(self.font)
	love.graphics.print(self.value, self:getX(), self:getY() + self.fontSize)
end
