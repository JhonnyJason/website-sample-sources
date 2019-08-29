stateguardianmodule = {name: "stateguardianmodule", uimodule: false}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["stateguardianmodule"] then console.log "[stateguardianmodule]: " + arg
    return

class StateGuardian
    constructor: (states, @id) ->
        # log "constructor: " + states
        @idToState = []
        @stateToId = {}
        @currentStateId = undefined
        @currentStateName = undefined
        @stateTransitionMap = []
        @idToApplyFuctions = []
        return unless states
        id = 0
        for state in states
            @idToState[id] = state
            @idToApplyFuctions[id] = undefined
            @stateToId[state] = id
            id++
        for fromStateId of @idToState
            @stateTransitionMap[fromStateId] = []
            for toStateId of @idToState
                @stateTransitionMap[fromStateId][toStateId] = undefined
        
    setStateTo: (state) ->
        id = @getStateId(state)
        name = @idToState[id]

        @currentStateName = name
        @currentStateId =  id

        if @idToApplyFuctions[id]? then @idToApplyFuctions[id]() 
        @printCurrentState()

    stateTransitionTo: (state) ->
        if state == @currentStateId || state == @currentStateName then return
        @printCurrentState()
        log "stateTransitionTo: " + state
        if !(@currentStateId?) || !(@currentStateName?) 
            log "Error: cannot do state Transition from non valid initial State!"
            @printCurrentState()
            return     
        toStateId = @getStateId(state)
        if (@stateTransitionMap[@currentStateId][toStateId])?
            (@stateTransitionMap[@currentStateId][toStateId])()
            @setStateTo(toStateId)

    addState: (state) -> return
    removeState: (state) -> return
    setVerbosityLevel: (verbosity) -> return

    addStateTransition: (fromState, toState, transitionFunction) ->
        fromStateId = @getStateId(fromState)
        toStateId = @getStateId(toState)
        log "state Transition: " + fromStateId + " -> " + toStateId
        @stateTransitionMap[fromStateId][toStateId] = transitionFunction

    setApplyStateFunction: (state, func) ->
        stateId = @getStateId(state)
        @idToApplyFuctions[stateId] = func

    getStateId: (state) ->
        if typeof state == "string"
            id = @stateToId[state]
            if id? then return id
            log "Error state " + state + " was not found!"
            return 
        else if typeof state == "number"
            if @idToState.length > state then return state
            log "Error id " + state + "was not found!"
            return 

    printAllStates: -> 
        printstring = ""
        for state in @idToState
            printstring += "state: " + state + " id: " + @stateToId[state] + "\n"
        log printstring

    printCurrentState: -> 
        log "currentStateId: " + @currentStateId
        log "currentStateName: " + @currentStateName


#region internal variables
stateGuardians = []
#endregion

#region exposed variables

#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
stateguardianmodule.initialize = () ->
    log "stateguardianmodule.initialize"

stateguardianmodule.startupCheck = () ->
    log "stateguardianmodule.startupCheck"

#region Internal Functions

#endregion

#region Exposed Functions
stateguardianmodule.getNewStateGuardian = (states) ->
    log "stateguardianmodule.newStateGuardian"
    id = stateGuardians.length
    stateGuardian = new StateGuardian(states, id)
    stateGuardians.push(stateGuardian)
    return stateGuardian

#endregion
export default stateguardianmodule
