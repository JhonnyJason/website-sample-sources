backgroundmodule = {name: "backgroundmodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["backgroundmodule"]?  then console.log "[backgroundmodule]: " + arg
    return
##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
backgroundmodule.initialize = () ->
    log "backgroundmodule.initialize"


export default backgroundmodule
