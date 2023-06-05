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

local currentTimer = 0

GFX.stateIndex = 1
local lastStateIndex = 0

function GFX.init()
    GFX.stateIndex = 1
    GFX.state = gfx_states[GFX.stateIndex].state
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
end

function GFX.draw()

end
