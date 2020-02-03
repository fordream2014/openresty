--
-- Created by IntelliJ IDEA.
-- User: jufeng
-- Date: 17-12-27
-- Time: 上午11:00
-- To change this template use File | Settings | File Templates.
-- ipairs  ,遇到nil 就退出
-- pairs 是可以输出table的key value
--

local _M = {}

function _M.getArgs()
    local request_method = ngx.var.request_method
    --如果是get 请求，直接返回
    if "GET" == request_method then
        local get_args = ngx.req.get_uri_args()
        return get_args
    else
        ngx.req.read_body()  --log_by_lua 阶段不能使用
        local post_args = ngx.req.get_post_args()
        local get_args = ngx.req.get_uri_args()
        if post_args and not get_args then
            return post_args
        end
        if not  post_args and get_args then
            return get_args
        end
        if post_args and get_args then
            local args={}
            for k,v in pairs(post_args) do
                args[k] = v
            end
            for k,v in pairs(get_args) do
                args[k] = v
            end
            return args
        end
        if not post_args and not get_args then
            return nil
        end
    end
end


function _M.check_default_experiment(strategy_name,strategy_content)
    if not strategy_name then
        return false
    end
    if strategy_name == "no" then
        return false
    end

    if not strategy_content then
        return false
    end

    return true
end


function _M.forward_experiment(experiment,url_args)
    local url = experiment["url"]
    ngx.log(ngx.ERR,"debug_url-> ",url)
    local res = ngx.location.capture(
        url, {args=url_args}
    )
    ngx.say(res.body)
    -- return

    --[[ngx.location.capture_multi(
        {
            {url,{args=url_args}}
        }
    )]]
end

return _M
