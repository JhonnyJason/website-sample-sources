demo4pagemodule = {name: "demo4pagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["demo4pagemodule"]?  then console.log "[demo4pagemodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
demo4pagemodule.initialize = () ->
    log "demo4pagemodule.initialize"

export default demo4pagemodule
