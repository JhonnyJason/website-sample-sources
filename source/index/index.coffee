###################################################################
# the Script
###################################################################
import Modules from "./modules"

global.allModules = Modules


window.onload = ->
    # document.addEventListener("deviceready", appStartup, true)
    ## Initialize Modules - ( basic DOM relevant iniializations )!
    for name, module of Modules
        module.initialize() 
    
    
    Modules.startupmodule.appStartup()
    



