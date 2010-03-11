require('lib/essential')
require('lib/graphics/circle')
require('lib/math/vector2')

MovingCircle = class('MovingCircle', Circle)

MovingCircle.DEFAULT_VELOCITY = Vector2:new(0, 0)
MovingCircle.ARROW_FORCE = 1000

function MovingCircle:initialize (velocity, position, radius, segments, color, drawMode)
	super.initialize(self, position, radius, segments, color, drawMode)
	self.velocity = velocity or MovingCircle.DEFAULT_VELOCITY:copy()
end

function MovingCircle:update (dt, rect)
	self:collideWithRect(rect)
	
	local force = (MovingCircle.ARROW_FORCE * dt)
	local stopForce = force * 3
	
	if love.keyboard.isDown('up') then
		if self.velocity.y > stopForce then
			self.velocity.y = stopForce
		else
			self.velocity.y = self.velocity.y - force
		end
	end
	if love.keyboard.isDown('down') then
		if self.velocity.y < -stopForce then
			self.velocity.y = -stopForce
		else
			self.velocity.y = self.velocity.y + force
		end
	end
	if love.keyboard.isDown('left') then
		if self.velocity.x > stopForce then
			self.velocity.x = stopForce
		else
			self.velocity.x = self.velocity.x - force
		end
	end
	if love.keyboard.isDown('right') then
		if self.velocity.x < -stopForce then
			self.velocity.x = -stopForce
		else
			self.velocity.x = self.velocity.x + force
		end
	end
	
	self.position = self.position + (self.velocity * dt)
end

function MovingCircle:collideWithRect (rect)
	if not self:intersectsWithRect(rect) then return end
end
