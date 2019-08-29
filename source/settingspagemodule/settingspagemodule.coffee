settingspagemodule = {name: "settingspagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["settingspagemodule"]?  then console.log "[settingspagemodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
settingspagemodule.initialize = () ->
    log "settingspagemodule.initialize"


export default settingspagemodule
