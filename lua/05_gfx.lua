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
        duration=60
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

    curAniFrames -= 1
    if curAniFrames <= 0 then
        curAniFrames = aniFrames
        curAniIndex += 1
        if curAniIndex == 3 then curAniIndex = 1 end
    end
end

function GFX.draw()
    local pos = {x=24,y=45}
    cur_ani = animations[gfx_states[GFX.stateIndex].state]
    sspr(40,39,41,39,pos.x+36,pos.y)
    drawDog(pos)
end

function drawDog(pos)
    local currentSpr = cur_ani.dog[curAniIndex]
    if currentSpr then
        sspr(currentSpr.x,currentSpr.y,39,39,pos.x,pos.y)
    end
end
