--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/3
-- Time: 下午10:39
-- To change this template use File | Settings | File Templates.
--

local test = {}
test.name = "xuguang"

function test:new()
    self.__index = self
    return setmetatable({}, self)
end

function test:say()
    print("hello")
end

--- :/.访问函数区别是，冒号会自动传入self参数，点则需要手动传入self
local t1 = test:new()
t1:say()
t1.say()

local t2 = t1:new()
t2:say()

