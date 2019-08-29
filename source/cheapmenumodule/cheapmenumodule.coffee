menumodule = {name: "menumodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["menumodule"]?  then console.log "[menumodule]: " + arg
    return

#region variables
menuActivationButton = null
menuContentFrame = null
clickCatcher = null

homeButton = null
demo1Button = null
demo2Button = null
demo3Button = null
demo4Button = null
settingsButton = null
#endregion variables

#region exposed variables
menumodule.isActive = false
#endregion

menumodule.initialize = () ->
    log "menumodule.initialize"
    menuActivationButton = document.getElementById("cheapmenu-activation-button")
    menuContentFrame = document.getElementById("cheapmenu-content-frame")
    clickCatcher = document.getElementById("click-catcher")
    homeButton = document.getElementById("home-button")
    demo1Button = document.getElementById("demo1-button")
    demo2Button = document.getElementById("demo2-button")
    demo3Button = document.getElementById("demo3-button")
    demo4Button = document.getElementById("demo4-button")
    settingsButton = document.getElementById("settings-button")

    menuActivationButton.addEventListener("click", menuActivationButtonClicked)
    clickCatcher.addEventListener("click", clickCatcherClicked)
    homeButton.addEventListener("click", homeButtonClicked)
    demo1Button.addEventListener("click", demo1ButtonClicked)
    demo2Button.addEventListener("click", demo2ButtonClicked)
    demo3Button.addEventListener("click", demo3ButtonClicked)
    demo4Button.addEventListener("click", demo4ButtonClicked)
    settingsButton.addEventListener("click", settingsButtonClicked)

#region internal functions
clickCatcherClicked = ->
    log "clickCatcherClicked"
    menumodule.turnMenuDown()

menuActivationButtonClicked = ->
    log "menuActivationButtonClicked"
    menumodule.isActive = menuActivationButton.classList.contains("is-active")
    if menumodule.isActive then menumodule.turnMenuDown()
    else menumodule.turnMenuUp()

homeButtonClicked = ->
    log "homeButtonClicked"
    allModules.pagemodule.load("homepage")
    menumodule.turnMenuDown()

settingsButtonClicked = ->
    log "settingsButtonClicked"
    allModules.pagemodule.load("settingspage")
    menumodule.turnMenuDown()

demo1ButtonClicked = ->
    log "demo1ButtonClicked"
    allModules.pagemodule.load("demo1page")
    menumodule.turnMenuDown()

demo2ButtonClicked = ->
    log "demo2ButtonClicked"
    allModules.pagemodule.load("demo2page")
    menumodule.turnMenuDown()

demo3ButtonClicked = ->
    log "demo3ButtonClicked"
    allModules.pagemodule.load("demo3page")
    menumodule.turnMenuDown()

demo4ButtonClicked = ->
    log "demo4ButtonClicked"
    allModules.pagemodule.load("demo4page")
    menumodule.turnMenuDown()
#endregion    


#region exposed functions
menumodule.turnMenuDown = ->
    log "turnMenuDown"
    menumodule.isActive = false
    menuActivationButton.classList.remove("is-active")
    menuContentFrame.classList.remove("is-here")
    clickCatcher.classList.remove("active")

menumodule.turnMenuUp = ->
    log "turnMenuUp"
    menumodule.isActive = true
    menuActivationButton.classList.add("is-active")
    menuContentFrame.classList.add("is-here")
    clickCatcher.classList.add("active")

    
#endregion
export default menumodule
