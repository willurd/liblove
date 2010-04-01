--[[
* liblove is a high-level library for making development in LÖVE even
* easier than it already is.
* Copyright (c) William Bowers <william.bowers@gmail.com>
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

require("lib/game")
require("src/states/all")

function love.load (args)
	math.randomseed(love.timer.getTime())
	game = Game:new({
		physics = PhysicsState:new(),
		ui = UIState:new(),
	})
	game:changeState("ui")
end

function love.update (dt)
	love.graphics.setCaption("liblove demo (" .. love.timer.getFPS() .. " fps)")
	game:update(dt)
end

function love.draw ()
	game:draw()
end

-- button:string - the button: l, m, r, wd, wu, x1, x2
function love.mousepressed (x, y, button)
	game:mousepressed(x, y, button)
end

function love.mousereleased (x, y, button)
	game:mousereleased(x, y, button)
end

-- key:string - the key
-- unicode:number - the unicode representation of the key
function love.keypressed (key, unicode)
	game:keypressed(key, unicode)
end

function love.keyreleased (key, unicode)
	game:keyreleased(key, unicode)
end

-- joystick:number - the joystick number
-- button:numer - the button number
function love.joystickpressed (joystick, button)
	game:joystickpressed(joystick, button)
end

function love.joystickreleased (joystick, button)
	game:joystickreleased(joystick, button)
end
