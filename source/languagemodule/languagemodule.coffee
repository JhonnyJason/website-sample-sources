languagemodule = {name: "languagemodule", uimodule: false}

import langfile from "./generalLangfile.js"

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["languagemodule"]?  then console.log "[languagemodule]: " + arg
    return

#region internal variables
languagemodule.langTag = ""
#endregion internal variables

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
languagemodule.initialize = () ->
    log "languagemodule.initialize"

#region internal functions
retrievedOSLanguage = (language) ->
    log "retrievedOSLanguage"
    log "language is: " +  language.value
    if languagemodule.langTag then return
    else
        languagemodule.langTag = extractLangTagfromOSLangValue(language.value)
        applyCurrentLanguage()

errorRetrievingOSLanguage = (error) ->
    log "errorRetrievingOSLanguage"
    if languagemodule.langTag then return
    else
        languagemodule.langTag = "en"
        applyCurrentLanguage()

extractLangTagfromOSLangValue = (langValue)->
    log 'extractLangTagfromOSLangValue'
    tag = undefined
    res = undefined

    for key, activeLangTag of allModules.configmodule.activeLangTags
        res = langValue.search(activeLangTag)
        if res >= 0
            tag = activeLangTag

    if tag then return tag else return "en"

applyCurrentLanguage = () ->
    log "applyCurrentLanguage"
    transElements = document.querySelectorAll("[language-key]")
    for element in transElements
        text = getLanguageTextFromKey(element.getAttribute("language-key"))
        if element.tagName.toLowerCase() == "input"
            element.setAttribute("placeholder", text)
        else
            element.innerHTML = text
    ## TODO: fix potential security issue here...
    allModules.programsmodule.applyLangTag()
    allModules.infocardsmodule.applyLangTag()
    allModules.scrollshadowmodule.checkAllElements()
    allModules.settingspagemodule.setLanguageSelect()

applyCurrentLanguageOn = (langKeys) ->
    log "applyCurrentLanguage"
    if langKeys.length < 15
        transElements = []
        for key in langKeys
            selectorString = "[language-key=" + key + "]"
            elements = document.querySelectorAll(selectorString)
            for element in elements
                transElements.push(element)

        for element in transElements
            text = getLanguageTextFromKey(element.getAttribute("language-key"))
            if element.tagName.toLowerCase() == "input"
                element.setAttribute("placeholder", text)
            else
                element.textContent = text
        allModules.scrollshadowmodule.checkAllElements()
    
    else
        transElements = document.querySelectorAll("[language-key]")
        for element in transElements
            text = getLanguageTextFromKey(element.getAttribute("language-key"))
            if element.tagName.toLowerCase() == "input"
                element.setAttribute("placeholder", text)
            else
                element.textContent = text
        allModules.scrollshadowmodule.checkAllElements()


getLanguageTextFromKey = (key) ->
    log "getLanguageText"
    log "the language key is : " + key
    throw "key '" + key + "' is not found! " unless langfile[key]?
    langString = (langfile[key])[languagemodule.langTag]
    throw "no language found for langfile[" + key + "][" + languagemodule.langTag + "] " unless langString? 
    parameterizedLangString = parameterizeLangString(langString)
    log "parameterizedLangString is: " + parameterizedLangString
    return parameterizedLangString

parameterizeLangString = (langString) ->
    log "parameterizeLangString"
    log "original langString is: " + langString
    ## possible parameters are:
    #: $#username
    #: $#currentLanguage
    pos = langString.indexOf("$#")
    return langString if pos < 0
    identifier = langString.substr(pos, 4)
    switch identifier
        when "$#us" # = $#username
            username = allModules.accountmodule.accountStoreObject.username
            return langString.replace("$#username", username)
        when "$#cu" # = $#currentLanguage
            languageKey = "language-" + languagemodule.langTag
            currentLanguage = (langfile[languageKey])[languagemodule.langTag]
            return langString.replace("$#currentLanguage", currentLanguage)
        when "$#fi" # = $#finalQuestionActive
            isOn = allModules.accountmodule.accountStoreObject.finalQuestionActive
            if isOn then languageKey = "optionOn"
            else languageKey = "optionOff"
            currentLanguage = (langfile[languageKey])[languagemodule.langTag]
            return langString.replace("$#finalQuestionActive", currentLanguage)
        else
            log "Our Identifier was something unexpected: " + identifier
            return langString 

## adding the event listeners
#endregion

#region exposed functions
languagemodule.startupCheck = ->
    log "languagemodule.startupCheck"
    if allModules.accountmodule.accountStoreObject
        languagemodule.langTag = allModules.accountmodule.accountStoreObject.preferredLangTag
    else
        allModules.pluginmodule.globalizationPlugin.getPreferredLanguage(retrievedOSLanguage, errorRetrievingOSLanguage)
    ## language fill for testing purpose
    log languagemodule.langTag
    applyCurrentLanguage()

languagemodule.changeLanguage = (newLangTag) ->
    log "languagemodule.changeLanguage"
    languagemodule.langTag = newLangTag
    applyCurrentLanguage()
    ##save decision too account
    allModules.accountmodule.accountStoreObject.preferredLangTag = newLangTag
    allModules.accountmodule.saveAccountData()

languagemodule.languageTextFromKey = (key) ->
  log "languagemodule.languageTextFromKey"
  return getLanguageTextFromKey(key)

languagemodule.refreshContentFor = (langKeys) ->
    log "languagemodule.refreshContentFor"
    applyCurrentLanguageOn(langKeys)
    return

#endregion exposed functions


export default languagemodule