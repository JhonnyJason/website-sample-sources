homepagemodule = {name: "homepagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["homepagemodule"]?  then console.log "[homepagemodule]: " + arg
    return


##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
homepagemodule.initialize = () ->
    log "homepagemodule.initialize"

export default homepagemodule
