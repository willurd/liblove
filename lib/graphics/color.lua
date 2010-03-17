require("lib/essential")

Color = class("Color")

Color.DEFAULT_RED   = 255
Color.DEFAULT_GREEN = 255
Color.DEFAULT_BLUE  = 255
Color.DEFAULT_ALPHA = 255

local function hexToInt (hex)
	local int = 0
	local mul = { 16, 0 }
	for i,byte in ipairs({hex:byte(1,2)}) do
		local mul = mul[i]
		if byte >= 49 and byte <= 57 then
			int = int + ((byte - 49) * mul)
		elseif byte >= 65 and byte <= 70 then
			int = int + ((byte - 55) * mul)
		else
			error("Invalid hex character: " .. string.char(byte))
		end
	end
	return int
end

function Color.fromString (str)
	local color = string.match(str, "^#(.*)")
	if color then
		color = color:upper()
		local r = hexToInt(color:sub(1,2))
		local g = hexToInt(color:sub(3,4))
		local b = hexToInt(color:sub(5,6))
		return Color:new(r, g, b)
	end
	error("Error formatting color: " .. str)
end

function Color:initialize (paramsOrRed, green, blue, alpha)
	if type(paramsOrRed) == "number" then
		self.r = paramsOrRed or Color.DEFAULT_RED
		self.g = green       or Color.DEFAULT_GREEN
		self.b = blue        or Color.DEFAULT_BLUE
		self.a = alpha       or Color.DEFAULT_ALPHA
	else
		local p = paramsOrRed or {}
		self.r = p.r or Color.DEFAULT_RED
		self.g = p.g or Color.DEFAULT_GREEN
		self.b = p.b or Color.DEFAULT_BLUE
		self.a = p.a or Color.DEFAULT_ALPHA
	end
	
	for _,k in ipairs({"r","g","b","a"}) do
		if self[k] then
			if self[k] < 0 then self[k] = 0 end
			if self[k] > 255 then self[k] = 255 end
		end
	end
end

function Color:__tostring ()
	return string.format("<Color %d, %d, %d, %d>", self.r, self.g, self.b, self.a)
end

function Color:__sub (other)
	if is(other, "table") then
		return Color:new(self.r - other.r, self.g - other.g, self.b - other.b, self.a - other.a)
	else
		return Color:new(self.r - other, self.g - other, self.b - other, self.a - other)
	end
end

function Color:__add (other)
	if is(other, "table") then
		return Color:new(self.r + other.r, self.g + other.g, self.b + other.b, self.a + other.a)
	else
		return Color:new(self.r + other, self.g + other, self.b + other, self.a + other)
	end
end

function Color:set ()
	love.graphics.setColor(self.r, self.g, self.b, self.a)
end

function Color:copy ()
	return Color:new(self.r, self.g, self.b, self.a)
end

--[======================================================================]
--[ Some color constants

Color.WHITE = Color:new(255, 255, 255)
Color.BLACK = Color:new(0,   0,   0)
Color.RED   = Color:new(255, 0,   0)
Color.GREEN = Color:new(0,   255, 0)
Color.BLUE  = Color:new(0,   0,   255)
