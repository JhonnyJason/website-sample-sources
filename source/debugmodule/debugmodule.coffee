debugmodule = {name: "debugmodule", uimodule: false}

debugmodule.debugMode = false

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
debugmodule.initialize = () ->
    console.log "debugmodule.initialize - nothing to do"

debugmodule.modulesToDebug = 
    unbreaker: true
    ## UI modules
    # pagemodule: true
    # backgroundmodule: true
    # homepagemodule: true
    # settingspagemodule: true
    # demo1pagemodule: true
    # demo2pagemodule: true
    # demo3pagemodule: true
    # demo4pagemodule: true
    ## the quite verbose languagemodule
    # languagemodule: true
    ## functional modules
    # appcontrolmodule: true
    # configmodule: true
    # messageboxmodule: true
    # networkmodule: true
    # utilmodule: true
    # popupmodule: true
    # stateguardianmodule: true
    specialmenumodule: true
    
#region exposed variables

export default debugmodule
