::��DOS����������������÷�
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
:: ��ȡ����������%1~%9����ȡÿ��������ֵ��%0,��ʾ�������ļ�����
::  1.�ÿո���߶��Ž������ֿ�
::  2.��˫���Ž����пո���ַ�������������
:myGetFunc    -- function description here
::            -- %~1: argument description here
::SETLOCAL
set "var1=DosTips"
::set "%~1=%aStr%" 
::ENDLOCAL
goto:eof  
