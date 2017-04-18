-- 多返回值
function fn_return(a, b)
    local global_a = 100
    return a, b
end

local a, c = fn_return(1, 2)
-- print(a .. '--->' .. c)


-- 多传入参数
function fun_multi( ... )
    -- print(...)
    
    local t = {...}

    for k,v in pairs(t) do
        print(k,v)
    end
end

-- fun_multi(1,2,3)

print(global_a)