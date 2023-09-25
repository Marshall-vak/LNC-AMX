(*********************************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2006 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2007                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
MODULE_NAME = 'Optoma TH1060 DisplayComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 12/12/2007 11:14:25 AM                    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

#include 'ComponentInclude.axi'

#include 'SNAPI.axi'

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

// Channels
BTN_GET_ASPECT                  = 1350  // Button: getAspectRatio
BTN_BRIGHT_LVL_RELEASE          = 3350  // Button: setBrightness Lvl Release Btn
BTN_COLOR_LVL_RELEASE           = 3351  // Button: setColor Lvl Release Btn
BTN_CONTRAST_LVL_RELEASE        = 3352  // Button: setContrast Lvl Release Btn
BTN_SHARP_LVL_RELEASE           = 3353  // Button: setSharpness Lvl Release Btn
BTN_TINT_LVL_RELEASE            = 3354  // Button: setTint Lvl Release Btn

INTEGER BTN_ASPECT_RATIO_SELECT[]      =       // Button: Input
{
  261,  262,  263,  264,  265,
  266,  267,  268,  269,  270,
  271,  272,  273,  274,  275,
  276,  277,  278,  279,  280
}

INTEGER TXT_ASPECT_RATIO_SELECT[]      =       // Text: Input Name
{
  261,  262,  263,  264,  265,
  266,  267,  268,  269,  270,
  271,  272,  273,  274,  275,
  276,  277,  278,  279,  280
} 

// Levels

// Variable Text Addresses

// G4 CHANNELS
BTN_BRIGHT_UP                   = 148   // Button: Brightness Up
BTN_BRIGHT_DN                   = 149   // Button: Brightness Down
BTN_COLOR_UP                    = 150   // Button: Color Up
BTN_COLOR_DN                    = 151   // Button: Color Down
BTN_CONTRAST_UP                 = 152   // Button: Contrast Up
BTN_CONTRAST_DN                 = 153   // Button: Contrast Down
BTN_SHARP_DN                    = 155   // Button: Sharpness Down
BTN_SHARP_UP                    = 154   // Button: Sharpness Up
BTN_TINT_UP                     = 156   // Button: Tint Up
BTN_TINT_DN                     = 157   // Button: Tint Down
BTN_ASPECT_RATIO                = 142   // Button: Aspect Ratio
BTN_PIC_FREEZE                  = 213   // Button: Freeze
BTN_PIC_MUTE                    = 210   // Button: Picture Mute
BTN_PIP                         = 194   // Button: PIP
BTN_PIP_POS                     = 191   // Button: PIP Position
BTN_PIP_SWAP                    = 193   // Button: Swap PIP


// G4 LEVELS
LVL_BRIGHT                      = 10    // Level: Brightness
LVL_COLOR                       = 11    // Level: Color
LVL_CONTRAST                    = 12    // Level: Contrast
LVL_SHARP                       = 13    // Level: Sharpness
LVL_TINT                        = 14    // Level: Tint


// G4 VARIABLE TEXT ADDRESSES
TXT_ASPECT_RATIO                = 27    // Text: Aspect Ratio


// SNAPI CHANNELS
SNAPI_BTN_PIC_FREEZE_ON                   = 214 // Button: setFreezeOn
SNAPI_BTN_PIC_MUTE_ON                     = 211 // Button: setPictureMuteOn
SNAPI_BTN_PIP_ON                          = 195 // Button: setPIPOn
SNAPI_BTN_PIP_FB                          = 195 // Button: processPIPEvent


// SNAPI LEVELS
SNAPI_LVL_BRIGHT_LVL                      = 10 // Level: setBrightness
SNAPI_LVL_COLOR_LVL                       = 11 // Level: setColor
SNAPI_LVL_CONTRAST_LVL                    = 12 // Level: setContrast
SNAPI_LVL_SHARP_LVL                       = 13 // Level: setSharpness
SNAPI_LVL_TINT_LVL                        = 14 // Level: setTint


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER MAX_ASPECTS = 20
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE
#IF_NOT_DEFINED _uAspectProp
STRUCTURE _uAspectProp
{
    INTEGER    nIndex
	CHAR       sLabel[20]
    CHAR       sDisplay[20]
}
#END_IF

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
VOLATILE _uAspectProp AspectProps[MAX_ZONE][MAX_ASPECTS]
VOLATILE INTEGER nAspectsUsed[MAX_ZONE];
VOLATILE INTEGER nPropertyCount = 0 		// Number of properties received since the touchpanel came online
integer nTINT_LVL[MAX_ZONE] // Stores level values for TINT_LVL
integer nSHARP_LVL[MAX_ZONE] // Stores level values for SHARP_LVL
integer nCONTRAST_LVL[MAX_ZONE] // Stores level values for CONTRAST_LVL
integer nCOLOR_LVL[MAX_ZONE] // Stores level values for COLOR_LVL
integer nBRIGHT_LVL[MAX_ZONE] // Stores level values for BRIGHT_LVL
char sASPECT[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }


//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnDeviceChanged
//
// PURPOSE:          This function is used by the device selection BUTTON_EVENT
//                   to notify the module that a device change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnDeviceChanged()
{
    println ("'OnDeviceChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnPageChanged
//
// PURPOSE:          This function is used by the page selection BUTTON_EVENT
//                   to notify the module that a component change may have occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnPageChanged()
{
	SEND_COMMAND vdvDev[nCurrentZone], '?ASPECTRATIOPROPERTIES'
	println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?ASPECTRATIOPROPERTIES',39")
	send_command vdvDev[nCurrentZone], '?ASPECTRATIOSELECT'
	println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?ASPECTRATIOSELECT',39")
    println ("'OnPageChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnZoneChange
//
// PURPOSE:          This function is used by the zone selection BUTTON_EVENT
//                   to notify the module that a zone change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnZoneChange()
{
	stack_var integer nCount
    
	send_level dvTP, LVL_SHARP, nSHARP_LVL[nCurrentZone]
    send_level dvTP, LVL_TINT, nTINT_LVL[nCurrentZone]
    send_level dvTP, LVL_CONTRAST, nCONTRAST_LVL[nCurrentZone]
    send_level dvTP, LVL_COLOR, nCOLOR_LVL[nCurrentZone]
    send_level dvTP, LVL_BRIGHT, nBRIGHT_LVL[nCurrentZone]

    send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO),',0,',''"
	
	for (nCount = 1; nCount <= MAX_ASPECTS; nCount++)
	{
		send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO_SELECT[nCount]),',0,',AspectProps[nCurrentZone][nCount].sDisplay"
		
		if( nCount <= nAspectsUsed[nCurrentZone] )
		{
			send_command dvTP, "'^SHO-',itoa(TXT_ASPECT_RATIO_SELECT[nCount]),',1'"
		} 
		else 
		{
			send_command dvTP, "'^SHO-',itoa(TXT_ASPECT_RATIO_SELECT[nCount]),',0'"
		}
	}
	SEND_COMMAND vdvDev[nCurrentZone], '?ASPECTRATIOSELECT'
    println ("'OnZoneChange'")
}
//*********************************************************************
// Function : initialize
// Purpose  : initialize any variables to default values
// Params   : none
// Return   : none
//*********************************************************************
DEFINE_FUNCTION initialize()
{
    stack_var integer nLoop
    stack_var integer x
    nPropertyCount = 0
    for (nLoop = 1; nLoop <= MAX_ZONE; nLoop++)
    {
		nAspectsUsed[nLoop] = 0;
		for (x = 1; x <= MAX_ASPECTS; x++)
		{
			AspectProps[nLoop][x].nIndex = 0
			AspectProps[nLoop][x].sLabel = ''
			AspectProps[nLoop][x].sDisplay = ''
		}
    }
	
	// Clear the page
	for (nLoop = 1; nLoop <= MAX_ASPECTS; nLoop++)
	{
		send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO_SELECT[nLoop]),',0,',''"
		send_command dvTP, "'^SHO-',itoa(TXT_ASPECT_RATIO_SELECT[nLoop]),',0'"
	}
	send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO),',0,',''"
}
//*********************************************************************
// Function : parseProperties
// Purpose  : Parse property groups from a list of property groups and
//            puts the group into a property structure
// Params   : props - list of property groups
//            nZone - zone which the list came from
// Return   : INTEGER - number of property groups in list
//*********************************************************************
DEFINE_FUNCTION parseProperties(CHAR props[], INTEGER nZone)
{
    STACK_VAR CHAR sSource[20]
    WHILE(LENGTH_STRING(props) > 0)
    {
		STACK_VAR CHAR property[100]
		STACK_VAR INTEGER index
		index = 0
		property = DuetParseCmdParam(props)
		// separate each property from the property group
		index = ATOI(DuetParseCmdParam(property))
		if (nAspectsUsed[nZone] < index)
			nAspectsUsed[nZone] = index;
		if (index > 0 && index <= MAX_ASPECTS)
		{
			AspectProps[nZone][index].nIndex = index
			AspectProps[nZone][index].sDisplay = DuetParseCmdParam(property)
			AspectProps[nZone][index].sLabel = DuetParseCmdParam(property)
			send_command dvTP, "'^SHO-',itoa(TXT_ASPECT_RATIO_SELECT[AspectProps[nZone][index].nIndex]),',1'"
			send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO_SELECT[AspectProps[nZone][index].nIndex]),',0,',AspectProps[nZone][index].sDisplay"
		}
    }
}
//*********************************************************************
// Function : findProperty
// Purpose  : Finds the property that matches the passed in index
// Params   : index - matches the INPUTPROPERTY <index> value
//            nZone - zone which the list came from
// Return   : INTEGER - array position of the matching property
//*********************************************************************
DEFINE_FUNCTION INTEGER findProperty(INTEGER index, INTEGER nZone)
{
    stack_var integer nLoop
    
	if (index > 0 && index <= MAX_ASPECTS)
	{
		for (nLoop = 1; nLoop <= MAX_ASPECTS; nLoop++)
		{
			IF (AspectProps[nZone][index].nIndex > 0)
			{
				RETURN TRUE;
			}
		}
	}
    
    RETURN FALSE;
}
//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    processOnlineEvent
//
// PURPOSE:          This function is used by the Touch Panel Online Event
//                   to reinitialize the panel state.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION processOnlineEvent()
{
	stack_var INTEGER nLoop
	
	
	for (nLoop = 1; nLoop <= length_array(vdvDev); nLoop++)
	{
		send_level dvTP, LVL_SHARP, nSHARP_LVL[nLoop]
		send_level dvTP, LVL_TINT, nTINT_LVL[nLoop]
		send_level dvTP, LVL_CONTRAST, nCONTRAST_LVL[nLoop]
		send_level dvTP, LVL_COLOR, nCOLOR_LVL[nLoop]
		send_level dvTP, LVL_BRIGHT, nBRIGHT_LVL[nLoop]
		
		SEND_COMMAND vdvDev[nLoop], '?ASPECTRATIOPROPERTIES'
		println("'send_command ',dpstoa(vdvDev[nLoop]),', ',39,'?ASPECTRATIOPROPERTIES',39")
	}
	println ("'processOnlineEvent'")
}
DEFINE_MUTUALLY_EXCLUSIVE
([dvTp,BTN_ASPECT_RATIO_SELECT[1]]..[dvTp,BTN_ASPECT_RATIO_SELECT[LENGTH_ARRAY(BTN_ASPECT_RATIO_SELECT)]])
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'DisplayComponent'
initialize()
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


