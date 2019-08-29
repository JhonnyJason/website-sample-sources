demo3pagemodule = {name: "demo3pagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["demo3pagemodule"]?  then console.log "[demo3pagemodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
demo3pagemodule.initialize = () ->
    log "demo3pagemodule.initialize"

export default demo3pagemodule
