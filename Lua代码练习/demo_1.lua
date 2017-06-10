-- package.cpath = package.cpath .. ";D:/Lua5.3/"

-- print(package.cpath)

-- require "tb.lua"

-- local x = tb:new()
-- local y = tb:new()

-- print(x + y)



-- ClassYM = {x=0, y=0}  
-- --这句是重定义元表的索引，必须要有，  
-- ClassYM.__index = ClassYM  
  
-- --模拟构造体，一般名称为new()  
-- function ClassYM:new(x,y)  
--     local self = {}  
--     setmetatable(self, ClassYM)   --必须要有  
--     self.x = x  
--     self.y = y  
--     return self  
-- end  
  
-- function ClassYM:test(sender)  
--     print(sender.x, sender.y)  
-- end  
  
-- objA = ClassYM:new(1,2)  
-- selfA = objA  
-- objA.test(nil, selfA)  
-- print(objA.x, objA.y)  


-- local table_name = {a = 1, b = 2, c = 3, d = 4}
-- local table_name2 = {1, 2, 3, 4}
-- -- print(table.unpack(tData))


-- for i,v in ipairs(table_name) do
-- 	-- print(i,v)
-- end


-- -- print(next(table_name2, nil))
-- -- print(next(table_name2, 1))
-- -- print(next(table_name2, 2))
-- -- print(next(table_name2, 4))

-- -- print(type(tonumber('a')))
-- -- print(type(tostring(132)))

-- -- local x = string.find('aaaaabc', 'a')
-- -- print(x)

-- local x = string.match('aaaaabc', "(1)")
-- print(x)

-- require('luacom')

-- excel = luacom.CreateObject("Excel.Application")

-- local excel_path = 'D:/Lua5.3/skill.xlsx'
-- local txt_path = 'D:/Lua5.3/skill.txt'
-- local sub_tablename = 'skill'

-- excel_path = string.gsub(excel_path, "/", "\\")
-- txt_path = string.gsub(txt_path, "/", "\\")

-- local book = excel.Workbooks:Open(excel_path)

-- excel.Application.DisplayAlerts = 0
-- excel.Application.ScreenUpdating = 0

-- --把子表设置为活动表
-- excel.Worksheets(sub_tablename):Activate()

-- --保存活动表为txt格式
-- -- local res = pcall(function()
-- -- 		-- 42表示为：Unicode 文本
-- -- 		excel.ActiveWorkbook:SaveAs(txt_path, 42)
-- -- 	end)


-- -- 42表示为：Unicode 文本
-- excel.ActiveWorkbook:SaveAs(txt_path, 42)

-- excel.Workbooks:Close()
-- excel:Quit()

-- xxxxx = {1,2,3,4,5,6, a = 100, b = 200}
-- yyyyy = {a = 100, b = 200, c = 300, d = 400}
-- -- xxxxx[3] = nil
-- -- xxxxx[2] = nil

-- yyyyy.a = nil

-- -- table.remove(yyyyy.a = , 'a')
-- -- table.remove(yyyyy, 'c')

-- for k,v in pairs(yyyyy) do
-- 	print(k,v)
-- end


-- for i=1,10 do
-- 	print(i)
-- end


--[[
print('aaaccc');
print('222aaaccc');
]]

local t_data = {'a', 'b', 'c'};

function function_name()
	-- body
end

-- print(type('a'));
-- print(type(20));
-- print(type(true));
-- print(type(t_data));
-- print(type(function_name));
-- print(type(nil));

