local module = {}

function module.d1( ... )
    print('d1')
end

function module.d2( ... )
    print('d2')
end



function d3( ... )
    print('d3')
end

module.s1 = 's1'


return module

