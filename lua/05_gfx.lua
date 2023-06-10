--gfx

GFX = {}

local gfx_states = {
    {
        state="ready",
        duration=0 --duration not needed in ready
    },
    {
        state="shuffle",
        duration=60
    },
    {
        state="roll_out",
        duration=15
    },
}

local aniFrames = 8
local curAniFrames = aniFrames
local curAniIndex = 1

local idleAnimationDog={
    { x=78, y=0 },
    { x=0,y=39}
}

local shuffleAnimationDog = {
    { x=0, y=0 },
    { x=39,y=0}
}

local ballPosY1 = 86
local ballPosY2 = 110

local curBallPosY

local animations = {
    ready={ dog=idleAnimationDog },
    shuffle = { dog=shuffleAnimationDog },
    roll_out= { dog=idleAnimationDog },
}

local currentTimer = 0

GFX.stateIndex = 1
local lastStateIndex = 0

function GFX.init()
    GFX.stateIndex = 1
    GFX.state = gfx_states[GFX.stateIndex].state
    curAniFrames = aniFrames
    curAniIndex = 1
end

function GFX.update()
    local newState = nil
    if Controller.state != Controller.lastState then 
        newState = Controller.state
    end

    if newState then
        print("new state: "..newState)
        if newState == CONTROLLER_STATES.SHUFFLE then
            GFX.stateIndex = 2
            currentTimer = gfx_states[GFX.stateIndex].duration
            print(gfx_states[GFX.stateIndex].state)
        end        
    end

    GFX.state = gfx_states[GFX.stateIndex].state

    if GFX.stateIndex > 1 then
        currentTimer -= 1

        if currentTimer <= 0 then
            if GFX.stateIndex == #gfx_states then
                GFX.stateIndex = 1
            else
                GFX.stateIndex += 1
                currentTimer = gfx_states[GFX.stateIndex].duration
            end

            print(gfx_states[GFX.stateIndex].state)
        end
    end

    if gfx_states[GFX.stateIndex].state == 'roll_out' then
        local duration = gfx_states[GFX.stateIndex].duration
        curBallPosY = (duration- currentTimer) / duration * (ballPosY2 - ballPosY1) + ballPosY1
    end

    curAniFrames -= 1
    if curAniFrames <= 0 then
        curAniFrames = aniFrames
        curAniIndex += 1
        if curAniIndex == 3 then curAniIndex = 1 end
    end
end

function GFX.draw()
    print("karlis tombola", 37, 2, 11)
    line(35,8,93,8,11)
    local pos = {x=24,y=45}
    cur_ani = animations[gfx_states[GFX.stateIndex].state]
    sspr(40,39,41,39,pos.x+36,pos.y)
    drawDog(pos)
    if gfx_states[GFX.stateIndex].state == 'ready' then
        print("press x to draw a number", 15, 25, 9)
    end

    if gfx_states[GFX.stateIndex].state == 'roll_out' then
        circfill(84,curBallPosY,5,6)
    end

    if #Controller.drawnNumbers > 0 then
        local scrollPos = 0
        local shownNumbersCount = #Controller.drawnNumbers
        if #Controller.drawnNumbers > 11 then
            scrollPos = #Controller.drawnNumbers - 11
            shownNumbersCount = 11
        end

        for i=1,shownNumbersCount do
            local number = Controller.drawnNumbers[i+scrollPos]
            local col = 13
            local numStr = ""..number
            if number < 10 then numStr = "0"..number end
            if i == shownNumbersCount then
                col = 9
                circfill(84,ballPosY2,5,6)
                print(""..numStr, 81, ballPosY2-2,1)
            end           

            print(""..numStr, i*10, 120,col)
        end
    end

    if btn(4) then
        print(#Controller.drawnNumbers.."/"..#availableNumbers)
    end
end

function drawDog(pos)
    local currentSpr = cur_ani.dog[curAniIndex]
    if currentSpr then
        sspr(currentSpr.x,currentSpr.y,39,39,pos.x,pos.y)
    end
end
