require "list.lua"

-- tb
local tb = {}

-- clear
function tb:clear()
	self.m_list = list:new()
	self.m_list:clear()
	self.m_mcount = 0
	self.ki_map   = {}
	self.ik_map   = {}
end

--new
function tb:new()	
	local l =
	{
		m_list   = 0,
		m_mcount = 0,
		ki_map   = 0,
		ik_map   = 0,
	}

	setmetatable(self,
	{ 
		__index = function(t,key)
			local _tp = l.ki_map[key]
			if _tp ~= nil then
			   for _,v in pairs(_tp) do  return v:get() end
			end
			return nil
		end
	})

	setmetatable(l,
	{
		__index = self,
		
		__newindex = function (t,key,value)
		  local _tp = l.ki_map[key]
		  if _tp ~= nil then
		  	 for _,v in pairs(_tp) do 
		  	 	v.m_data = value
		  	 	break
		  	 end
		  else
		  	 assert(nil," can't insert new value which does not exist in table ! " )
		  end
		end,
		
		__len = function(t) return t:size() end,
		
		__add = function(t1,t2) 
			for _, v in pairs(t2) do 
				t1:push_back(v) 
			end 
			return t1 
		end,

		__sub = function(t1,t2) 
			for _,v in pairs(t2) do 
				t1:remove_by_value(v) 
			end 
			return t1 
		end,

		__concat = function(t1,x)
		   if type(x) == "table" then
			  for _, v in pairs(x) do t1:push_back(v) end
		   else
		   	  t1:push_back(x)
		   end
		   return t1
		end,

		__metatable = "can not do this "
	})
	l:clear()
  	return l
end

-- begin
function tb:begin()
	return self.m_list:begin()
end

-- end
function tb:end_()
	return self.m_list:end_()
end

-- front
function tb:front()
	return self.m_list:front()
end

-- back
function tb:back()
	return self.m_list:back()
end

-- marked_size
function tb:marked_size()
	return self.m_mcount;
end

-- size
function tb:size()
	return self.m_list:size()
end

-- empty
function tb:empty()
   return self.m_list:empty()
end

-- push_back
function tb:push_back(data)
   self.m_list:push_back(data)
end

-- push_back_with_key

function tb:__add_relationship(key,iter)
	local tp = self.ki_map[key]
	if tp ~= nil then
		table.insert(tp,iter)
	else
		tp = {}
		table.insert(tp,iter)
		self.ki_map[key] = tp
	end
	self.ik_map[iter] = key
	self.m_mcount = self.m_mcount + 1
end

function tb:push_back_with_key(data,key)
	local iter  = self.m_list:insert(self.m_list:end_(),data)
	self:__add_relationship(key,iter)
end

-- push_front
function tb:push_front(data)
   self.m_list:push_front(data)
end

-- push_front_with_key 
function tb:push_front_with_key(data,key)
	local iter = self.m_list:insert(self.m_list:begin(),data)
	self:__add_relationship(key,iter)
end

--erase
function tb:__rm_relationship_by_iter(iter)
	if self.m_mcount > 0 then
	   local key = self.ik_map[iter]
	   if key ~= nil then
	   	 local tp = self.ki_map[key]
	   	 for k,v in ipairs(tp) do
	   	 	if v == iter then
	   	 		table.remove(tp,k)
	   	 		if #tp <= 0 then self.ki_map[key] = nil end
	   	 		break 
	   	 	end 
	   	 end
	   	 self.ik_map[iter] = nil
	   	 self.m_mcount = self.m_mcount - 1
	   end
	end
end

function tb:__rm_relationship_by_key(key)
	if self.m_mcount > 0 then
	   local tp = self.ki_map[key]
	   local sz = #tp
	   self.ki_map[key] = nil
	   for k,v in ipairs(tp) do self.ik_map[v] = nil end
	   self.m_mcount = self.m_mcount - sz
	end
end

function tb:erase(iter)
	local _next = self.m_list:erase(iter)
	self:__rm_relationship_by_iter(iter)
	return _next
end


-- erase range
function tb:erase_range(f,l)
	local _ret = nil
	while f ~= l do
		_ret = self:erase(f)
		f = f:next()
	end
	return _ret
end

-- erase n
function tb:erase_n(f,n)
	local _ret = nil
	for  i = 1,n,1 do
		_ret = self:erase(f)
		f = f:next()
	end
	return _ret
end

-- mark
function tb:mark(iter,key)
	self:__rm_relationship_by_iter(iter)
	self:__add_relationship(key,iter)
end

-- unmark
function tb:unmark(iter)
  self:__rm_relationship_by_iter(iter)
end

-- count
function tb:count_by_key(key)
	local tp = self.ki_map[key]
	if tp ~= nil then
		return #tp
	end
	return 0
end

-- remove
function tb:remove_by_value(val)
	local f = self:begin()
	local l = self:end_()
	while f ~= l do
		if f:get() == val then self:erase(f) end
		f = f:next()
	end
end

-- remove_by_key
function tb:remove_by_key(key)
   local tp = self.ki_map[key]   
   for k,v in pairs(tp) do self.m_list:erase(v) end
   self:__rm_relationship_by_key(key)
end

-- remove by map
function tb:remove_by_map(t1)
   for k, v in pairs(t1) do
   	   local _arr = self.ki_map[k]
   	   if _arr ~= nil then
   	   	  for _, _iter in ipairs(_arr) do
   	   	  if _iter:get() == v then self:erase(_iter) end 
   	   	  end
   	   end
   end
end

-- remove_if
function tb:remove_if(pred,...)
	local f = self:begin()
	local l = self:end_()
	while f ~= l do
		if pred(f:get(),...) then self:erase(f) end
		f = f:next()
	end
end

-- pop_back
function tb:pop_back()
	self:erase(self:end_():prev())
end

-- pop_front
function tb:pop_front()
   self:erase(self:begin())
end

-- insert
function tb:insert(p,val)
	return self.m_list:insert(p,val)
end

-- insert with key
function tb:insert_with_key(p,val,key)
	local _iter = self.m_list:insert(p,val)
	self:__add_relationship(key,_iter)
	return _iter
end

function tb:count_by_value(val)
	local c = 0
	local f = self:begin()
	local l = self:end_()
	while f ~=l do
		if f:get() == val then c = c + 1 end
		f = f:next()
	end
	return c
end

-- contains_key
function tb:contains_key(key)
	local  tp = self.ki_map[key]
	return tp
end

function tb:contains_key_by_iter(iter)
   local  tp = self.ik_map[iter]
   return tp
end

-- contains_value
function tb:contains_value(val)
	local f = self:begin()
	local l = self:end_()
	while f ~=l do
		if f:get() == val then return f end
		f = f:next()
	end
	return l
end

-- at
function tb:at(index)
	local f = self:begin()
	local l = self:end_()
	for i = 1, index, 1 do f = f:next() end
	return f:get()
end

-- index
function tb:index_by_key(key)
    local c = 0
	local f = self:begin()
	local l = self:end_()
	while f ~=l do
		if self:contains_key_by_iter(f) ~= nil then return c end
		f = f:next()
		c = c + 1
	end
	return -1
end

function tb:index_by_value(val)
	local c = 0
	local f = self:begin()
	local l = self:end_()
	while f ~=l do
		if f:get() == val then return c end
		f = f:next()
		c = c + 1
	end
	return -1
end

