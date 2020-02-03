--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/1
-- Time: 下午8:01
-- To change this template use File | Settings | File Templates.
--
-- 异常处理

---- error 用于抛出异常信息
local n
if not n then
    -- error("n is nill")  --直接退出程序
end

print("Hello world")

--- assert 若执行函数没有问题，assert不会做任何事情，如果异常，assert 会以第二个参数作为异常信息抛出，
--- 第二个参数是可选的
assert(tonumber("2"),"invalida number")

--- error assert 抛出错误信息后，就不会继续往下执行了

--- pcall
---pcall (f, arg1, ...)
--- pcall 用于捕获抛出的异常信息和错误信息，惹没有问题，pcall 返回true以及被执行函数的返回值，否则返回false和错误信息
local test = function(k,v)
    -- error(" throw error ")
    print(k, v)
    return "hello"
end

ok, err = pcall(test, 1, 2)
print(ok, err)