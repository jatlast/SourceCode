// Copyright (C) Maurice J. Fox 2000
// Permission is granted to use this code without restriction as
// long as this copyright notice appears in all source files.

////////////////////////////////
// Explain #pragma warnings...
////////////////////////////////
// Using Visual C++ version 4.x and later to compile a C++ program with the /Zi option generates the following warning: 
// warning C4786: 'identifier' : identifier was truncated to '255' characters in the debug information 
// See http://support.microsoft.com/support/kb/articles/Q122/5/39.ASP

// Since the above states that these warning can be ignored
// Try and Disable Warning C4786... 
#pragma warning ( disable : 4786 )

// Compiler Warning (level 1) C4251
// 'identifier' : class 'type' needs to have dll-interface to be used by clients of class 'type2'
// The specified base class was not declared with the __declspec(dllexport) keyword.
// A base class or structure must be declared with the __declspec(dllexport) keyword if a function in a derived class is to be exported.

// Since the program seems to work properly 
// Try and disable warning C4251
#pragma warning ( disable : 4251 )

#include <algorithm>
#include "TracingAndTiming.h"

//#ifdef TESTING

static void f1(void);
static void f2(void);
int main( int argc, char * argv[] ) 
{
    float pi = 3.14;
    int   i = 1999;
    char String[] = "This is a testing string ";
    Debug D("main",false);
#if defined DEBUG_DOS_FORMAT
    D.specify("M;T;O;C:/Required/LOG/TracingAndTiming.log");
    D.TimeStart("once", "This one is seen a lot! DOS");
    //D.specify("m;");
    for(int j = 1; j < argc; j++) {
        Debug::specify("D;");
#else
    D.specify("M:");
    D.TimeStart("once", "This one is seen a lot! NON-DOS");
    D.specify("m:");
    for(int j = 1; j < argc; j++) {
        Debug::specify("D:");
#endif
        D.Dbg("string",argv[j]);

        if( j % 2 ) D.specify(argv[j]);
        else Debug::specify(argv[j]);
        D.TimeStart("looping","in main after specify call");

        D.Dbg("string",argv[j]);
        D.Dbg("float", pi);
        D.Dbg("integer", i);
        D.Dbg("string", String, i);
        D.TimeEnd("once","in main");
        f1();
        D.TimeEnd("looping","at the bottom");
    }
    return 0;
}// end main

static void f1() {
    Debug D("f1");
    D.Dbg("string","f1's string");
    D.Sync();
    D.Dbg("string","string one ", "string two");
    f2();
}

static void f2() {
    Debug D("f2",true);
    D.Dbg("string","f2's string");
    D.Dbx("integer","This is an unsigned hex one ", 0XDEADBEEF);
    D.Dbg("integer","This is a regular integer ", 0XDEADBEEF);
    D.TimeEnd("bogus,once","This has no preceding TimeStart call");
    D.TimeEnd("once","This is in f2");
    D.Dbg("bogus,fred,fork,a,string,integer","a string");
    Debug::Sync();
    //sleep(1);
}
