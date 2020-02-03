--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/2
-- Time: 下午2:37
-- To change this template use File | Settings | File Templates.
--

local cjson = require("cjson")
local inputstr = '{"name": "lixg"}'

local arr = cjson.decode(inputstr)
--ngx.say(arr['name'])
--ngx.say(arr.name)


--- ngx.say/ngx.print的使用
--Nested arrays of strings are permitted and the elements in the arrays will be sent one by one:
--
--local table = {
--    "hello, ",
--    {"world: ", true, " or ", false,
--        {": ", nil}}
--}
--ngx.print(table)
--will yield the output
--
--hello, world: true or false: nil
--Non-array table arguments will cause a Lua exception to be thrown.

local table = {
    "hello, ",
    {"world: ", true, " or ", false,
        {": ", nil}}
}
ngx.say(table)

--- cjson.encode_empty_table_as_object的使用
--- empty Lua tables are encoded as empty JSON Objects ({}).
--- If this is set to false, empty Lua tables will be encoded as empty JSON Arrays instead ([]).
local table = {}
ngx.say(cjson.encode(table))

cjson.encode_empty_table_as_object(false)
ngx.say(cjson.encode(table))


--- cjson.safe和cjson的区别
--- safe模块，在进行调用时，如果出现解析异常，不会抛出异常，而是返回Nil，这样可以避免程序意外退出。
--- cjson.decode在input不是JSON格式数据，出现解析异常。
local cjson_safe = require("cjson.safe")
local t = '{"name":"lixg", "hello"}'
local res = cjson_safe.decode(t)
ngx.say(res)
