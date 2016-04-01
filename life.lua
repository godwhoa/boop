Life = {}

function Life:new()
	setmetatable({},Life)
	-- time since start
	self.start = 0
	-- {update_cb,draw_cb,interval,accumulator,dodraw,born}
	self.animations = {} 
	return self
end

function Life:addAni(draw,update,interval,lifetime)
	local i = #self.animations+1
	table.insert(self.animations,
		{update=update,draw=draw,inter=interval,life=lifetime,acc=0,dodraw=false,born=self.start})
	return i
end

function Life:clear(index)
	if index == nil then 
		self.animations = {}
	else
		table.remove(self.animations,index)
	end
end

function Life:update(dt)
	self.start = self.start + dt
	for i,a in ipairs(self.animations) do
		span = self.start-a.born
		if a.life ~= "forever" and span > a.life then
			table.remove(self.animations,i)
		end
		if a.acc >= a.inter then
			a.update(dt)
			a.dodraw = true
			a.acc = 0
		else
			a.dodraw = false
			a.acc = a.acc + dt
		end

	end

end

function Life:draw()
	for i,a in ipairs(self.animations) do
		if a.dodraw or a.inter < 1 then
			a.draw()
		end
	end
end

return Life