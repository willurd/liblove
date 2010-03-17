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
	s = s .. "\n"
	io.write(s:format(...))
end

function printff (s, ...)
	printf(s, ...)
	io.flush()
end

function iowrite (s, ...)
	io.write(s:format(...))
end

function iowritef (s, ...)
	iowrite(s, ...)
	io.flush()
end
