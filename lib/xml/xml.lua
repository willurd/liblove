-- from: http://lua-users.org/wiki/LuaXml

function xml_parseargs (s)
  local arg = {}
  string.gsub(s, "([%w%:]+)=([\"'])(.-)%2", function (w, _, a)
    arg[w] = a
  end)
  return arg
end
    
function xml_collect (s)
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,name,attrs, empty
  local i, j = 1, 1
  while true do
    ni,j,c,name,attrs, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(s, i, ni-1)
    if not string.find(text, "^%s*$") then
      table.insert(top, text)
    end
    if empty == "/" then  -- empty element tag
      table.insert(top, {name=name, attrs=xml_parseargs(attrs), empty=true})
    elseif c == "" then   -- start tag
      top = {name=name, attrs=xml_parseargs(attrs)}
      table.insert(stack, top)   -- new level
    else  -- end tag
      local toclose = table.remove(stack)  -- remove top
      top = stack[#stack]
      if #stack < 1 then
        error("nothing to close with "..name)
      end
      if toclose.name ~= name then
        error("trying to close "..toclose.name.." with "..name)
      end
      table.insert(top, toclose)
    end
    i = j+1
  end
  local text = string.sub(s, i)
  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error("unclosed "..stack[stack.n].name)
  end
  return stack[1]
end
