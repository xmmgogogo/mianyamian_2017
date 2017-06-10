t_data1 = {11, 2, 3}
t_data2 = {4, 5, 6}
t_data3 = {'c', 'ab', 'a', 'aa'}
t_data4 = {'c', 'aa', 'a', 1, 2}

t_data5 = {k1 = 'k1', k2 = 'k2', k3 = 'k3'}

-- table字符串连接
t = table.concat( t_data1, ", ", 1, table.maxn(t_data1) )
-- print(t)

-- 插入表
table.insert( t_data1, 5, 'aaa' )

-- 表排序
-- table.sort( t_data3 )

table.remove( t_data5, 1 );

for k,v in pairs(t_data5) do
    -- print(k .. '-->' .. v)
end


mymetatable = {key1 = "value1"}
mytable = setmetatable({}, {__index = mymetatable})

-- print(mytable.key1)

-- mytable.newkey = "新值2"
-- print(mytable.newkey,mymetatable.newkey)


mymetatableFun = function ()
    print(1)
end

-- mytable = {}
mytable = setmetatable({}, mymetatable)
mymetatable.__index = mymetatable
mymetatable.test1 = 'test1'
mymetatable.test2 = 'test2'

print(mytable.test1)
