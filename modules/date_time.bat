@echo off

@REM Get the current date and time
set "current_date=%date%"
set "current_time=%time%"

@REM Extract day, month, and year from the date string
if "%current_date:~0,3%" geq "A" (
    @REM Date format is 'DayName mm/dd/yyyy'
    set "month=%current_date:~4,2%"
    set "day=%current_date:~7,2%"
    set "year=%current_date:~10,4%"
) else if "%current_date:~2,1%" equ "." (
    @REM Date format is 'dd.mm.yyyy'
    set "day=%current_date:~0,2%"
    set "month=%current_date:~3,2%"
    set "year=%current_date:~6,4%"
) else if "%current_date:~2,1%" equ "/" (
    @REM Date format is 'dd/mm/yyyy'
    set "day=%current_date:~0,2%"
    set "month=%current_date:~3,2%"
    set "year=%current_date:~6,4%"
) else (
    @REM Assuming date format is 'yyyy-mm-dd'
    set "year=%current_date:~0,4%"
    set "month=%current_date:~5,2%"
    set "day=%current_date:~8,2%"
)

@REM Extract hour, minute, and second from the time string
set "hour=%current_time:~0,2%"
set "minute=%current_time:~3,2%"
set "second=%current_time:~6,2%"

@REM Remove leading spaces in hour if present
if "%hour:~0,1%" equ " " set "hour=0%hour:~1,1%"

@REM Remove milliseconds separator and capture milliseconds if necessary
if "%current_time:~8,1%" equ "." (
    set "second=%current_time:~6,2%"
    set "milliseconds=%current_time:~9,2%"
)


@REM Display the result (for debugging purposes)
@REM echo %current_date%
@REM echo %current_time%
@REM echo Month: %month%
@REM echo Day: %day%
@REM echo Year: %year%
@REM echo Hour: %hour%
@REM echo Minute: %minute%
@REM echo Second: %second%
@REM pause