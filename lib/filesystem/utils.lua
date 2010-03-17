os = {
	sep = "/",
	join = function (...)
		local t = {...}
		local path = ""
		local length = #t
		for k,v in ipairs(t) do
			path = path .. v
			if k < length then path = path .. os.sep end
		end
		return path
	end
}
