animationRaw = {
  [1] = love.graphics.newCanvas(100, 100), 
  [2] = love.graphics.newCanvas(100, 100),
  [3] = love.graphics.newCanvas(100, 100),
  [4] = love.graphics.newCanvas(100, 100),
}

--local baseFps = 60

--local frame = 1 -- currect frame, that will be drawed
--local frameRateHuman = 30
--local frameRate = 1 / frameRateHuman
--local curFrameTime = 0 -- value used to determine elapsed time to update animation frame

love.graphics.setCanvas(animationRaw[1])
love.graphics.setColor(1, 1, 1, 1)
love.graphics.circle("line", 50, 50, 50, 50)
love.graphics.print("frame 1")
love.graphics.setColor(1, 1, 0.5, 1)
love.graphics.rectangle("line", 20, 20, 20, 20)
love.graphics.setCanvas()

love.graphics.setCanvas(animationRaw[2])
love.graphics.setColor(1, 1, 1, 1)
love.graphics.circle("line", 50, 50, 50, 50)
love.graphics.print("frame 2")
love.graphics.setColor(1, 0.4, 1, 1)
love.graphics.rectangle("line", 20, 20, 20, 20)
love.graphics.setCanvas()

love.graphics.setCanvas(animationRaw[3])
love.graphics.setColor(1, 1, 1, 1)
love.graphics.circle("line", 50, 50, 50, 50)
love.graphics.print("frame 3")
love.graphics.setColor(0.5, 1, 1, 1)
love.graphics.rectangle("line", 20, 20, 20, 20)
love.graphics.setCanvas()

love.graphics.setCanvas(animationRaw[4])
love.graphics.setColor(1, 1, 1, 1)
love.graphics.circle("line", 50, 50, 50, 50)
love.graphics.print("frame 4")
love.graphics.setColor(0.5, 1, 0.4, 1)
love.graphics.rectangle("line", 20, 20, 20, 20)
love.graphics.setCanvas()

local anim = require("animation_resolution")

anim.newAnimation({{animationRaw[1]}, {animationRaw[2]}, {animationRaw[3]}, {animationRaw[4]}, name = "test", r = true})
anim.newAnimation({{animationRaw[1]}, {animationRaw[2]}, {animationRaw[3]}, name = "test2"})

love.update = function(dt)
  anim.update(dt)
end

love.draw = function()
  love.graphics.draw(anim.getFrame("test"), 10, 10)
--  love.graphics.draw(anim.getFrame("test2"), 200, 200)
end


print(anim.check("test"))
print(anim.check("test2"))
anim.removeAnimation("test2")
print(anim.check("test2"))

love.keypressed = function(key)
  if key == "1" then anim.switchRepeat("test") end
  if key == "2" then anim.switchPause("test") end
  if key == "3" then anim.switchPause_("test") end
  if key == "4" then anim.removeFrame("test", 1) end
  if key == "5" then anim.insertFrame("test", {animationRaw[1]}) end
  if key == "6" then anim.changeFrameImage("test", 1, animationRaw[3]) end
  if key == "7" then anim.swapFrames("test", 1, 3) end
  if key == "8" then anim.overwriteDurablity("test", 1000) end
  if key == "8" then anim.overwriteDurablity("test", 1000) end
--  if key == "9" then anim.rename("test", "lol") end
  end