Medal = Class{}

local medals = {
    ["none"] = love.graphics.newImage("No_Medal.png"),
    ["bronze"] = love.graphics.newImage("Bronze_Medal.png"),
    ["silver"] = love.graphics.newImage("Silver_Medal.png"),
    ["gold"] = love.graphics.newImage("Gold_Medal.png")
}


function Medal:init(type, x, y)
    self.type = type
    self.x = x
    self.y = y
    self.width = 24
    self.height = 38
    self.enabled = false
end

function Medal:show()
    self.enabled = true
end

function Medal:hide()
    self.enabled = false
end

function Medal:render()
    if self.enabled then
        love.graphics.draw(medals[self.type], self.x - self.width/2, self.y + self.height/2)
    else
        love.graphics.draw(medals["none"], self.x - self.width/2, self.y + self.height/2)
    end
end