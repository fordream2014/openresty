local a
print(a) --nil

--- 三元运算 a ? b : v
a = true
local b = 5
local c = 6
local v = ( a and b ) or c
print(v)

--- lua变量没有预定义类型，每个变量可以包含任意类型的值，要用就直接赋值一种数据类型的值
a = "hello"
print(a)

--- nil/false都是false，其他都是true
--- and or的结果不是true和false
--- a and b       -- 如果a为false，则返回a，否则返回b
--- a or  b        -- 如果a为true，则返回a，否则返回b

v = not nil
print(v)

local str = "hello" .. " world"
print(str)

print("***********")

---为了简化操作，Lua将环境本身存储在一个全局变量_G中，（_G._G等于_G）。例如，下面代码打印在当前环境中所有的全局变量的名字
for n in pairs(_G) do print(n) end