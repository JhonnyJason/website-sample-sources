pagemodule = {name: "pagemodule", uimodule: true}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["pagemodule"] then console.log "[pagemodule]: " + arg
    return

#region Internal Variables
#All Pages available trough allPageByNames["pagename"]
allPagesByName = {}

#Routing State 
programHistoryStack = []
statisticsHistoryStack = []
settingsHistoryStack = []
loginHistoryStack = []
currentActiveHistoryStack = null
latestActiveHistoryStack = null

## TODO probably remove this variable to get the information from the programs MOdule or so...
programRunningPageIsActive = false

currentPage = null
currentPageName = ""

## set animation Time 
## !! tied together with pagemodule-intro-time in index.styl of mainapp
animationTime = "0.7s"
#endregion

##initialization function
pagemodule.initialize = () ->
    log "pagemodule.initialize"
    #prepare all the pages
    for node in document.getElementById("pages-container").children
        allPagesByName[node.id] = node
        node.classList = "page bottom-off"
        node.style.animationDuration = animationTime
        node.style.animationFillMode = "forwards"
        node.style.animationIterationCount = "1"
    
    pagemodule.load("homepage")

#region Internal Functions
afterPageSwitch = ->
    log "afterPageSwitch"

## animation functions
animationPagePairSlidingRightOff = (leftPage, rightPage) ->
    log "animationPagePairSlidingRightOff"
    leftPage.style.zIndex = 50
    rightPage.style.zIndex = 50
    leftPage.classList = "page left-off"
    rightPage.classList = "page"
    rightPage.style.animationName = "leave-right"
    leftPage.style.animationName = "enter-left"
animationPagePairSlidingLeftOff = (leftPage, rightPage) ->
    log "[pagemodule]: animationPagePairSlidingLeftOff"
    leftPage.style.zIndex = 50
    rightPage.style.zIndex = 50
    leftPage.classList = "page"
    rightPage.classList = "page righ-off"
    rightPage.style.animationName = "enter-right"
    leftPage.style.animationName = "leave-left"
animationPageIntroFromBelow = (newPage) ->
    log "animationPageIntroFromBelow"
    currentPage.style.zIndex = 40 if currentPage
    currentPage.classList = "page" if currentPage
    newPage.style.zIndex = 50
    newPage.classList = "page bottom-off"
    newPage.style.animationName = "enter-upwards"
    currentPage.style.animationName = "disappear" if currentPage
animationPageOutroToBottom = (newPage) ->
    log "animationPageOutroToBottom"
    newPage.style.zIndex = 45
    newPage.classList = "page"
    currentPage.style.zIndex = 50 if currentPage
    currentPage.classList = "page" if currentPage
    newPage.style.animationName = "appear"
    currentPage.style.animationName = "leave-downwards" if currentPage

## utility functions        
cleanHistory = () ->
    log "cleanHistory"
    cleanHistoryStack(programHistoryStack)
    cleanHistoryStack(statisticsHistoryStack)
    cleanHistoryStack(settingsHistoryStack)

    latestActiveHistoryStack = null
    currentActiveHistoryStack = null

cleanHistoryStack = (historyStack) ->
    log "cleanHistoryStack"
    while historyStack.length
        obj = historyStack.pop()
        if(typeof obj is "object")
            obj.backHook()

## here we willalways navigate back to the progmram page with the currently running program
backProgramRunningPageIsActive = ->
    log "backProgramRunningPageIsActive"
    if currentPageName is "programrunningpage"
        popuptitle = allModules.languagemodule.languageTextFromKey("quitProgramPopupTitle")
        popupmessage = allModules.languagemodule.languageTextFromKey("quitProgramPopupMessage")
        noFunction = -> 
            pagemodule.load("homepage")
        yesFunction = -> 
            allModules.programcontrollermodule.quitProgram()
        allModules.popupmodule.askUserBinary(popuptitle, popupmessage, false, yesFunction, false, noFunction)
    else 
        pagemodule.load("programrunningpage")

## the regular case of the back button being pressed
backRegular = ->
    log "backRegular"
    if(currentActiveHistoryStack.length > 1)
        obj = currentActiveHistoryStack.pop()
        if(typeof obj is "object")
          currentActiveHistoryStack.push(obj.pageName)
          obj.backHook()
          return
    else
        log "we're at some history Stack ground!"
        switch currentPageName
            when "homepage"
                allModules.appcontrolmodule.killApp()
                return
            when "settingspage" then settingsHistoryStack.length = 0
            when "statisticspage" then statisticsHistoryStack.length = 0
            when "loginpage" then return ## for now do nothing TODO check if we should exit app here
            else log "we are at groundlevel of a historyStack but current page is " + currentPageName
        currentActiveHistoryStack = latestActiveHistoryStack
        latestActiveHistoryStack = programHistoryStack
    #check the name of the latest page
    backPageName = popPagenameOffCurrentActiveHistoryStack()
    # get the latest page to turn back to
    backPage = allPagesByName[backPageName]
    animationPageOutroToBottom(backPage)
    currentPage.classList.remove("present")
    currentPage = backPage
    currentPageName = backPageName
    currentPage.classList.add("present")
    afterPageSwitch()

