# Microsoft Developer Studio Project File - Name="DB_Table_BaseLib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=DB_Table_BaseLib - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "DB_Table_BaseLib.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "DB_Table_BaseLib.mak" CFG="DB_Table_BaseLib - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "DB_Table_BaseLib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "DB_Table_BaseLib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""$/Connections/DB_Table_BaseLib", IAAAAAAA"
# PROP Scc_LocalPath "."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "DB_Table_BaseLib - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /Zm300 /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"D:\MyData\Personal\Projects\LIB_Global\DB_Table_BaseLib.lib"

!ELSEIF  "$(CFG)" == "DB_Table_BaseLib - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /FR /YX /FD /GZ /Zm300 /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"D:\MyData\Personal\Projects\LIB_Global\DB_Table_BaseLib.lib"

!ENDIF 

# Begin Target

# Name "DB_Table_BaseLib - Win32 Release"
# Name "DB_Table_BaseLib - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\DB_Table_Base\About_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\AdvancedSearch_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\Billing_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\Contact_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\DB_Table_Base.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\Login_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\Personal_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\Profile_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\ReadMail_Info.cpp
# End Source File
# Begin Source File

SOURCE=..\DB_Table_Base\SimpleSerach_Info.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\DB_Table_Base\Profile_Info.h
# End Source File
# End Group
# End Target
# End Project
