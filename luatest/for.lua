--
-- Created by IntelliJ IDEA.
-- User: xuguang5
-- Date: 2020/2/1
-- Time: 下午7:50
-- To change this template use File | Settings | File Templates.
--

--- for 循环
--- for var=exp1,exp2,exp3 do
-- <执行体>
-- end
--- exp3为可选，如不指定，默认为1
--- lua数组从1开始
local t = {}
for i=1,10 do
    t[i] = i+10
end
print(table.concat(t, ","))

for k,v in ipairs(t) do
    print(k,v)
end

print("***************")
--- 对于字典，使用pairs
t = {
    a = "a1",
    b = "b1"
}
for k,v in pairs(t) do
    print(k, v)
end



