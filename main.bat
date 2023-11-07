ECHO OFF >nul 2>nul
@taskkill /IM firefox.exe /F >nul 2>nul
@rem I make sure that the process is killed to ensure that I delete the entire Export2 (e.g. an open pdf file in firefox).

@timeout 1 >nul 2>nul
@rem The killing process may take longer.

@rd /S /Q c:\Mahr\Users\Operator\Export2\ >nul 2>nul
@rem I delete the directory to make sure that only new data will be in it from this port

@IF EXIST D: GOTO hdd_on
@rem Security whether there is a network drive D
@GOTO hdd_off


@:hdd_on
@rem The night shift ends at 6 a.m. so the next day's date starts after 6 a.m.

@SET shouldrun=1
@IF %time:~0,2% lss 6 SET shouldrun=0


@IF "%shouldrun%"=="0"  goto is_day
@IF "%shouldrun%"=="1" goto is_night

@goto end

@:is_day

@rem ##########Start script downloaded - YESTERDAY is exactly yesterday (takes into account leap years, e.g. yesterday's day from January 1, 2000 to December 31, 1999)
@for /f "tokens=1" %%i in ('date /t') do @set thedate=%%i

@set mm=%thedate:~5,2%
@set dd=%thedate:~8,2%
@set yyyy=%thedate:~2,2%


@if %dd%==08 (
set dd=8 ) else (
@if %dd%==09 (
set dd=9 ) )

@if %mm%==08 (
set mm=8 ) else (
@if %mm%==09 (
set mm=9 ) )

@set /A dd=%dd% - 1
@set /A mm=%mm% + 0

@if /I %dd% GTR 0 goto DONE
@set /A mm=%mm% - 1
@if /I %mm% GTR 0 goto ADJUSTDAY
@set /A mm=12
@set /A yyyy=%yyyy% - 1

@:ADJUSTDAY

@if %mm%==1 goto SET31
@if %mm%==2 goto LEAPCHK
@if %mm%==3 goto SET31
@if %mm%==4 goto SET30
@if %mm%==5 goto SET31
@if %mm%==6 goto SET30
@if %mm%==7 goto SET31
@if %mm%==8 goto SET31
@if %mm%==9 goto SET30
@if %mm%==10 goto SET31
@if %mm%==11 goto SET30
@if %mm%==12 goto SET31


@:SET31
@set /A dd=31 + %dd%
@goto DONE

@:SET30
@set /A dd=30 + %dd%
@goto DONE

@:LEAPCHK
@set /A tt=%yyyy% %% 4
@if not %tt%==0 goto SET28
@set /A tt=%yyyy% %% 100
@if not %tt%==0 goto SET29
@set /A tt=%yyyy% %% 400
@if %tt%==0 goto SET29

@:SET28
@set /A dd=28 + %dd%
@goto DONE

@:SET29
@set /A dd=29 + %dd%

@:DONE
@if /i %dd% LSS 10 set dd=0%dd%
@if /I %mm% LSS 10 set mm=0%mm%
@set YESTERDAY=%dd%.%mm%.%yyyy%
@set YESTERDAY=20%yyyy%-%mm%-%dd%

@rem ##########End of code downloaded


@mkdir c:\Mahr\Users\Operator\Export\%YESTERDAY% >nul 2>nul
@mkdir c:\Mahr\Users\Operator\Export2\%YESTERDAY% >nul 2>nul
@rem The Export directory is the default directory where the data is saved.
@copy c:\Mahr\Users\Operator\Export\*.* c:\Mahr\Users\Operator\Export2\%YESTERDAY% >nul 2>nul
@move c:\Mahr\Users\Operator\Export\*.* c:\Mahr\Users\Operator\Export\%YESTERDAY% >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2\%3\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3\%4\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4\%5\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5\%6\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6\%7\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7\%8\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7 %8\%8\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7 %8 %9\%9\%1\Measuring Machine" >nul 2>nul



@taskkill /IM firefox.exe /F >nul 2>nul
@timeout 1 >nul 2>nul
@rd /S /Q c:\Mahr\Users\Operator\Export\ >nul 2>nul
@timeout 1 >nul 2>nul
@mkdir c:\Mahr\Users\Operator\Export\ >nul 2>nul
@timeout 1 >nul 2>nul
@FOR %%F IN (c:\Mahr\Users\Operator\Export2\%YESTERDAY%\*.PDF) DO START "" "%%~F" >nul 2>nul
@goto end

@:is_night
@mkdir c:\Mahr\Users\Operator\Export\%date% >nul 2>nul
@mkdir c:\Mahr\Users\Operator\Export2\%date% >nul 2>nul

@copy c:\Mahr\Users\Operator\Export\*.* c:\Mahr\Users\Operator\Export2\%date% >nul 2>nul
@move c:\Mahr\Users\Operator\Export\*.* c:\Mahr\Users\Operator\Export\%date% >nul 2>nul

@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2\%3\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3\%4\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4\%5\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5\%6\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6\%7\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7\%8\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7 %8\%8\%1\Measuring Machine" >nul 2>nul
@xcopy /i /s /y "c:\Mahr\Users\Operator\Export" "D:\Machines\%2 %3 %4 %5 %6 %7 %8 %9\%9\%1\Measuring Machine" >nul 2>nul
@rem Zmienne %2 - %9 - Are responsible for the name of the machine's directory
@rem zmienne %1 - Are responsible for the name of the date directory


@taskkill /IM firefox.exe /F >nul 2>nul
@timeout 1 >nul 2>nul
@rd /S /Q c:\Mahr\Users\Operator\Export\ >nul 2>nul
@timeout 1 >nul 2>nul
@mkdir c:\Mahr\Users\Operator\Export\ >nul 2>nul
@timeout 1 >nul 2>nul
@FOR %%F IN (c:\Mahr\Users\Operator\Export2\%date%\*.PDF) DO START "" "%%~F" >nul 2>nul
@goto end

@:hdd_off
@C:\mahr1\error.bmp >nul 2>nul
@rem Image with an error message about the missing network drive

@goto end

@:end
@rem exit
