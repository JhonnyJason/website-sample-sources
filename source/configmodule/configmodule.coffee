configmodule = {name: "configmodule", uimodule: false}

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["configmodule"]?  then console.log "[configmodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
configmodule.initialize = () ->
    log "configmodule.initialize"
    
#region the configuration Object
configmodule.sServerURL = 'https://api.aurox.at'
configmodule.weatherBackendURL = 'http://weather.aurox.at'
configmodule.programBackendURL = 'https://programs.aurox.at'
configmodule.citysearchBackendURL = 'http://citysearch.aurox.at'
################################################################################
configmodule.fatality_alerts = false
configmodule.fatality_death = false
configmodule.debug_feature_active = true
configmodule.old_ble_protocol = false
################################################################################
configmodule.debugModeToggleTapTimeoutMS = 2000
configmodule.initialDebugMode = false
################################################################################
configmodule.notificationUpdateIntervalMS = 5000 
################################################################################
configmodule.bluetooth = 
    deviceName: ''
    service_uuid: 'cbacd3f1-0e20-48d1-87f1-031a736bc000'
    version_nr: 3
    program_save_mode: 1
    max_packet_fail: 30
    scanning_time_s: 5
    connecting_timeout_ms: 7000
    reconnect_attempt_delay_ms: 12000
    stay_alive_timer_s: 2 
    setup_device_state_notify_timer_s: 1.5#
    setup_device_timeout_off_s: 120 
    setup_constant_c: 25
    setup_constant_k: 2
    device_visibility_duration_s: 120
    stay_alive_timeout_s: 120 
    rssi_check_period_ms: 500
    battery_check_interval_ms: 3000
    notification_subscription_delay_ms: 100
    battery_danger_percent: 5
    battery_danger_hysterese: 2
    temperature_danger_outside: 94
    temperature_danger_inside: 88
    temperature_danger_electronics: 100
    temperature_danger_battery: 100
    temperature_danger_hysterese: 4
    characteristics:
        data_write: 'cbacd3f1-0e20-48d1-87f1-031a736bc001'
        data_write_size: 20
        command_write: 'cbacd3f1-0e20-48d1-87f1-031a736bc002'
        command_write_size: 1
        status_notify: 'cbacd3f1-0e20-48d1-87f1-031a736bc010'
        status_notify_size: 9
        temperatures_notify: "cbacd3f1-0e20-48d1-87f1-031a736bc020"
        temperatures_notify_size: 8
        shutdown_notify: '74FFB597-78E5-44E0-B634-75C0D18C33CA'
        shutdown_notify_size: 1
        read_hw_ids: "cbacd3f1-0e20-48d1-87f1-031a736bc001"
        read_hw_ids_size: 24
        read_akku_details: "2075824C-9BA5-47C7-8349-AC5DD7058FF3"
        read_akku_details_size: 27
        setup_write: "5DA83884-87C1-4417-8FA7-7071D9E02537"
        setup_write_size: 4
        user_customization_write: "302A6751-A59F-4169-98D4-6A900F19B62C"
        user_customization_write_size: 2
        read_firmware_version: "2A26"
        read_firmware_version_size: 4
        read_hw_revision: "2A27"
        read_hw_revision_size: 4
configmodule.coolingFloorParameters = 
    measuredTempBlurrWidth: 4
    tMinBlurrWidth: 2
    intoleranceDistance: 4
    breakFreeDistance: 6
configmodule.liveChartParams = 
    timeOffsetS: 0
#################################################################################
configmodule.activeLangTags = 
    english: 'en'
    german: 'de'
    spanish: 'es'
    chinese: 'cn'
#endregion

export default configmodule