(***********************************************************)
(*             TOUCHPANEL EVENTS GO BELOW                  *)
(***********************************************************)
DATA_EVENT [dvTP]
{

    ONLINE:
    {
        stack_var integer nLoop
	bActiveComponent = FALSE
        nActiveDevice = 1
        nActivePage = 0
        nActiveDeviceID = nNavigationBtns[1]
        nActivePageID = 0
        nCurrentZone = 1
        bNoLevelReset = 0
		if(bNoLevelReset==1)
			processOnlineEvent()
		bNoLevelReset = 0
		
		//reset all property values
		initialize()

    }
    OFFLINE:
    {
        bNoLevelReset = 1
    }

}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for vdvDev
//                   DisplayComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the DisplayComponent.
//
// LOCAL VARIABLES:  cHeader     :  SNAPI command header
//                   cParameter  :  SNAPI command parameter
//                   nParameter  :  SNAPI command parameter value
//                   cCmd        :  received SNAPI command
//
//---------------------------------------------------------------------------------
DATA_EVENT[vdvDev]
{
    COMMAND :
    {
        // local variables
        STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
        STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
        STACK_VAR CHAR    cParameter[DUET_MAX_PARAM_LEN]
        STACK_VAR INTEGER nParameter
        STACK_VAR CHAR    cTrash[20]
        STACK_VAR INTEGER nZone
        
        nZone = getFeedbackZone(data.device)
        
        // get received SNAPI command
        cCmd = DATA.TEXT
        
        // parse command header
        cHeader = DuetParseCmdHeader(cCmd)
        SWITCH (cHeader)
        {
            // SNAPI::ASPECT-<ratio>
            //CASE 'ASPECT' :
            //{
            //    sASPECT[nZone] = DuetParseCmdParam(cCmd)
            //    SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_ASPECT_RATIO),',0,', sASPECT[nZone]"
            //}
		CASE 'ASPECTRATIOSELECT' :
		{
			stack_var integer bFound
			STACK_VAR integer index
			STACK_VAR INTEGER i
			// get parameter value from SNAPI command and set feeback on user interface
			nParameter = ATOI(DuetParseCmdParam(cCmd))
			FOR(i=1;i<=MAX_ASPECTS;i++)
			{
				if(AspectProps[nZone][i].nIndex == nParameter)
					index = AspectProps[nZone][i].nIndex
			}
			OFF [dvTP,BTN_ASPECT_RATIO_SELECT]
			IF (index > 0 && index <= MAX_ASPECTS)
			{
				ON[dvTP,BTN_ASPECT_RATIO_SELECT[index]]
				
				if (nZone == nCurrentZone)
				{
					bFound = findProperty(index, nZone)
					if (bFound == TRUE)
						send_command dvTP, "'^TXT-',itoa(TXT_ASPECT_RATIO),',0,',AspectProps[nZone][nParameter].sDisplay"
				}
			}
		}
		CASE 'ASPECTRATIOPROPERTIES' :
		{
			// get parameter value from SNAPI command and set feeback on user interface
			parseProperties(cCmd, nZone)
		}
		// SNAPI::INPUTPROPERTY-<index>,<inputGroup>,<deviceLabel>,<signalType>,<AVType>
		CASE 'ASPECTRATIOPROPERTY' :
		{
			// get parameter value from SNAPI command and set feeback on user interface
			parseProperties(cCmd, nZone)
            }
            // SNAPI::DEBUG-<state>
            CASE 'DEBUG' :
            {
                // This will toggle debug printing
                nDbg = ATOI(DuetParseCmdParam(cCmd))
            }
        }
    }
}

