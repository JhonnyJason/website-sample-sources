appcontrolmodule = {name: "appcontrolmodule", uimodule: false}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["appcontrolmodule"] then console.log "[appcontrolmodule]: " + arg
    return

#region internal variables
alive = true
#endregion

#region exposed variables
appcontrolmodule.isPaused = false
#endregion

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
appcontrolmodule.initialize = () ->
    log "appcontrolmodule.initialize"

appcontrolmodule.startupCheck = () ->
    log "appcontrolmodule.startupCheck"
    document.addEventListener("pause", onPause, false);
    document.addEventListener("resume", onResume, false);
    document.addEventListener("backbutton", appcontrolmodule.backFunction, true)

#region internal functions
onPause = ->
    log 'onPause'
    return unless alive
    appcontrolmodule.isPaused = true
    if allModules.programcontrollermodule.programIsActive
        allModules.notificationmodule.addControlBar()
    else
        allModules.bluetoothconnectionmodule.triggerStayAliveTimeout()
    return

onResume = ->
    log 'onResume'
    allModules.notificationmodule.clearAll()
    return unless alive
    appcontrolmodule.isPaused = false
    allModules.bluetoothconnectionmodule.defuseStayAliveTimeout()

    return
#endregion

#region exposed functions
appcontrolmodule.killApp = ->
    log 'appcontrolmodule.killApp'
    allModules.notificationmodule.clearAll()
    if allModules.programcontrollermodule.programIsActive
        allModules.programcontrollermodule.appKillAttempt()
    else
        appcontrolmodule.ultimativeKill()
    return

appcontrolmodule.ultimativeKill = ->
    log "ultimativeKill"
    alive = false
    allModules.bluetoothconnectionmodule.disconnect()
    allModules.notificationmodule.clearAll()
    navigator.app.exitApp()
    return

appcontrolmodule.backFunction = (event) -> 
    log "appcontrolmodule.backFunction"
    event.stopPropagation()
    allModules.pagemodule.back()

#endregion
export default appcontrolmodule
