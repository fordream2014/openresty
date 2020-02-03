--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/3
-- Time: 下午2:08
-- To change this template use File | Settings | File Templates.
--

-- well, we could put the require() and new() calls in our own Lua
-- modules to save overhead. here we put them below just for
-- convenience.

local limit_req = require "resty.limit.req"

-- limit the requests under 200 req/sec with a burst of 100 req/sec,
-- that is, we delay requests under 300 req/sec and above 200
-- req/sec, and reject any requests exceeding 300 req/sec.
local lim, err = limit_req.new("my_limit_req_store", 2, 2)
if not lim then
    ngx.log(ngx.ERR,
        "failed to instantiate a resty.limit.req object: ", err)
    return ngx.exit(500)
end

-- the following call must be per-request.
-- here we use the remote (IP) address as the limiting key
local key = ngx.var.binary_remote_addr
local delay, err = lim:incoming(key, true)
if not delay then
    ngx.log(ngx.ERR, "failed to limit req: ", err, delay)
    if err == "rejected" then
        return ngx.exit(503)
    end
    return ngx.exit(500)
end
ngx.log(ngx.ERR, "limit req: ", delay)
if delay >= 0.001 then
    -- the 2nd return value holds the number of excess requests
    -- per second for the specified key. for example, number 31
    -- means the current request rate is at 231 req/sec for the
    -- specified key.
    local excess = err

    -- the request exceeding the 200 req/sec but below 300 req/sec,
    -- so we intentionally delay it here a bit to conform to the
    -- 200 req/sec rate.
    ngx.sleep(delay)
end

--- 测试实例
--- ab -c 6 -n 6 "http://127.0.0.1:80/test_limit_req"  使用ab压测，结果如下
--- 2r/s相当于每500ms处理一个请求，桶大小为2。
--- limit_req原理是漏斗算法
--- 127.0.0.1 - - [03/Feb/2020:14:25:52 +0800 - 1580711152.370] "GET /test_limit_req HTTP/1.0" 200 13 "-" "ApacheBench/2.3" "-"
-- 127.0.0.1 - - [03/Feb/2020:14:25:52 +0800 - 1580711152.372] "GET /test_limit_req HTTP/1.0" 503 541 "-" "ApacheBench/2.3" "-"
-- 127.0.0.1 - - [03/Feb/2020:14:25:52 +0800 - 1580711152.372] "GET /test_limit_req HTTP/1.0" 503 541 "-" "ApacheBench/2.3" "-"
-- 127.0.0.1 - - [03/Feb/2020:14:25:52 +0800 - 1580711152.372] "GET /test_limit_req HTTP/1.0" 503 541 "-" "ApacheBench/2.3" "-"
-- 127.0.0.1 - - [03/Feb/2020:14:25:52 +0800 - 1580711152.873] "GET /test_limit_req HTTP/1.0" 200 13 "-" "ApacheBench/2.3" "-"
-- 127.0.0.1 - - [03/Feb/2020:14:25:53 +0800 - 1580711153.370] "GET /test_limit_req HTTP/1.0" 200 13 "-" "ApacheBench/2.3" "-"

