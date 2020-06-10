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

// defining DEBUG_OFF turns off TracingAndTiming...
#define DEBUG_OFF 1

#include "TracingAndTiming.h"

#ifdef DEBUG_OFF
void
Debug::specify(const char * s) {}
void 
Debug::TimeStart(const char *, const char *) {}
void
Debug::TimeEnd(const char *, const char *) {}
void
Debug::Sync() {};

#else
Debug::Debug(const char * f):function_name(f), timing(false), raw_time(false),
    going_in(false) {
    level++;
    if(tracing(function_name)) 
        Enter();
}

Debug::Debug(const char * f, bool b):function_name(f), timing(true), raw_time(b),
    going_in(true) {
    level++;
    if(tracing(function_name)) 
        Enter();
    going_in = false;
}

Debug::~Debug() {
        if(tracing(function_name)) Exit();
        level--;
        if( (!level) 
        #if defined(DEBUG_1STREAM)
        && (out_usage == FILE_OUT)
        #endif
        ) out.close();
}

bool
Debug::tracing(const string & f) {
    if(!Tracing) return false;
    
    return (functions.empty() || 
    find(functions.begin(),functions.end(),f) != functions.end());
}

bool
Debug::debugging(const string & k) {
    if(!Debugging) return false;

#if defined DEBUG_MULT_KWDS
    if( keywords.empty()) return true;
    string::size_type start, end;
    string kw;
    start = 0;
    do {// This is the beginning of a do-while loop
        // Look for a comma delimiting an internal keyword
        // We are assuming well-formed multiple keywords - 
        // no leading, trailing, or multiple commas.
        end = k.find(',', start);
        if( end == string::npos ) {
            // Assign the rest of k to kw.  This could be all of k
            // when start is still 0.
            kw = k.substr(start);
        } else {
            // Assign the substring just found to kw, adjust start point 
            kw = k.substr(start,end-start);
            start = end + 1;
        }
        if(find(keywords.begin(),keywords.end(),kw) != keywords.end()) {
            return true;
        }
    } while( end != string::npos );
    return false;
#else
    return (keywords.empty() || 
    find(keywords.begin(),keywords.end(),k) != keywords.end());
#endif
}

bool
Debug::IntTiming(const string & t) {
    if(!Timing) return false;

#if defined DEBUG_MULT_KWDS
    if( timekeys.empty()) return true;
    string::size_type start, end;
    string kw;
    start = 0;
    do {// This is the beginning of a do-while loop
        // Look for a comma delimiting an internal keyword
        // We are assuming well-formed multiple keywords - 
        // no leading, trailing, or multiple commas.
        end = t.find(',', start);
        if( end == string::npos ) {
            // Assign the rest of t to kw.  This could be all of t
            // when start is still 0.
            kw = t.substr(start);
        } else {
            // Assign the substring just found to kw, adjust start point 
            kw = t.substr(start,end-start);
            start = end + 1;
        }
        if(find(timekeys.begin(),timekeys.end(),kw) != timekeys.end()) {
            return true;
        }
    } while( end != string::npos );
    return false;
#else
    return(timekeys.empty() ||
    find(timekeys.begin(),timekeys.end(),t) != timekeys.end());
#endif
}

void
Debug::Enter(){
    for(int i = 1; i < (level < limit ? level : limit) ; i++ )
        #if defined(DEBUG_1STREAM)
        clog << "  ";
        #else
        if(use_cout)
            cout << "  ";
        else if(use_clog)
            clog << "  ";
        else
             out << "  ";
        #endif

    #if defined(DEBUG_1STREAM)
    clog << "=> " << function_name << time_stuff() << "\n";
    #else
    if(use_cout)
        cout << "=> " << function_name << time_stuff() << "\n";
    else if(use_clog)
        clog << "=> " << function_name << time_stuff() << "\n";
    else
         out << "=> " << function_name << time_stuff() << "\n";
    #endif
}

void
Debug::Exit(){
    for(int i = 1; i < (level < limit ? level : limit) ; i++ )
        #if defined(DEBUG_1STREAM)
        clog << "  ";
        #else
        if(use_cout)
            cout << "  ";
        else if(use_clog)
            clog << "  ";
        else
             out << "  ";
        #endif

    #if defined(DEBUG_1STREAM)
    clog << "<= " << function_name << time_stuff() << "\n";
    #else
    if(use_cout)
        cout << "<= " << function_name << time_stuff() << "\n";
    else if(use_clog)
        clog << "<= " << function_name << time_stuff() << "\n";
    else
         out << "<= " << function_name << time_stuff() << "\n";
    #endif
}

