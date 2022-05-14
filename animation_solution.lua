local anim = {}

anim.animations = {}

-- if in anim.newAnimation repeating was not specified, this will be used instead
anim.defaultRepeating = true
-- if in anim.newAnimation pause was not specified, this will be used instead
anim.defaultPause = false
-- if in anim.newAnimation durablity was not specified, this will be used instead
anim.defaultDuration = 250 / 1000

anim.switchRepeat = function(name)
  anim.animations[name].r = not anim.animations[name].r
  end

anim.switchPause = function(name)
  anim.animations[name].p = not anim.animations[name].p
end

anim.switchPause_ = function(name)
  anim.animations[name].p = not anim.animations[name].p
  anim.animations[name].frameTime = 0
end

anim.finished = function(name)
  -- callback
end

anim.update = function(dt)
  for i, animation in pairs(anim.animations) do
    if not animation.p then
    if animation.r or not animation.r and animation.frame < animation.nFrames then
      
      animation.frameTime = animation.frameTime + dt
      ::reCheck::
      if animation.frameTime >= animation[animation.frame][2] then
        animation.frameTime = animation.frameTime - animation[animation.frame][2]
        if animation.frameTime > 0 then animation.frameTime = 0 end
        animation.frame = animation.frame + 1
        
        -- callback when non loopable animation finished
        if animation.r and animation.frame == animation.nFrames then anim.finished(animation.name) end
        if animation.frame > animation.nFrames then animation.frame = 1 end
        goto reCheck
      end
      
      end
      end
  end
end

anim.removeAnimation = function(name)
  -- simply remove animation bu nil'ing it...
  anim.animations[name] = nil
  end

anim.removeAllAnimations = function()
  anim.animations = {}
  end

anim.newAnimation = function(animations)
  
  --[[
  {
    { -- frame 1
      [1] = image,
      [2] = 100, -- time in ms
      -- width = 100,
      -- height = 100,
    },
    { -- frame 2
      [1] = image,
      [2] = 100, -- time in ms
      -- width = 100,
      -- height = 100,
    }
    p = false, -- pause = false,
    v = true,  -- visible = true
    r = true,  -- repeating = true
    name = "name", -- should always be specified at anim.newAnimation() and also better to not change manually it or else everything will explode
    -- nFrames = 2,
    -- frame = 1,
    -- frameTime = 0,
  }
  
  anim.newAnimation({
  {love.graphics.newImage("test.png")},
  {love.graphics.newImage("test2.png")},
  name = "test"
  })
  --]]
  
  for i = 1, #animations do
    -- frame duration
    if animations[i][2] == nil then animations[i][2] = anim.defaultDuration end
    animations[i].width = animations[i][1]:getWidth()
    animations[i].height = animations[i][1]:getHeight()
  end

  animations.frame = 1
  animations.frameTime = 0
  animations.nFrames = #animations
  
  if animations.r == nil then animations.r = anim.defaultRepeating end
  if animations.p == nil then animations.p = anim.defaultPause end
  
  anim.animations[animations.name] = animations
end

anim.check = function(name)
  -- check if animation exist
  if anim.animations[name] then
    return true
  else
    return false
  end

end


--[[
anim.rename = function(oldName, newName)
  anim.animations[oldName] = anim.animations[newName]
  anim.animations[oldName] = nil
  anim.animations[newName].name = newName
  print(anim.animations[oldName], anim.animations[newName])
end
--]]

anim.removeFrame = function(name, nFrame)
  table.remove(anim.animations[name], nFrame)
  anim.animations[name].frame = 1
  anim.animations[name].frameTime = 0
  anim.animations[name].nFrames = #anim.animations[name]
end

anim.insertFrame = function(name, frameData)
  -- insert new frame at the end of table as in "table.insert, except you can't specify another position;
  -- use the same notation as in anim.newAnimation
  local size = #anim.animations[name]
  frameData[2] = frameData[2] or anim.defaultDuration
  frameData.width = frameData[1]:getWidth()
  frameData.height = frameData[1]:getHeight()
  anim.animations[name].nFrames = size + 1
  anim.animations[name].frame = 1
  anim.animations[name].frameTime = 0
  table.insert(anim.animations[name], size, frameData)
end

anim.changeFrameImage = function(name, frame, image)
  anim.animations[name][frame][1] = image
  anim.animations[name][frame].width = image:getWidth()
  anim.animations[name][frame].height = image:getHeight()
  anim.animations[name].frame = 1
  anim.animations[name].frameTime = 0
end

anim.swapFrames = function(name, firstFrame, secondFrame)
  -- swap 2 frames from same animation "object"
  anim.animations[name][firstFrame], anim.animations[name][secondFrame] = anim.animations[name][secondFrame], anim.animations[name][firstFrame]
  anim.animations[name].frame = 1
  anim.animations[name].frameTime = 0
end

anim.overwriteDurablity = function(name, ms)
  -- overwrite all frames durablity to that value
  -- value should be specified in milliseconds
  for i = 1, anim.animations[name].nFrames do
    anim.animations[name][i][2] = ms / 1000
  end
  anim.animations[name].frame = 1
  anim.animations[name].frameTime = 0
end

anim.changeDurablity = function(name, frame, ms)
  anim.animations[name][frame][2] = ms / 1000 
end

anim.getFrame = function(name)
  -- get image of currect animation to draw it
  return anim.animations[name][anim.animations[name].frame][1]
end

return anim