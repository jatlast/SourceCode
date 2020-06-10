// ConnectionsFormLayout.h: interface for the CConnectionsFormLayout class.
//
//////////////////////////////////////////////////////////////////////

#ifndef CONNECTIONS_FORMLAYOUT_H
#define CONNECTIONS_FORMLAYOUT_H

#include <string>

#include "LinkMap/LinkMap.h" // associative map class


// Used to determin which page called Html_Begin...
const int ADVANCED_SEARCH		= 1;
const int DELETE_MAIL			= 2;
const int GEN_BOOKMARKS			= 3;
const int GEN_HOME				= 4;
const int GEN_INBOX				= 5;
const int GEN_OUTBOX			= 6;
const int GEN_PIC_UPLOAD		= 7;
const int GEN_SEND_MAIL			= 8;
const int HIDE_UNHIDE_PROFILE	= 9;
const int LOG_IN				= 10;
const int LOG_IN_HELP			= 11;
const int READ_MAIL				= 12;
const int SIMPLE_SEARCH			= 13;
const int SINGLE_PROFILE		= 14;
const int CREATE_LOGIN			= 15;
const int UPDATE_LOGIN			= 16;
const int UPDATE_CONTACT		= 17;
const int UPDATE_PERSONAL		= 18;
const int UPDATE_ABOUT			= 19;
const int UPDATE_BOOKMARKS		= 20;
const int UPDATE_BILLING		= 21;
const int VIEW_WINKS			= 22;
const int SEND_WINK				= 23;
const int DELETE_WINK			= 24;

using std::string;

class CConnectionsFormLayout  
{
private:
	// not to be used
	CConnectionsFormLayout(	const CConnectionsFormLayout & cfl);
	CConnectionsFormLayout &
		operator=(const CConnectionsFormLayout & rhs);

	
public:	
	CConnectionsFormLayout();
	//~CConnectionsFormLayout();
	
	
	char *
		CConnectionsFormLayout::GetLinkMapPath();
	
	////////////////////////////////////////////////////////////////////
	//
	//  Html_DefaultErrorMessagePage...
	//
	////////////////////////////////////////////////////////////////////
	void CConnectionsFormLayout::Html_DefaultErrorMessagePage(LinkMap & Map);
	////////////////////////////////////////////////////////////////////
	//
	//  Html_MemberLogIn...
	//
	////////////////////////////////////////////////////////////////////
	void CConnectionsFormLayout::Html_MemberLogIn(LinkMap & Map);
	
	
	////////////////////////////////////////////////////////////////////
	//
	//  Html_Begin...
	//
	////////////////////////////////////////////////////////////////////
	void CConnectionsFormLayout::Html_Begin(LinkMap & Map, bool LoggedIn, int WhichPage, char * UniqueID = "0");
	
	/**********************************************************************
	*
	*  Html_End...
	*
	**********************************************************************/
	void CConnectionsFormLayout::Html_End(LinkMap & Map);
	
	
	/**********************************************************************
	*
	*  Html_2_BeginPopUpTable...
	*
	**********************************************************************/
	void 
		CConnectionsFormLayout::Html_2_BeginPopUpFormat(LinkMap & Map);
		/**********************************************************************
		*
		*  ...
		*
	**********************************************************************/
	void 
		CConnectionsFormLayout::Html_AddProcessingGif(LinkMap & Map);
	
	void 
		CConnectionsFormLayout::Html_AddHistoryButton(const int PagesToJump, const string & Label);
	
	void 
		CConnectionsFormLayout::Html_AddHistoryJump(const int PagesToJump);
	
	void 
		CConnectionsFormLayout::Html_AddCloseButton();
	
	void 
		CConnectionsFormLayout::Html_AddNamePasswordCookie(const string & name, const string & password);
	
	void 
		CConnectionsFormLayout::Html_DeleteNamePasswordCookie(const string & name, const string & password);
	
	void 
		CConnectionsFormLayout::Html_AddRedirect(const string & path, const string & page);
	
	void 
		CConnectionsFormLayout::Html_AddAutoClose();
};


#endif //CONNECTIONS_FORMLAYOUT_H