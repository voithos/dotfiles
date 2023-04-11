; Display switching hotkeys, via DDC.
; Requires the ControlMyMonitor.exe utility to be in the path.

#Requires AutoHotkey v2.0
#SingleInstance Force

; Switch to HDMI1
<^!1::
{
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY1\Monitor0" 60 17'
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY2\Monitor0" 60 17'
}

; Switch to HDMI2
<^!2::
{
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY1\Monitor0" 60 18'
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY2\Monitor0" 60 18'
}

; Switch to DP
<^!3::
{
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY1\Monitor0" 60 15'
    Run 'ControlMyMonitor.exe /SetValue "\\.\DISPLAY2\Monitor0" 60 15'
}