loadHomepage = ->
    log "loadHomepage"
    cleanHistory()
    if currentPage and currentPageName isnt "homepage"
        animationPagePairSlidingRightOff(allPagesByName["homepage"], currentPage)
        #usecase: we switched from other page
    else
        allPagesByName["homepage"].classList = "page"
        #usecase: we just load the homepage
    currentActiveHistoryStack = programHistoryStack
    programHistoryStack.push("homepage")

    adjustCurrentPageState("homepage")

loadStatisticspage = ->
    log "loadStatisticspage"
    if currentActiveHistoryStack == statisticsHistoryStack
        cleanHistoryStack(statisticsHistoryStack)
    else
        latestActiveHistoryStack = currentActiveHistoryStack
        currentActiveHistoryStack = statisticsHistoryStack
    
    statisticsHistoryStack.push("statisticspage") unless statisticsHistoryStack.length
    animationPageIntroFromBelow(allPagesByName["statisticspage"])

    adjustCurrentPageState("statisticspage")

loadSettingspage = ->
    log "loadSettingspage "
    if currentActiveHistoryStack == settingsHistoryStack
        cleanHistoryStack(settingsHistoryStack)
    else
        latestActiveHistoryStack = currentActiveHistoryStack
        currentActiveHistoryStack = settingsHistoryStack
    
    currentActiveHistoryStack.push("settingspage") unless currentActiveHistoryStack.length
    pagename = popPagenameOffCurrentActiveHistoryStack()
    animationPageIntroFromBelow(allPagesByName[pagename])

    adjustCurrentPageState(pagename)

loadLoginpage = ->
    log "loadLoginpage"
    cleanHistory()
    animationPageIntroFromBelow(allPagesByName["loginpage"])
    currentActiveHistoryStack = loginHistoryStack
    settingsHistoryStack.push("loginpage") unless loginHistoryStack.length    

    adjustCurrentPageState("loginpage")
    
loadRegularPage = (pagename) ->
    log "loadRegularPage"
    animationPageIntroFromBelow(allPagesByName[pagename])
    currentActiveHistoryStack.push(pagename)

    adjustCurrentPageState(pagename)

adjustCurrentPageState = (pagename) ->
    log "adjustCurrentPageState"
    currentPage.classList.remove("present") if currentPage
    currentPage = allPagesByName[pagename]
    currentPageName = pagename
    currentPage.classList.remove("untouched")
    currentPage.classList.add("present")

popPagenameOffCurrentActiveHistoryStack = ->
    log "popPagenameOffCurrentActiveHistoryStack"
    index = currentActiveHistoryStack.length - 1
    potObject  = currentActiveHistoryStack[index]
    if typeof potObject is "object"
        return potObject.pageName
    else
        return potObject


#endregion 

#region exposed functions
pagemodule.leaveProgramRunningPage = ->
    log "pagemodule.leaveProgramRunningPage"
    if currentPageName == "programrunningpage"
        pagemodule.back()
        
## page loader function
pagemodule.load = (pagename) ->
    log("pagemodule.load " + pagename)
    return unless pagename isnt currentPageName
    switch pagename
        when "homepage" then loadHomepage()
        when "statisticspage" then loadStatisticspage()
        when "settingspage" then loadSettingspage()
        when "loginpage" then loadLoginPage()
        else
            loadRegularPage(pagename)
    afterPageSwitch()

## back navigation function
pagemodule.back = ->
    log "pagemodule.back"
    if allModules.popupmodule.active
        allModules.popupmodule.turnPopupDown()
        return
    if programRunningPageIsActive  
        backProgramRunningPageIsActive()
    else 
        backRegular()

## module function to add backHooks
pagemodule.addBackHook = (hook) ->
    log "pagemodule.addBackHook"
    pageName  = currentActiveHistoryStack.pop()
    throw "Multiple Backhooks! We're not prepared!" if typeof pageName is "object"
    obj = 
        pageName: pageName
        backHook: hook
    currentActiveHistoryStack.push(obj)

pagemodule.setStateProgramRunningPageActive = ->
    log "pagemodule.setStateProgramRunningPageActive"
    programRunningPageIsActive = true

pagemodule.unsetStateProgramRunningPageActive = ->
    log "pagemodule.unsetStateProgramRunningPageActive"
    programRunningPageIsActive = false

#endregion exposed functions

export default pagemodule
