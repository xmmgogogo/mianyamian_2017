
> Lua 是一种轻量小巧的脚本语言，用标准C语言编写并以源代码形式开放， 其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。


## LUA 基础理论部分

### 函数
```
--- 遍历数组
local t_data = {k1 = 1, k2 = 2, k3 = 3, 4, 5}

for i,v in pairs(t_data) do
    print(i .. '<===' .. v)
end
```

* **删除table对象内容，直接设置为nil即可。**

* lua支持匿名函数，并且能够直接写function里面传递，php虽然支持匿名函数，但不可以直接将函数写在function里面(不知是否理解，你先写下传递函数，写完就懂)。

* 交换变量，php里面就没这么简洁的写法
```
-- 交换变量值
x = 10;
y = 20;

x, y = y, x;
```

* 3种循环写法（repeat until，for，while）

* 函数返回值，多返回值问题优点

* 函数多传入参数，自定义...
```
-- 多传入参数
function fun_multi( ... )
    print(...)
    
    local t = {...}

    for k,v in pairs(t) do
        print(k,v)
    end
end
```

* loadstring()系统函数，干了些什么？类似加载，从给定的字符串得到块，要加载和运行一个给定的字符串
```
function fun2( ... )
    print('abbbb')
end

-- 直接转化函数为2进制内容
-- 从这里看loadstring貌似就是热更新干的那些事情啊

b = string.dump(fun2)
print(loadstring(b)())
```

* **迭代器** *for函数自带迭代器*
```
local table = {'apple', 'baba', 'pee'}
local it = iter(table) - 这里是迭代器

-- 一直用next执行
try {
    next(it)
} catch(e) {
    break
}
```

* Lua模块化编程
    1. require
    2. 进一步通过嵌套方式，避免全局变量污染

* **Lua语言中的"."和":"有什么不同？** *使用：可以避免传递self，类似Python类函数，默认需要传自身self*


***

## LUA 框架解析

* LUA框架里面全部的内容赋值给gamecore，通过init.lua加载到全局变量。
    1. 每个文件，内部统一使用_mt的形势。
    2. 统一格式

* 定义接口逻辑层，统一的协议编号 protocol
   定义框架层，统一的常量 opcode

* **新用户登入**
    * 直接请求PHP服务器，验证用户名和密码，同时获取服务器列表
    * 登入游戏 - LUA
    * center - event - on_new_client_connect() - accountmgr:new_client(gate_id, clientid, ip) 客服端连接
        1. find_account_by_gateinfo(gate_id, clientid) --查找是否存在
        2. gamecore.account:create() --不存在，新建客户端
        3. __link_account_as_gateinfo(gate_id, clientid, ao) --增加网关信息和账号的查找关联

* **匹配战斗**
    * center - battle_match_mgr - join_battle_match(battleType, ao)   -- 加入战斗
    * center - battle_field_mgr - add_new_battle(battleID, aos) -- 进入战斗（匹配者账户ID，全部玩家ao）
    

* 框架疑问汇总：
  1. init.lua 关于register_instance，import_module，register_class_extend区别
  2. 