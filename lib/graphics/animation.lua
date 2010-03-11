require("lib/essential")

Animation = class("Animation")

Animation.DEFAULT_MAX_TIMES = nil
Animation.RUN_TIME_INDEX = 1
Animation.CALLBACK_INDEX = 2

function Animation:initialize (frames, maxTimes)
	assert(#frames > 0)
	self.frames = frames
	self.maxTimes = maxTimes or Animation.DEFAULT_MAX_TIMES
	self.times = 0
	self.callbacks = {
		onStart = {},
		onEnd = {},
	}
	self:reset()
end

function Animation:seek (frame)
	self.frame = frame
	self.timeToNextFrame = self.frames[self.frame][Animation.RUN_TIME_INDEX]
end

function Animation:reset ()
	self:seek(1)
	self.playing = false
	self.times = 0
end

function Animation:update (dt)
	if not self.playing then return end
	self.timeToNextFrame = self.timeToNextFrame - dt
	if self.timeToNextFrame <= 0 then
		if self.frame >= #self.frames then
			self:seek(1)
			if type(self.maxTimes) == "number" then
				self.times = self.times + 1
				if self.times == self.maxTimes then
					self:stop()
				end
			end
		else
			self:seek(self.frame + 1)
		end
	end
end

function Animation:draw ()
	if not self.playing then return end
	-- Call the callback function of the current frame.
	self.frames[self.frame][Animation.CALLBACK_INDEX]()
end

function Animation:play ()
	self.playing = true
end

function Animation:pause ()
	self.playing = false
end

function Animation:stop ()
	self:reset()
	for _,func in ipairs(self.callbacks.onEnd) do
		func(self)
	end
end

function Animation:isPlaying ()
	return self.playing
end

function Animation:onEnd (func)
	table.insert(self.callbacks.onEnd, func)
end
