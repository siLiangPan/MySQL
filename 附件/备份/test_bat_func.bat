::【DOS批处理】函数定义和用法
::http://blog.csdn.net/xiaoding133/article/details/39252357
@rem echo off
@ echo off
set "var1=some hopefully not important string"  
echo.var1 before: %var1%  
call:myGetFunc  
echo.var1 after : %var1%  

pause

::--------------------------------------------------------  
::-- Function section starts below here  
::--------------------------------------------------------
:: 获取参数，采用%1~%9来获取每个参数的值。%0,表示批处理文件本身
::  1.用空格或者逗号将参数分开
::  2.用双引号将带有空格的字符串参数括起来
:myGetFunc    -- function description here
::            -- %~1: argument description here
::SETLOCAL
set "var1=DosTips"
::set "%~1=%aStr%" 
::ENDLOCAL
goto:eof  
