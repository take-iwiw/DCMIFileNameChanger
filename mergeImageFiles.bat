@echo off
setlocal enabledelayedexpansion
cd /d %~dp1
mkdir temp
for %%f in (%*) do (
	echo %%f
	set ORIGINAL_FILENAME=%%f
	rem echo original filename = !ORIGINAL_FILENAME!
	set CREATED_TIME=%%~tf
	set yyyy=!CREATED_TIME:~0,4!
	set mm=!CREATED_TIME:~5,2!
	set dd=!CREATED_TIME:~8,2!
	set hh=!CREATED_TIME:~11,2!
	set min=!CREATED_TIME:~14,2!
	set NEW_FILENAME=!yyyy!!mm!!dd!_!hh!!min!00_
	rem	echo !NEW_FILENAME!!num!.jpg
	call :FuncMakeNewFilename
	echo new filename = !NEW_FILENAME!
	copy !ORIGINAL_FILENAME! temp\!NEW_FILENAME!
)
pause
exit /b

:FuncMakeNewFilename
	set num=0
	:LOOP_TO_AVOID_SAME_NAME
	if exist temp\!NEW_FILENAME!!num!.jpg (
		set /a num=!num!+1
		goto LOOP_TO_AVOID_SAME_NAME
	) else goto AFTER_LOOP_TO_AVOID_SAME_NAME
	:AFTER_LOOP_TO_AVOID_SAME_NAME
	set NEW_FILENAME=!NEW_FILENAME!!num!.jpg
	exit /b
