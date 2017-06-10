-- 初始化数组
local tab= { 
[1] = "a", 
[3] = "b", 
[4] = "c" 
} 

for i,v in pairs(tab) do        -- 输出 "a" ,"b", "c"  ,
    print( tab[i] ) 
end 

for i,v in ipairs(tab) do    -- 输出 "a" ,k=2时断开 
    print( tab[i] ) 
end


local moudle = require("demo_moudle")
-- print(moudle.s1)
moudle.d3()
