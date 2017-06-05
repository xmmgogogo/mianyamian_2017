


注意点1，dataType  千万别写错，不然没效果哦。中间是大写，不是datatype

注意点2，区分下json字符串和json对象的关系

Var JSON对象 = {"Area"：[{"AreaId":"123"},{"AreaId":"345"}]},

Var JSON字符串 = '{"Area"：[{"AreaId":"123"},{"AreaId":"345"}]}',

字符串的话需要 eval('(' + 字符串json + ')')