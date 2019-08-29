specialmenumodule = {name: "specialmenumodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["specialmenumodule"]?  then console.log "[specialmenumodule]: " + arg
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
specialmenumodule.isActive = false
#endregion

specialmenumodule.initialize = () ->
    log "specialmenumodule.initialize"
    menuActivationButton = document.getElementById("specialmenu")
    # menuContentFrame = document.getElementById("")
    # clickCatcher = document.getElementById("click-catcher")
    # homeButton = document.getElementById("home-button")
    # demo1Button = document.getElementById("demo1-button")
    # demo2Button = document.getElementById("demo2-button")
    # demo3Button = document.getElementById("demo3-button")
    # demo4Button = document.getElementById("demo4-button")
    # settingsButton = document.getElementById("settings-button")

    menuActivationButton.addEventListener("mousedown", specialmenuDowned)
    menuActivationButton.addEventListener("mouseleave", specialmenuLeft)
    menuActivationButton.addEventListener("mouseup", specialmenuUpped)
    
    # clickCatcher.addEventListener("click", clickCatcherClicked)
    # homeButton.addEventListener("click", homeButtonClicked)
    # demo1Button.addEventListener("click", demo1ButtonClicked)
    # demo2Button.addEventListener("click", demo2ButtonClicked)
    # demo3Button.addEventListener("click", demo3ButtonClicked)
    # demo4Button.addEventListener("click", demo4ButtonClicked)
    # settingsButton.addEventListener("click", settingsButtonClicked)

#region internal functions
specialmenuDowned = ->
    log "specialmenuDowned"

specialmenuLeft = ->
    log "specialmenuLeft"

specialmenuUpped = ->
    log "specialmenuUpped"

clickCatcherClicked = ->
    log "clickCatcherClicked"
    specialmenumodule.turnMenuDown()

menuActivationButtonClicked = ->
    log "menuActivationButtonClicked"
    specialmenumodule.isActive = menuActivationButton.classList.contains("is-active")
    if specialmenumodule.isActive then specialmenumodule.turnMenuDown()
    else specialmenumodule.turnMenuUp()

homeButtonClicked = ->
    log "homeButtonClicked"
    allModules.pagemodule.load("homepage")
    specialmenumodule.turnMenuDown()

settingsButtonClicked = ->
    log "settingsButtonClicked"
    allModules.pagemodule.load("settingspage")
    specialmenumodule.turnMenuDown()

demo1ButtonClicked = ->
    log "demo1ButtonClicked"
    allModules.pagemodule.load("demo1page")
    specialmenumodule.turnMenuDown()

demo2ButtonClicked = ->
    log "demo2ButtonClicked"
    allModules.pagemodule.load("demo2page")
    specialmenumodule.turnMenuDown()

demo3ButtonClicked = ->
    log "demo3ButtonClicked"
    allModules.pagemodule.load("demo3page")
    specialmenumodule.turnMenuDown()

demo4ButtonClicked = ->
    log "demo4ButtonClicked"
    allModules.pagemodule.load("demo4page")
    specialmenumodule.turnMenuDown()
#endregion    


#region exposed functions
specialmenumodule.turnMenuDown = ->
    log "turnMenuDown"
    specialmenumodule.isActive = false
    menuActivationButton.classList.remove("is-active")
    menuContentFrame.classList.remove("is-here")
    clickCatcher.classList.remove("active")

specialmenumodule.turnMenuUp = ->
    log "turnMenuUp"
    specialmenumodule.isActive = true
    menuActivationButton.classList.add("is-active")
    menuContentFrame.classList.add("is-here")
    clickCatcher.classList.add("active")

    
#endregion
export default specialmenumodule
