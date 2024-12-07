#Requires AutoHotkey v2.0
#SingleInstance Force

IsHeadset := false

<^!a::
{
    global IsHeadset
    IsHeadset := !IsHeadset
    Run("mmsys.cpl") ; Run the sound control panel
    WinWait("Sound")
    if IsHeadset {
        ControlSend("{Down 1}", "SysListView321")
    } else {
        ControlSend("{Down 6}", "SysListView321")
    }
    ControlClick("&Set Default")
    ControlClick("OK")
    if IsHeadset {
        TrayTip("", "Switched to headset", 16)
    } else {
        TrayTip("", "Switched to speakers", 16)
    }
    return
}