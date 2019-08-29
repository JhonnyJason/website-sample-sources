networkmodule = {name: "networkmodule", uimodule: false}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["networkmodule"]?  then console.log "[networkmodule]: " + arg
    return

#region internal variables
connection = null
http = null
online = false

sServerURL = ""
weatherBackendURL = ""
citysearchBackendURL = ""
#endregion internal variables

#region exposed variables

#endregion exposed functions

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
networkmodule.initialize = () ->
    log "networkmodule.initialize"
    sServerURL = allModules.configmodule.sServerURL
    weatherBackendURL = allModules.configmodule.weatherBackendURL
    citysearchBackendURL = allModules.configmodule.citysearchBackendURL

#region internal functions
onOnline = ->
    log 'onOnline'
    online = true unless connection.type == Connection.NONE
    log "online is: " + online

onOffline = ->
    log 'onOffline'
    online = true unless connection.type == Connection.NONE
    log "online is: " + online

#post Requests
postToCoreBackendServer = (dir, data, responseHandler) ->
    log 'postToCoreBackendServer'
    ##TODO establish package queu when being offline
    requestURL = sServerURL + dir
    http.post requestURL, data, {}, ((response) ->
        log response.status
        log response.data
        try
            responseHandler JSON.parse(response.data)
        catch e
            log e
    ), (response) ->
        # prints 403
        log response.status
        log response.error
        
getFromServer = (dir, data, responseHandler) ->
    log "getFromServer"
    ##TODO establish package queu when being offline
    requestURL = sServerURL + dir
    http.get requestURL, data, {}, ((response) ->
        try
            responseHandler JSON.parse(response.data)
        catch e
            log e
        return
    ), (response) ->
        # prints 403
        log response.status
        log response.error
    
#endregion internal functions


#region exposed functions
networkmodule.startupCheck = ->
    log "networkmodule.startupCheck"
    connection = allModules.pluginmodule.connectionPlugin
    http = allModules.pluginmodule.httpPlugin
    
    online = true unless connection.type == connection.NONE
    document.addEventListener("offline", onOffline, false);
    document.addEventListener("online", onOnline, false);
    log "online is: " + online

networkmodule.sendBumpRequest = (bumpObj, responseHandle) ->
    log "networkmodule.sendBumpRequest"
    log "not!"
    return
    postToCoreBackendServer("/bump", bumpObj, responseHandle)

networkmodule.sendLoginRequest = (loginObj, responseHandle) ->
    log "networkmodule.sendBumpRequest"
    log "not!"
    return 
    postToCoreBackendServer("/login", loginObj, responseHandle)

networkmodule.doWeatherForecast = (data, responseHandler) ->
    log 'doWeatherForecast'
    ##TODO establish package queu when being offline
    requestURL = weatherBackendURL + '/weatherforecast'
    http.post requestURL, data, {}, ((response) ->
        log response.status
        log response.data
        try
            responseHandler JSON.parse(response.data)
        catch e
            log e
    ), (response) ->
        # prints 403
        log response.status
        log response.error
        
networkmodule.doCitySearch = (data, responseHandler) ->
    log 'doCitySearch'
    ##TODO establish package queu when being offline
    requestURL = citysearchBackendURL + '/citysearch'
    http.post requestURL, data, { 'Content-Type': 'application/json' }, ((response) ->
        log response.status
        log response.data
        try
            responseHandler JSON.parse(response.data)
        catch e
            log e
    ), (response) ->
        # prints 403
        log response.status
        log response.error
#endregion exposed functions

export default networkmodule