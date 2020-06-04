ShaderDraw = Class{}

function ShaderDraw:init()
    self.renderList = {}
    self.lookupTable = {}
    self.length = 0
end


function ShaderDraw:addToRender(drawable)
    print(drawable)
    table.insert(self.renderList, drawable)
    self.length = self.length+1
    self.lookupTable[drawable] = self.length
end

function ShaderDraw:removeFromRender(drawable)
    table.remove(self.renderList, self.lookupTable[drawable])
end

function ShaderDraw:render()
    Effect.draw(function()
        for i, v in pairs(self.renderList) do
            v:render()
        end
    end)
end