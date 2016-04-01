Life = require("life")
Game = require("game")
color = require("color")
love.window.setMode(500,500,{msaa=8})

function love.load()
  game = Game:new()
  life = Life:new()
  life:addAni(
  	function() 
  		game:draw()
  	end,
  	function()
  		game:update()
  	end,
  	1/120,"forever")
end
function love.mousemoved(x,y)
  game:mouse(x,y)
end
function love.update(dt)
  love.window.setTitle(string.format("x1: %d y1: %d x2: %d y2: %d",game.s1.x,game.s1.y,game.s2.x,game.s2.y))
  life:update(dt)
end

function love.draw()
  life:draw()
  love.graphics.setBackgroundColor(color.bgcolor)
end
