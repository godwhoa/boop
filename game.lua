color = require("color")
Game = {}
Game.__index = Game
function Game:new()
	local self = setmetatable({}, Game)
	self.path = {}
	self.s1,self.s2 = {x=0,y=500},{x=200,y=50}
	self:makepath(self.s1,self.s2)
	self.m_path = {}
	return self
end

function Game:makepath(p1,p2)
  local bx,by = math.abs(p2.x-p1.x),math.abs(p2.y-p1.y)
  self.path = {}
  for t=0.0,1.0,0.01 do
    -- (1-t)^2*p0+2(1-t)t*p1+(t^2)*p2
    local x = ((1-t)^2*p1.x + 2*(1-t)*t*bx+t^2*p2.x)
    local y = ((1-t)^2*p1.y + 2*(1-t)*t*by+t^2*p2.y)
    table.insert(self.path,{x=x,y=y})
  end
end

function Game:draw()
  for i,p in ipairs(self.m_path) do
    love.graphics.setColor(color.lightwhite)
    love.graphics.circle("fill", p.x,p.y,4, 100)
  end
end

function Game:update( dt )
  pop = table.remove(self.path,1)
  if pop == nil then
    print("BOop")
    self.path = self.m_path
    self.m_path = {}
  else
    table.insert(self.m_path,pop)
  end
end

function Game:mouse(x,y)
  self.s2 = {x=x,y=y}
  self:makepath(self.s1,self.s2)
  self.m_path = {}
end

return Game