
local list_node = {}

-- next
function list_node:next()
	return self.m_next
end

-- prev
function list_node:prev()
	return self.m_prev
end

-- get
function list_node:get()
	return self.m_data
end

-- set
function list_node:set(data)
	self.m_data = data
end

function list_node:new(data)
	local node = 
	{
		m_next = nil,
		m_prev = nil,
		m_data = data,
	}
	setmetatable(node,self) 
	self.__index = self
  	return node
end


-- list

local list ={}

-- init
function list:clear()
	self.m_head   = list_node:new(nil)
	self.m_count  = 0
	self.m_head.m_next   = self.m_head
	self.m_head.m_prev   = self.m_head
end

--new
function list:new()
	local l = 
	{
		m_head  = nil,
		m_count = 0,
	}
	setmetatable(l,self) 
	self.__index = self
	l:clear()
  	return l
end

-- begin
function list:begin()
	return self.m_head.m_next
end

-- end
function list:end_()
   return self.m_head
end

--insert
function list:insert(nd,data)
	local _tp    = list_node:new(data)
	local _prev  = nd.m_prev
	_prev.m_next = _tp
	_tp.m_prev   = _prev
	nd.m_prev   = _tp
	_tp.m_next  = nd
	-- count++
	self.m_count = self.m_count + 1
    return _tp
end

-- push_back
function list:push_back(data)
	self:insert(self:end_(),data)
end

-- push_front
function list:push_front(data)
	self:insert(self:begin(),data)
end

-- size
function list:size()
	return self.m_count
end

-- empty
function list:empty()
	return self.m_count <= 0
end

-- erase
function list:erase(p)
	local _prev = p.m_prev
	local _next = p.m_next
	_prev.m_next = _next
	_next.m_prev = _prev
	p.m_data = nil
	self.m_count = self.m_count - 1
	return _next
end

-- erase n
function list:erase_n(p,n)
	local _node = nil
	local _prev = p.m_prev
	for i = 1, n, 1 do
		_node = p
		p = p:next()
		_node.m_data = nil
	end
	local _next = p
	_prev.m_next = _next
	_next.m_prev = _prev
	self.m_count = self.m_count - n
    return _next;
end

-- erase range
function list:erase_range(f,l)
	local _prev = f.m_prev
	local _node = nil
	while f ~= l do
		_node = f
		f = f:next()
		_node.m_data = nil
		self.m_count = self.m_count - 1
	end
	local _next = l
	_prev.m_next = _next
	_next.m_prev = _prev
	return _next
end

-- pop_back
function list:pop_back()
	self:erase(self:end_():prev())
end  

-- pop_front
function list:pop_front()
	self:erase(self:begin())
end

-- front
function list:front()
	return self:begin():get()
end

-- back
function list:back()
	return self:end_():prev():get()
end

-- resize
function list:resize(nsz,data)
	local i   = 0
	local dif = 0
	local size = self:size()
	if nsz > size then
	   assert(data ~= nil)
	   dif = nsz - size
	   for i = 1, dif, 1 do self:push_back(data) end
	elseif nsz < size then
		if 0 == nsz then 
			self:clear()
		else
			dif = size - nsz
			self:pop_back()
		end
	end
end

-- swap

function list:__swap(a,b)
	local _tp = a
	a 		  = b
	b 		  = _tp 
end

function list:swap(l2)
	-- head
	local _tp 	= self.m_head
	self.m_head = l2.m_head
	l2.m_head 	= _tp 
	-- count
	local _tp 	= self.m_count
	self.m_count = l2.m_count
	l2.m_count 	= _tp
end

-- reverse

function list:__node_internal_swap(node)
	local _tp   = node.m_next
	node.m_next = node.m_prev
	node.m_prev = tp 
end

function list:reverse()
	local i    = self:size()  + 1
	local tp   = self.m_head
	local flag = tp.m_next
	while i > 0 do
		self:__node_internal_swap(tp)
		tp   = flag
		flag = flag:next()
		i = i - 1
	end
end

-- sort

function list:__transform(first,last,pos)
	if last ~= pos then
		local _tp  = first.m_prev
		local _end = last.m_prev
		-- step 1
		_tp.m_next  = last
		last.m_prev = _tp
		-- step 2
		_tp = pos.m_prev
		-- step 3
		_tp.m_next   = first
		first.m_prev = _tp
		-- step 4
		_end.m_next = pos
		pos.m_prev  = _end
	end
end

function list:__insert_sort(sort_func,...)
	local _flag = self.m_head.m_next
	local _tp   = nil
	local _next = nil
	local _prev = nil
	while _flag ~= self.m_head do
		_next = _flag.m_next
		_tp   = _flag.m_prev
		while _tp ~= self.m_head do
			_prev = _tp.m_prev
			if sort_func(_flag.m_data,_tp.m_data,...) then 
				self:__transform(_flag,_flag.m_next,_tp)
			else
				break
			end
			_tp = _prev
		end
		_flag = _next
	end
