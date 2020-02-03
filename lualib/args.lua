--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/2
-- Time: 下午2:26
-- To change this template use File | Settings | File Templates.
--

--curl -d "a=1&m=2" "http://127.0.0.1/test_args?a=1&b=2"
--[GET] key: b,value: 2
--[GET] key: a,value: 1
--[POST] key : m ,value : 2
--[POST] key : a ,value : 1

local uri_args = ngx.req.get_uri_args()
for k,v in pairs(uri_args) do
    ngx.say("[GET] key: ", k, ",value: ", v)
end

ngx.req.read_body()
local post_args = ngx.req.get_post_args()
for k,v in pairs(post_args) do
    ngx.say("[POST] key : ",k," ,value : ",v)
end



