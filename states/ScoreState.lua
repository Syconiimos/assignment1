--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

BRONZE_THRESHOLD = 1
SILVER_THRESHOLD = 2
GOLD_THRESHOLD = 3


local medalOffsetY = 48


function ScoreState:init()
    self.bronze = Medal('bronze', VIRTUAL_WIDTH/2 - 48, VIRTUAL_HEIGHT/2 + medalOffsetY)
    self.silver = Medal('silver', VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2 + medalOffsetY)
    self.gold = Medal('gold', VIRTUAL_WIDTH/2 + 48, VIRTUAL_HEIGHT/2 + medalOffsetY)
end

function ScoreState:enter(params)
    self.timer = 0
    self.count = 3
    self.first = true
    self.count1 = 55
    self.bronze:hide()
    self.silver:hide()
    self.gold:hide()
    SHADER_ENABLED = true
    self.score = params.score
end

function ScoreState:exit()
    SHADER_ENABLED = false
    Effect.gaussianblur.sigma = 0.25
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
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
        if self.count > 0 and self.timer > 0.75 then
            self.timer = 0
            self.count = self.count - 1

            if self.count == 2 and self.score >= BRONZE_THRESHOLD then
                self.bronze:show()
                sounds['bronze']:play()
            elseif self.count == 1 and self.score >= SILVER_THRESHOLD then
                self.silver:show()
                sounds['silver']:play()
            elseif self.count == 0 and self.score >= GOLD_THRESHOLD then
                self.gold:show()
                sounds['gold']:play()
            end
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    self.bronze:render()
    self.silver:render()
    self.gold:render()
end