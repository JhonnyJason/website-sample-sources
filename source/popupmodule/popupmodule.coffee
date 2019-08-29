popupmodule = {name: "popupmodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["popupmodule"]? then console.log "[popupmodule]: " + arg
    return



## popup elements
popupTitle = null
popupMessage = null
popupConfirmButton = null
popupCancelButton = null
clickCatcher = null
popupFrame = null 

confirmCallback = null
cancelCallback = null

popupmodule.active = false


##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
popupmodule.initialize = () ->
    log "popupmodule.initialize"
    ## cache all the UI elements
    popupTitle = document.getElementById("popup-title")
    popupMessage = document.getElementById("popup-message")
    popupConfirmButton = document.getElementById("popup-confirm-button")
    popupCancelButton = document.getElementById("popup-cancel-button")
    clickCatcher = document.getElementById("click-catcher")
    popupFrame = document.getElementById("popup-frame")

    # adding the event listeners
    clickCatcher.addEventListener("click", clickCatcherActivated, true)
    popupCancelButton.addEventListener("click", cancelButtonActivated, true)
    popupConfirmButton.addEventListener("click", confirmButtonActivated, true)
    document.getElementById("popup-close-button").addEventListener("click", closeButtonActivated, true)
    
#region
clickCatcherActivated = () ->
    log "clickCatcherActivated"
    popupmodule.turnPopupDown()
    
closeButtonActivated = () ->
    log "closeButtonActivated"
    popupmodule.turnPopupDown()
    
confirmButtonActivated = () ->
    log "confirmButtonActivated"
    popupmodule.turnPopupDown()
    confirmCallback()

cancelButtonActivated = () ->
    log "cancelButtonActivated"
    popupmodule.turnPopupDown()
    cancelCallback()

popupmodule.askUserBinary = (title, message, confirmText, confirmFunction, cancelText, cancelFunction) ->
    log "popupmodule.askUserBinary"
    popupmodule.turnPopupDown()
    confirmCallback = confirmFunction
    cancelCallback = cancelFunction
    popupmodule.active = true
    popupTitle.textContent = title
    popupMessage.textContent = message
    popupConfirmButton.textContent = allModules.languagemodule.languageTextFromKey("popupConfirmButtonText")
    if confirmText then popupConfirmButton.textContent = confirmText
    popupCancelButton.textContent = allModules.languagemodule.languageTextFromKey("popupCancelButtonText")
    if cancelText then popupCancelButton.textContent = cancelText
    clickCatcher.classList.add("active")
    popupFrame.classList.add("active", "decision")

popupmodule.informUser = (info) ->
    log "popupmodule.informUser"
    popupmodule.turnPopupDown()
    confirmCallback = ->
        return
    cancelCallback = ->
        return
    popupmodule.active = true
    title = allModules.languagemodule.languageTextFromKey("popupInfoTitleText")
    popupTitle.textContent = title
    popupMessage.textContent = info
    popupConfirmButton.textContent = allModules.languagemodule.languageTextFromKey("popupAcceptButtonText")
    clickCatcher.classList.add("active")
    popupFrame.classList.add("active", "info")
    
popupmodule.warnUser = (message) ->
    log "popupmodule.warnUser"
    popupmodule.turnPopupDown()
    confirmCallback = ->
        return
    cancelCallback = ->
        return
    popupmodule.active = true
    title = allModules.languagemodule.languageTextFromKey("popupWarningTitleText")
    popupTitle.textContent = title
    popupMessage.textContent = message
    popupConfirmButton.textContent = allModules.languagemodule.languageTextFromKey("popupAcceptButtonText")
    clickCatcher.classList.add("active")
    popupFrame.classList.add("active", "warning")

popupmodule.turnPopupDown = ->
    log "popupmodule.turnPopupDown"
    popupmodule.active = false
    clickCatcher.classList.remove("active")
    popupFrame.classList.remove("active", "info", "decision", "warning")


#endregion

export default popupmodule
