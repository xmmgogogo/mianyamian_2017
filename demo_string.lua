local s_char = 'asdggasdqasd1231111'

function function_name2( ... )
    -- body
end

function function_name3( ... )
    print('abbbb')
end

--[[
-- 直接转化函数为2进制内容
-- 从这里看loadstring貌似就是热更新干的那些事情啊
print(string.dump(function_name2))

b = string.dump(function_name3)
print(loadstring(b)())
]]

--[[
-- 匹配
b = string.match( s_char,'111$' )
print(b)
]]
