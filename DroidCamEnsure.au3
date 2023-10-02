#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_x64=DroidCamEnsure.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If (Not FileExists("bin/adb.exe")) Or  (Not FileExists("bin/AdbWinApi.dll")) Or (Not FileExists("bin/AdbWinUsbApi.dll")) Then
	ConsoleWrite("ADB Files Missing - Exiting...")
	Sleep(3000)
	Exit
EndIf

$ADB = "/bin/adb.exe"

$PIDOF = "adb shell pidof com.dev47apps.droidcamx"
$START = "adb shell am start -n com.dev47apps.droidcamx/com.dev47apps.droidcamx.DroidCamX"


$SHELL = Run("cmd", "bin", @SW_HIDE, 9)
OnAutoItExitRegister("on_exit")

$ADB_TRIES = 0

ConsoleWrite("Welcome to DroidCamEnsure v1.0 by AVPXYYF" & @LF & _
              "====[  https://github.com/avpxyyf  ]====" & @LF & @LF & _
			  "[+] HOW TO USE:" & @LF & _
			  "    Enable ADB on your Android device and connect it to this PC." & @LF & _
			  "    While this program is running, it will re-launch DroidCam when it crashes or closes" & @LF & @LF & _
			  "[+] DISCLAIMER: " & @LF & _
			  "    I wrote this program as a fix for DroidCamX's crashing bug." & @LF & _
			  "    I am not affiliated in any way with Dev47Apps, or their products." & @LF & _
			  "    I am just a guy who likes fixing stuff, using interesting solutions." & @LF & @LF)


ConsoleWrite("[+] DroidCamEnsure is Ready." & @LF & @LF)
While True

	If Not DC_Exists() Then
		if $ADB_TRIES < 3 Then
			ConsoleWrite("DroidCam not running. Launching..." & DC_Start() & @LF)
		Else
			ConsoleWrite("Is your phone connected and ADB enabled?" & @LF)
			Sleep(5000)
		EndIf
		$ADB_TRIES += 1
	Else
		If $ADB_TRIES <> -1 Then ConsoleWrite("DroidCam is running." & @LF)

		$ADB_TRIES = -1
	EndIf
WEnd

Func DC_Start()
	StdinWrite($SHELL, $START & @LF)
	Sleep(500)

	Return ""
EndFunc

Func DC_Exists()
	StdinWrite($SHELL, $PIDOF & @LF)
	Sleep(500)
	$DCE_out = StdoutRead($SHELL)

	Return StringRegExp($DCE_out, "\n\d{1,}")
EndFunc

Func on_exit()
	ProcessClose($SHELL)
EndFunc