//----------------------------------------------------------
// CHANNEL_EVENTs For DisplayComponent
//
// The following channel events are used in conjunction
// with the DisplayComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_PIP_POS
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_PIP_POS]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], PIP_POS]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIP_POS),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - discrete channel
//                   on PIP_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, PIP_ON]
{
    push:
    {
        if (bActiveComponent)
        {
            [vdvDev[nCurrentZone],PIP_ON] = ![vdvDev[nCurrentZone],PIP_ON]
            println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIP_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIP_ON),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - discrete channel
//                   on PIC_MUTE_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, PIC_MUTE_ON]
{
    push:
    {
        if (bActiveComponent)
        {
            if(![vdvDev[nCurrentZone],PIC_FREEZE_ON]) //Not Freeze On
	    {
		[vdvDev[nCurrentZone],PIC_MUTE_ON] = ![vdvDev[nCurrentZone],PIC_MUTE_ON]
		println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_MUTE_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_MUTE_ON),']'")
	    }
	    else if([vdvDev[nCurrentZone],PIC_FREEZE_ON] && [vdvDev[nCurrentZone],PIC_MUTE_ON]) // Freeze and Mute On
	    {
		[vdvDev[nCurrentZone],PIC_MUTE_ON] = ![vdvDev[nCurrentZone],PIC_MUTE_ON]
		println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_MUTE_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_MUTE_ON),']'")
		OFF [dvTP,PIC_FREEZE_FB]
	    }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - discrete channel
//                   on PIC_FREEZE_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, PIC_FREEZE_ON]
{
    push:
    {
        if (bActiveComponent)
        {
            [vdvDev[nCurrentZone],PIC_FREEZE_ON] = ![vdvDev[nCurrentZone],PIC_FREEZE_ON]
            println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_FREEZE_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_FREEZE_ON),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_BRIGHT_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_BRIGHT_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], BRIGHT_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(BRIGHT_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_TINT_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_TINT_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], TINT_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(TINT_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_BRIGHT_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_BRIGHT_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], BRIGHT_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(BRIGHT_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_COLOR_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_COLOR_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], COLOR_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(COLOR_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_COLOR_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_COLOR_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], COLOR_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(COLOR_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_CONTRAST_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_CONTRAST_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], CONTRAST_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(CONTRAST_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_CONTRAST_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_CONTRAST_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], CONTRAST_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(CONTRAST_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - command
//                   on BTN_GET_ASPECT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_ASPECT]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], '?ASPECTRATIOSELECT'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?ASPECTRATIOSELECT',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_SHARP_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_SHARP_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], SHARP_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(SHARP_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_TINT_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_TINT_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], TINT_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(TINT_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_ASPECT_RATIO
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_ASPECT_RATIO]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], ASPECT_RATIO]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(ASPECT_RATIO),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_PIC_FREEZE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_PIC_FREEZE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], PIC_FREEZE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_FREEZE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_PIC_MUTE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_PIC_MUTE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], PIC_MUTE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIC_MUTE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_PIP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_PIP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], PIP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_SHARP_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_SHARP_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], SHARP_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(SHARP_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - level
//                   on BTN_TINT_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_TINT_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], TINT_LVL, nTINT_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(TINT_LVL),', ',itoa(nTINT_LVL[nCurrentZone])")
            }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - level