char *
Debug::time_stuff() {
    if(!timing) return "";

    if(raw_time) {
        struct timeb Tb;
        ftime(&Tb);
        if(going_in) {
            sprintf(mybuff, " %ld.%03d",Tb.time, Tb.millitm);
            Start = Tb;
        } else {
            long int secs, millis;
            millis = Tb.millitm - Start.millitm;
            secs = Tb.time - Start.time;
            if(millis < 0) {
                millis += 1000;
                -- secs;
            }
            sprintf(mybuff, "         %ld.%03ld", secs, millis);
        }

    } else { // Cooked time
        time_t Clock;
        time(&Clock);
        sprintf(mybuff," %s", asctime(localtime(&Clock)));
        mybuff[strlen(mybuff)-1] = '\0';
    }
    return mybuff;
}

void
Debug::indent() {
    if( Tracing ) {
        for( int i = 0; i <= (level < (limit + 1) ? level : (limit + 1)); i++ ) 
            #if defined(DEBUG_1STREAM)
            clog << "  ";
            #else
            if(use_cout)
                cout << "  ";
            else if(use_clog)
                clog << "  ";
            else
                 out << "  ";
            #endif
    }
}

void
Debug::Dbg(const string & k, const char * s) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << s << "\n";
    #else
    if(use_cout)
        cout << k << ": " << s << "\n";
    else if(use_clog)
        clog << k << ": " << s << "\n";
    else
         out << k << ": " << s << "\n";
    #endif
}
    
void
Debug::Dbg(const string & k, const int i) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << i << "\n";
    #else
    if(use_cout)
        cout << k << ": " << i << "\n";
    else if(use_clog)
        clog << k << ": " << i << "\n";
    else
         out << k << ": " << i << "\n";
    #endif
}
    
void
Debug::Dbg(const string & k, const float f) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << f << "\n";
    #else
    if(use_cout)
        cout << k << ": " << f << "\n";
    else if(use_clog)
        clog << k << ": " << f << "\n";
    else
         out << k << ": " << f << "\n";
    #endif
}

void
Debug::Dbg(const string & k, const char * s, int i) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << s << i << "\n";
    #else
    if(use_cout)
        cout << k << ": " << s << i << "\n";
    else if(use_clog)
        clog << k << ": " << s << i << "\n";
    else
         out << k << ": " << s << i << "\n";
    #endif
}
    
void
Debug::Dbg(const string & k, const char * s, const string &i) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << s << i << "\n";
    #else
    if(use_cout)
        cout << k << ": " << s << i << "\n";
    else if(use_clog)
        clog << k << ": " << s << i << "\n";
    else
         out << k << ": " << s << i << "\n";
    #endif
}
    
void
Debug::Dbx(const string & k, const char * s, unsigned long ul) {
    if(!debugging(k)) return;
    indent();
    #if defined(DEBUG_1STREAM)
    clog << k << ": " << s << hex << ul << dec << "\n";
    #else
    if(use_cout)
        cout << k << ": " << s << hex << ul << dec << "\n";
    else if(use_clog)
        clog << k << ": " << s << hex << ul << dec << "\n";
    else
         out << k << ": " << s << hex << ul << dec << "\n";
    #endif
}
    
    // Static members
int Debug::level = 0;
bool Debug::Debugging = false;
bool Debug::Tracing = false;
bool Debug::Timing = false;
#if defined (DEBUG_1STREAM)
enum Debug::Out_choice Debug::out_usage = COUT;
enum Debug::Out_choice Debug::next_out  = COUT;
#else
bool Debug::use_cout = false;
bool Debug::use_clog = true;
#endif

#if defined DEBUG_DOS_FORMAT
char Debug::separator = ';';
#else
char Debug::separator = ':';
#endif

char Debug::mybuff[200];
string Debug::filename;
ofstream Debug::out;

#if defined (DEBUG_1STREAM)
streambuf * Debug::strm_buf = 0;
streambuf * Debug::clog_buf = 0;
#endif

vector<string> Debug::keywords;
vector<string> Debug::functions;
vector<string> Debug::timekeys;
vector<pair<string, struct timeb> > Debug::timers;

