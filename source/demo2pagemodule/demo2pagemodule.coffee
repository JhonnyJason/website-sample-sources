demo2pagemodule = {name: "demo2pagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["demo2pagemodule"]?  then console.log "[demo2pagemodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
demo2pagemodule.initialize = () ->
    log "demo2pagemodule.initialize"

export default demo2pagemodule