//                   on BTN_SHARP_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_SHARP_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], SHARP_LVL, nSHARP_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(SHARP_LVL),', ',itoa(nSHARP_LVL[nCurrentZone])")
            }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - level
//                   on BTN_CONTRAST_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_CONTRAST_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], CONTRAST_LVL, nCONTRAST_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(CONTRAST_LVL),', ',itoa(nCONTRAST_LVL[nCurrentZone])")
            }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - level
//                   on BTN_COLOR_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_COLOR_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], COLOR_LVL, nCOLOR_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(COLOR_LVL),', ',itoa(nCOLOR_LVL[nCurrentZone])")
            }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - level
//                   on BTN_BRIGHT_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_BRIGHT_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], BRIGHT_LVL, nBRIGHT_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(BRIGHT_LVL),', ',itoa(nBRIGHT_LVL[nCurrentZone])")
            }
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: momentary button - momentary channel
//                   on BTN_PIP_SWAP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_PIP_SWAP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], PIP_SWAP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PIP_SWAP),']'")
        }
    }
}

//----------------------------------------------------------
// LEVEL_EVENTs For DisplayComponent
//
// The following level events are used in conjunction
// with the DisplayComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   DisplayComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the DisplayComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, TINT_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nTINT_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   DisplayComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the DisplayComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, SHARP_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nSHARP_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   DisplayComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the DisplayComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, CONTRAST_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nCONTRAST_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   DisplayComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the DisplayComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, COLOR_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nCOLOR_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   DisplayComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the DisplayComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, BRIGHT_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nBRIGHT_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   DisplayComponent: level event for DisplayComponent
//
// PURPOSE:          This level event is used to listen for SNAPI DisplayComponent changes
//                   on the DisplayComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, SHARP_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nSHARP_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_SHARP, nSHARP_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_SHARP),', ',itoa(nSHARP_LVL[nCurrentZone])")
        }
    }
}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   DisplayComponent: level event for DisplayComponent
//
// PURPOSE:          This level event is used to listen for SNAPI DisplayComponent changes
//                   on the DisplayComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, TINT_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nTINT_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_TINT, nTINT_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_TINT),', ',itoa(nTINT_LVL[nCurrentZone])")
        }
    }
}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   DisplayComponent: level event for DisplayComponent
//
// PURPOSE:          This level event is used to listen for SNAPI DisplayComponent changes
//                   on the DisplayComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, CONTRAST_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nCONTRAST_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_CONTRAST, nCONTRAST_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_CONTRAST),', ',itoa(nCONTRAST_LVL[nCurrentZone])")
        }
    }
}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   DisplayComponent: level event for DisplayComponent
//
// PURPOSE:          This level event is used to listen for SNAPI DisplayComponent changes
//                   on the DisplayComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, COLOR_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nCOLOR_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_COLOR, nCOLOR_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_COLOR),', ',itoa(nCOLOR_LVL[nCurrentZone])")
        }
    }
}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   DisplayComponent: level event for DisplayComponent
//
// PURPOSE:          This level event is used to listen for SNAPI DisplayComponent changes
//                   on the DisplayComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, BRIGHT_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nBRIGHT_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_BRIGHT, nBRIGHT_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_BRIGHT),', ',itoa(nBRIGHT_LVL[nCurrentZone])")
        }
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   DisplayComponent: channel button - command
//                   on BTN_ASPECT_RATIO_SELECT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the DisplayComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP,BTN_ASPECT_RATIO_SELECT]
{
	push:
	{
		if (bActiveComponent)
		{
			stack_var integer btn
			btn = get_last(BTN_ASPECT_RATIO_SELECT)
			send_command vdvDev[nCurrentZone], "'ASPECTRATIOSELECT-',itoa(btn)"
			println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ASPECTRATIOSELECT-',itoa(btn),39")
		}
	}
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,PIC_MUTE_ON] = [vdvDev[nCurrentZone],PIC_MUTE_FB]
[dvTP,PIC_FREEZE_ON] = [vdvDev[nCurrentZone],PIC_FREEZE_FB]
[dvTP,PIP_FB] = [vdvDev[nCurrentZone],PIP_FB]

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