void
Debug::TimeStart(const string &t, const char *s) {
    if(!IntTiming(t)) return;
    
    unsigned int i = 0;
    for(i = 0; i < timers.size(); i++) {
        if(timers[i].first == t) break;
    }
    timeb tb;
    ftime(&tb);
    if( i == timers.size()) {  // Not found, so put one in.
        timers.push_back(make_pair(t,tb));
    } else {
        timers[i].second = tb;
    }
    sprintf(mybuff," %ld.%03d", tb.time, tb.millitm);

    indent();
    #if defined(DEBUG_1STREAM)
    clog << t << ": " << s << mybuff << "\n";
    #else
    if(use_cout)
        cout << t << ": " << s << mybuff << "\n";
    else if(use_clog)
        clog << t << ": " << s << mybuff << "\n";
    else
         out << t << ": " << s << mybuff << "\n";
    #endif
}
    
void
Debug::TimeEnd(const string &t, const char *s) {
    if(!IntTiming(t)) return;
    
    unsigned int i = 0;
    for(i = 0; i < timers.size(); i++) {
        if(timers[i].first == t) break;
    }
    timeb tb;
    ftime(&tb);
    if( i == timers.size()) { // Not found!
        // This puts an entry in the timers vector
        // it won't be very informative, but it keeps
        // things going OK.
        timers.push_back(make_pair(t,tb));
    }
    // i now has the index of our timer in the vector

    int secs, millis;
    millis = tb.millitm - timers[i].second.millitm;
    secs = tb.time - timers[i].second.time;
    if(millis < 0) {
        millis += 1000;
        --secs;
    }
    sprintf(mybuff, " %d.%03d", secs, millis);

    indent();
    #if defined(DEBUG_1STREAM)
    clog << t << ": " << s << mybuff << "\n";
    #else
    if(use_cout)
        cout << t << ": " << s << mybuff << "\n";
    else if(use_clog)
        clog << t << ": " << s << mybuff << "\n";
    else
         out << t << ": " << s << mybuff << "\n";
    #endif
}

void
Debug::Sync() {
    #if defined(DEBUG_1STREAM)
    clog.flush();
    #else
    if(use_cout) cout.flush();
    else if(use_clog) clog.flush();
    else out.flush();
    #endif
}
    
