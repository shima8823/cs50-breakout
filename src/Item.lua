Item = Class{}

function Item:init(x, y, skin)
    self.x = x
    self.y = y

    self.width = 16
    self.height = 16

    self.dy = math.random(40, 60)

    self.skin = skin
    self.inPlay = false
end

function Item:hit()
    self.inPlay = false
    if self.skin == 1 then
        gSounds['recover']:play()
    elseif self.skin == 2 then
        gSounds['hurt']:play()
    elseif self.skin == 3 then
        gSounds['confirm']:play()
    end
end

function Item:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end

function Item:update(dt)
    if not self.inPlay then
        return
    end
    self.y = self.y + self.dy * dt

    if self.y <= 0 then
        self.inPlay = false
    end
end

function Item:render()
    if not self.inPlay then
        return
    end
    -- gTexture is our global texture for all blocks
    love.graphics.draw(gTextures['main'], gFrames['item'][self.skin], self.x, self.y)
end