end

function list:__pick_mid(node,sort_fun,...)
	local first  = nil
	local second = nil
	local third  = nil
	local max    = nil
	first  = node
	second = first.m_next
	third  = second.m_next
	max    = sort_fun(first.m_data,second.m_data,...) and second or first
	if sort_fun(max.m_data,third.m_data,...) then max = third  end
	if max ~= third then self:__transform(max,max.m_next,third.m_next) end
	second = max.m_prev;
	first  = second.m_prev;
	if sort_fun(second.m_data,first.m_data,...) then
		self:__transform(first,second,max)
		return first
	else
		return second
	end
end

function list:__quick_sort_push_stack(stack,low,high)
	local _t = 
	{
		l = low,
		h = high
	}
	table.insert(stack,_t)
end

function list:__quick_sort_pop_stack(stack)
	local sz = #stack
	local _t = stack[sz]
	table.remove(stack,sz)
	return _t.l, _t.h
end

function list:__quick_sort(sort_fun,...)
	local _stack = {}
	local _high  = self:__pick_mid(self.m_head.m_next,sort_fun,...)
	local _low   = self.m_head.m_prev
	local _l 	 = nil
	local _h     = nil
	local _tp    = nil
	self:__quick_sort_push_stack(_stack,_low,_high)
	while #_stack > 0 do
		_low,_high = self:__quick_sort_pop_stack(_stack)
		_l = _high.m_next 
		_h = _high.m_prev
		self:__transform(_l,_l.m_next,_low.m_next)
		while _low ~= _high do
			if sort_fun(_low.m_data,_high.m_data,...) then
			   _tp  = _low
			   _low = _low.m_prev
			   self:__transform(_tp,_tp.m_next,_high)
			else
			   _low = _low.m_prev
			end
		end
		if _h.m_next ~= _high then
		   if _h.m_next == _high.m_prev then 
		   		self:__pick_mid(_h,sort_fun,...)
		   else
		   		_h = self:__pick_mid(_h,sort_fun,...)
		   		self:__quick_sort_push_stack(_stack,_high.m_prev,_h)
		   end
		end
		if _high.m_next ~= _l then
		   if _high.m_next == _l.m_prev then
		   	  self:__pick_mid(_high,sort_fun,...)
		   else
		   	  _high = self:__pick_mid(_high,sort_fun,...)
		   	  self:__quick_sort_push_stack(_stack,_l,_high)
		   end
		end
	end
end

function list:sort(sort_fun,...)
	local _sort_threshold = 8
	if self:size() <= _sort_threshold then
		self:__insert_sort(sort_fun,...)
	else
		self:__quick_sort(sort_fun,...)
	end
end

-- unique

function list:unique()
	local _del  = self.m_head.m_next
	local _flag = _del.m_next
	local _prev = nil
	while _flag ~= self.m_head do
		  _prev = _del.m_prev
		  if _del.m_data == _flag.m_data then
		  	 _prev.m_next = _flag
		  	 _flag.m_prev = _prev
		  	 _del.m_data  = nil
		  	 self.m_count = self.m_count - 1
		  end
		  _flag = _flag.m_next
		  _del  = _flag.m_prev
	end
end

-- merge

function list:merge(list2,com_func,...)
	local _flag   = nil
	local _tp     = nil
	local _size1  = self:size()
	local _size2  = list2:size()
    self.m_count  = self.m_count + _size2
    list2.m_count = 0
    _flag = self.m_head.m_next
    while _size1 > 0 and _size2 > 0 do
    	_tp = list2.m_head.m_next
    	if com_func(_flag.m_data,_tp.m_data,...) then
    		self:__transform(_tp,_tp.m_next,_flag.m_next)
    		_flag = _tp.m_next
    	else
    		self:__transform(_tp,_tp.m_next,_flag)
    	end    		_flag = _flag.m_next
    	_size1 = _size1 - 1
    	_size2 = _size2 - 1
    end
    if 0 ~= _size2 then
    _tp = list2.m_head.m_next
    self:__transform(_tp,list2.m_head,self.m_head)
    end
end

-- splice 
function list:splice(pos,list2)
	local _dis = list2:size()
	self:__transform(list2:begin(),list2:end_(),pos)
	self.m_count  = self.m_count  + _dis
	list2.m_count = list2.m_count - _dis
end

function list:splice_n(pos,list2,b,n)
	local _e = nil
	for i = 1, n do
		_e = b:next()
	end
	self:__transform(b,_e:next(),pos)
	self.m_count  = self.m_count  + n
	list2.m_count = list2.m_count - n
end

function list:splice_range(pos,list2,b,e)
	local _first = b
	local _last  = e
	local _dis   = 0
	while b ~= e  do
		_dis = _dis + 1
		b = b:next()
	end
	self:__transform(_first,_last,pos)
	self.m_count  = self.m_count  + _dis
	list2.m_count = list2.m_count - _dis
end

