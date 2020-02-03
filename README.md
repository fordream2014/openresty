### Openresty
* 背景介绍
```
适合做一些轻巧的web api开发
香草框架: 微博开源
打包了标准的Nginx核心，很多的常用的第三方模块，以及他们的大多数依赖项
应对高并发非常稳定，性能很好

官方文档：http://openresty.org/cn/
```
* local匹配和反向代理
```
正则location和普通location，其中“~ ”和“~* ”前缀表示正则location ，“~ ”区分大小写，“~* ”不区分大小写；其他前缀（包括：“=”，“^~ ”和“@ ”）和无任何前缀的都属于普通location 。
普通location”的最大前缀匹配结果与继续搜索的“正则location ”匹配结果的决策关系。如果继续搜索的“正则location ”也有匹配上的，那么“正则location ”覆盖 “普通location ”的最大前缀匹配
普通location 匹配完后，还会继续匹配正则location ；但是nginx 允许你阻止这种行为，方法很简单，只需要在普通location 前加“^~ ”或“= ”。但其实还有一种“隐含”的方式来阻止正则location 的搜索，
这种隐含的方式就是：当“最大前缀”匹配恰好就是一个“严格精确（exact match ）”匹配，照样会停止后面的搜索。原文字面意思是：只要遇到“精确匹配exact match ”，即使普通location 没有带“= ”或“^~ ”前缀，也一样会终止后面的匹配。

^~ 一般会匹配目录，比如一些静态文件
location ^~ /images {
    root html/static;
}

首先匹配 =
其次匹配 ^~

root和alias的区别
root处理结果：   root路径  + location路径
alias处理结果：  使用alias路径替换location路径

反向代理
proxy_pass

```
* luaj基础知识
```
基本数据类型：nil/bool/number/string/function/table
nil和false被认为是false，其他的数值被认为是true

如何判断一个table是空的

table.getn() == #table
不要在table中是用nil设置元素，会导致获取table长度不准确
```

* openresty
    + 输入和输出
    ``` 
    location /content {
        content_by_lua_block {
            local args, err = ngx.req.get_uri_args()
            for k,v in pairs(args) do
                ngx.say(k, v)
            end
        }
    }
    
    location /content {
        content_by_lua_block {
            ngx.req.read_body()
            local args, err = ngx.req.get_uri_args()
            for k,v in pairs(args) do
                ngx.say(k, v)
            end
            local post_data,err = ngx.req.get_post_args()
            if not post_data then
                ngx.say("failed to get post args: ", err)
                ngx.eof()
            else 
                for k,v in pairs(post_data) do
                    ngx.say(k, v)
                end
            end
        }
    }
    ```
    + cjson
    ```
    location /json {
        content_by_lua_block {
            local t = {foo="bar",m=1,n=2}
            local cjson = require("cjson")
            local json = cjson.encode(t)
            local dj = cjson.decode(json)
            --ngx.say(json)
            for k,v in pairs(dj) do
                ngx.say(k," ", v)
            end
            --ngx.say(dj["foo"])
        }
    }
    ```
    + redis
    ```
    
    ```


