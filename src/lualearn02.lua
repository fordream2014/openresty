local a = 1
local b = 2
--print(a and b, b and a, nil and a, nil and b)
--print(a or b, nil or a, nil or b)
--print(not a, not b)

--print("hello" .. " world")
--print(string.format("%s %s", "hello", "world"))

local a = 20
while a > 10 do
    --print(a)
    a = a - 1
end

for t = 0, 10, 1 do
    --print(t)
end

local t = {1,2,3,4,5,6 }
for i,v in ipairs(t) do
    --print(i, v)
end

local t = {a=1,b=2,c=3 }
for i,v in pairs(t) do
    --print(i, v)
end

function f1(t)
    t[1] = 10
    --print(table.concat(t, ","))
end
local t = {1,2,3,4,5 }
f1(t)
--print(table.concat(t, ","))

--变长参数
local f2 = function (...)
    print(table.concat({...}, ","))
end
--f2(1,2,3,4,5,5)
--f2(1,2)

--多个返回值
local f3 = function()
    return 1,2
end
a,b = f3()
--print(a,b)

print(package.path)
local lib = require("lib")
lib()