function trace (s, ...)
	s = tostring(s) .. "\n"
	if console then
		console:print(s:format(...))
	else
		printf(s, ...)
	end
	io.flush()
end

function printf (s, ...)
	io.write(s:format(...))
end

function printff (s, ...)
	printf(s, ...)
	io.flush()
end