/***********************************
* Debug::specify()
* Extracts options and keywords from a Debug specification string
* and deals with them "appropriately."
* 
* PSEUDOCODE:
* look for an option
* while(there is an option)
*   look for next option or end of string
*   look for a keyword in the substring thus found
*   while(where is a keyword)
*       depending upon the option found
*       save the keyword OR
*       extract and save some value OR
*       ignore the keyword
*       look for a keyword
*   end while
* end while
*
* Option strings have the form
* L:keyword,keyword,L:keyword,keyword,
* L:L:keyword,keyword
* L:L:,keyword
* etc.  Terminating commas are optional
* Leading commas are harmless.
**************************************/
void Debug::specify(const char * opt) {
    string s = opt;
    bool output_changed = false;

    #if defined (DEBUG_1STREAM)
    // First time activity
    if(!strm_buf) {
        strm_buf = out.rdbuf();
        clog_buf = clog.rdbuf();
        out_usage = next_out = CLOG;
    }
    #endif

    // Find options
    unsigned int j = s.find_first_of(separator,0);
    while(j < s.length()) {  // Option found
        // j points to the separator at the end of this option

        unsigned int k = s.find_first_of(separator,j+1);
        // k now points to the separator at the end of the next option
        // or to outer space
        
        string Option;
        if(j == 0) {
            Option = "0";
            Option += s[0];
        } else {
            Option = string(s,j-1,2);
        }
        
        // Find keywords
        unsigned int l = s.find_first_of(',',j+1);

        // Deal with the case of no comma, like F:keywordD: or
        // F:keyword
        if((l >= k) && (j < k-2)) {
            if( k > s.length() ) // No trailing option
                l = s.length();
            else l = k-1;    // Trailing option is found
        }
        while(l < k) {  // keyword found
            string kw;
            if(j+1 < l ) {
                kw = string(s,j+1,l-j-1);
            } else {
                kw = "";
            }

            if( l < s.length() ) {
            
                j = l;  // Advance to virtual ( or real ) comma.
                unsigned int m = s.find_first_of(',',l+1);

                // Again, what if there's no trailing comma in a
                // sequence of keywords like F:abcd,efgh,ijklD:
                // or F:a,b,c,d
                if((m >= k) && (j < k-1)) {
                    if( (m > s.length()) && ( k > s.length()))
                        m = s.length();
                        else m = k-1;
                }
                l = m;
            } else l = k;  // Bail out of the loop

        // This is where we deal with the keywords and options
        switch(Option[0]) {
            case 'D':    // Turn debugging on
                    if(kw.length()) keywords.push_back(kw);
                break;

            case 'O':   // Changing output, maybe
                if(kw.length() && kw != filename) {
                    output_changed = true;
                    filename = kw;

                    #if defined (DEBUG_1STREAM)
                    if( kw == "-") {
                        next_out = COUT;
                    } else { 
                        if(kw == "--") {
                            next_out = CLOG;
                        } else {
                            next_out = FILE_OUT;
                        }
                    }
                    #else
                    if( kw == "-") {
                        use_cout = true;
                        use_clog = false;
                    } else { 
                        if(kw == "--") {
                            use_cout = false;
                            use_clog = true;
                        } else {
                            use_cout = false;
                            use_clog = false;
                        }
                    }
                    #endif
                }
                break;

            case 'T':    // Turn tracing on
                if(kw.length()) functions.push_back(kw);
                break;

            case 'M':    // Turn interval timing on
                if(kw.length()) timekeys.push_back(kw);
                break;

            default:       // Ignore other options silently
                break;
        }
        } // end of loop on finding keywords
    // This is where we complete dealing with options
    switch(Option[0]) {
        case 'D':    // Turn debugging on
            Debugging = true;
            break;

        case 'd':       // Turn debugging off
            keywords.clear();
            Debugging = false;
            break;

        case 'O':   // Changing output, maybe
            if(output_changed) setup_output();
            output_changed = false;
            break;

        case 'T':    // Turn tracing on
            Tracing = true;
            break;

        case 't':       // Turn tracing off
            functions.clear();
            Tracing = false;
            break;
            
        case 'M':       // Turn interval timing on
            Timing = true;
            break;

        case 'm':       // Turn interval timing off
            timekeys.clear();
            timers.clear();
            Timing = false;
            break;

        default:       // Ignore other options silently
            break;
    }
        j = k; // Advance to next option
    } // end of loop on finding options
}

#if defined (DEBUG_1STREAM)
void
Debug::setup_output() {
    switch(out_usage) {
        case COUT:
            switch(next_out) {
                case COUT:
                    break;
                case CLOG:
                    clog.rdbuf(clog_buf);
                    break;
                case FILE_OUT:
                    out.open(filename.c_str(), ios::app);
                    clog.rdbuf(out.rdbuf());
                    break;
                default:
                    cerr << "Internal inconsistency! " << __FILE__ << 
                        __LINE__ << endl;
                    abort();
                    break;
            }  // End of switch on next_out
            break;
        case CLOG:
            switch(next_out) {
                case COUT:
                    clog.rdbuf(cout.rdbuf());
                    break;
                case CLOG:
                    break;
                case FILE_OUT:
                    out.open(filename.c_str(), ios::app);
                    clog.rdbuf(out.rdbuf());
                    break;
                default:
                    out << "Internal inconsistency! " << __FILE__ << 
                        __LINE__ << endl;
                    abort();
                    break;
            }  // End of switch on next_out
            break;
        case FILE_OUT:
            out.close();
            switch(next_out) {
                case COUT:
                    clog.rdbuf(cout.rdbuf());
                    break;
                case CLOG:
                    clog.rdbuf(clog_buf);
                    break;
                case FILE_OUT:
                    out.open(filename.c_str(), ios::app);
                    clog.rdbuf(out.rdbuf());
                    break;
                default:
                    cerr << "Internal inconsistency! " << __FILE__ << 
                        __LINE__ << endl;
                    abort();
                    break;
            }  // End of switch on next_out
            break;
        default:
            cerr << "Internal inconsistency! " << __FILE__ << __LINE__ << endl;
            abort();
            break;
    }  // End of switch on out_usage
    out_usage = next_out;
}
#else
void
Debug::setup_output() {
    if(out.rdbuf()->is_open()) 
        out.close();
    if(use_cout || use_clog)
        return;
    
    out.open(filename.c_str(), ios::app);
}
#endif
#endif
