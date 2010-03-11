function is (value, t)
	return type(value) == t
end

function isnot (value, t)
	return type(value) ~= t
end

function table.last (t)
	return t[table.maxn(t)]
end

-- from: http://lua-users.org/wiki/SplitJoin
function string:split (sep, max, isRegex)
	assert(sep ~= '')
	assert(max == nil or max >= 1)
	
	local lines = {}
	
	if self:len() > 0 then
		local plain = not isRegex
		max = max or -1
		local field=1 start=1
		local first,last = self:find(sep, start, plain)
		while first and max ~= 0 do
			lines[field] = self:sub(start, first-1)
			field = field+1
			start = last+1
			first,last = self:find(sep, start, plain)
			max = max-1
		end
		lines[field] = self:sub(start)
	end
	
	return lines
end

function string:chars ()
	local chars = {}
	for i = 1,#self do
		table.insert(chars, self:sub(i, i))
	end
	return chars
end