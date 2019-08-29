messageboxmodule = {name: "messageboxmodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["messageboxmodule"]?  then console.log "[messageboxmodule]: " + arg
    return

#region internal variables

#endregion internal variables

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
messageboxmodule.initialize = () ->
    log "messageboxmodule.initialize"
    

#region internal functions

#endregion internal functions

#region exposed variables

#endregion exposed functions

#region exposed functions

#endregion exposed functions



export default messageboxmodule


## Gathered functions and stuff
##===============================================================================
