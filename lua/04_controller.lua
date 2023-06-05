--controller
Controller = {}

CONTROLLER_STATES = {
    WAITING="waitin_for_input",
    SHUFFLE="shuffle",
    ROLLOUT="roll_out_number"
}

Controller.state = CONTROLLER_STATES.WAITING
Controller.lastState = nil

Controller.drawnNumbers = {}

function Controller.init()
    Controller.lastState = nil
    Controller.state = CONTROLLER_STATES.WAITING
end

function Controller.update()
    Controller.lastState = Controller.state

    if Controller.state == CONTROLLER_STATES.WAITING then
        if btnp(5) then
            Controller.state = CONTROLLER_STATES.SHUFFLE
        end
    elseif GFX.state == "ready" and Controller.state != CONTROLLER_STATES.WAITING then
        Controller.state = CONTROLLER_STATES.WAITING
        add(Controller.drawnNumbers,getNextNumber())
    end
end
