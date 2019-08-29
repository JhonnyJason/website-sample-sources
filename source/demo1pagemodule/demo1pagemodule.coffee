demo1pagemodule = {name: "demo1pagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["demo1pagemodule"]?  then console.log "[demo1pagemodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
demo1pagemodule.initialize = () ->
    log "demo1pagemodule.initialize"

export default demo1pagemodule
