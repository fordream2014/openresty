--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/2
-- Time: 下午3:09
-- To change this template use File | Settings | File Templates.
--
ngx.req.read_body()

--body specify the subrequest's request body (string value only).
--args specify the subrequest's URI query arguments (both string value and Lua tables are accepted)

local body_data = ngx.req.get_body_data()
ngx.say("hello,",body_data)

local resp = ngx.location.capture(
    "/test_args",
    {
        method=ngx.HTTP_POST, --默认GET
        args=ngx.var.args, --get method
        body = ngx.var.request_body  -- post method
    }
)

ngx.say(resp.body)

