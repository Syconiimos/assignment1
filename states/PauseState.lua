PauseState = Class{__includes = BaseState}


function PauseState:init()
    
end

function PauseState:enter(PlayState)
    SHADER_ENABLED = true
    scrolling = false
    self.PlayState = PlayState
    self.first = true
    self.timer = 0
    self.count1 = 55
    shaders:addToRender(self.PlayState)
end

function PauseState:exit()
    SHADER_ENABLED = false
    Effect.gaussianblur.sigma = 0.25
    shaders:removeFromRender(self.PlayState)
end

function PauseState:update(dt)
    self.timer = self.timer + dt

    if self.first then
        if self.timer > 0.002 and self.count1 > 0 then
            self.count1 = self.count1 - 1
            self.timer = 0
            Effect.gaussianblur.sigma = 0.25 + (0.05*(55 - self.count1))
        elseif self.count1 <= 0 then
            self.first = false
        end
    else
        if love.keyboard.wasPressed('p') then
            gStateMachine:change('countdown', self.PlayState)
        end
    end
end

function PauseState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Paused', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
end