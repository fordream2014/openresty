
function isTableEmpty(t)
    if t == nil or next(t) == nil then
        return true
    else
        return false
    end
end

local t = {}
local tt = {nil, 1}
-- print(isTableEmpty(t), isTableEmpty(tt))

local str1 = "hello"
local str2 = "hello"
--print(str1, str2)

str2 = "world"
--print(str1, str2)

local t = {nil, 1, nil}
--print(#t, table.getn(t))

local str = "hello"
--print(#str)

local test = function()
    print("test function")
end

--test()

local t = {1,2,3,4 }
table.insert(t, 1, 10)
print(table.concat(t, ","))
table.remove(t, 2)
print(table.concat(t, ","))

local t = {a=11,b=22 }
print(t.a)

