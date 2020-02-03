--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/3
-- Time: 下午9:30
-- To change this template use File | Settings | File Templates.
--
---元表使用
local set1 = {10,20,30}
local set2 = {20,40,50 }

union = function(self, another)
    local set = {}
    for k,v in ipairs(self) do
        set[v] = true
    end
    for k,v in ipairs(another) do
        set[v] = true
    end

    local result = {}
    for k,v in pairs(set) do
        table.insert(result, k)
    end
    return result
end

setmetatable(set1, {__add = union})

local set3 = set1 + set2
print(table.concat(set3, "|"))

--- __index 取下标操作用于访问 table[key]
local t = {key1="value1" }
setmetatable(t, {__index=function(self, key)
    if key ~= "key1" then
        return "default_value"
    end
end})

print(t.key1, t.key2, t.key3)

---local mytable = {}
---local mymetatable = {}
---setmetatable(mytable, mymetatable)
---上面的代码可以简写成如下的一行代码：
---local mytable = setmetatable({}, {})

--- __index 的元方法不需要非是一个函数，他也可以是一个表。
mytable = setmetatable({[1]="hello"}, {__index={[2]="world"}})
print(mytable[1], mytable[2])

--- __tostring
local t = {1,2,3,4}
print(table.concat(t,""))

setmetatable(t, {__tostring=function(self)
    local str = "{"
    for k,v in ipairs(self) do
        str = str .. v .. ","
    end
    str = string.sub(str, 1, -2)
    str = str .. "}"
    return str
end})
print(t)

---__metatable 元方法,使其使用者既看不到也不能修改metatables
Object = setmetatable({}, {__metatable = "You cannot access here"})
print(getmetatable(Object)) --> You cannot access here

local _M = {}
local t = {key2="value2" }
setmetatable(t, {__index=_M})
_M.key1 = "value"

print(t.key1, t.key2)




