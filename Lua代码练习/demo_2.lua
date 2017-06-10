local t_data_2 = {k1 = 1, k2 = 2, k3 = 3, 4, 5};
local t_data_3 = {1,2,3,4};

-- print(t_data_2.k1)

for i,v in pairs(t_data_2) do
	-- print(i,v)
end

for i,v in ipairs(t_data_3) do
	-- print(i,v)
end

-- if t_data_4 == nil then
-- 	print('ok');
-- else
-- 	print('no ok');
-- end

--[[
for i,v in pairs(t_data_2) do
	print(i .. '===>' .. v);
end

t_data_2[2] = nil;

for i,v in pairs(t_data_2) do
	print(i .. '<===' .. v);
end
]]

--[[
-- 匿名函数    
function fun_add(a, b)
    print(a + b)
end

function fun_max(a, b, fun)
    fun(a, b)
end

fun_max(2, 3, fun_add);
]]

--[[
-- 交换变量值
x = 10;
y = 20;

x, y = y, x;

print(x)
print(y)
]]

--[[
-- 3种循环写法（repeat until，for，while）
for i=1,10,2 do
    -- print(i)
end

local count = 20
while(count > 10) do
    -- print(count)
    count = count - 1
end
]]