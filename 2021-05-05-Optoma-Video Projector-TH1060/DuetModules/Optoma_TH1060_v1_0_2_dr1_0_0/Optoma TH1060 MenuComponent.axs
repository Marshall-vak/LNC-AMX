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
MODULE_NAME = 'Optoma TH1060 MenuComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 12/12/2007 11:14:39 AM                    *)
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
BTN_D                           = 1578  // Button: pressMenuButton
BTN_A                           = 1575  // Button: pressMenuButton
BTN_I                           = 1583  // Button: pressMenuButton
BTN_G                           = 1581  // Button: pressMenuButton
BTN_H                           = 1582  // Button: pressMenuButton
BTN_T                           = 1594  // Button: pressMenuButton
BTN_J                           = 1584  // Button: pressMenuButton
BTN_K                           = 1585  // Button: pressMenuButton
BTN_L                           = 1586  // Button: pressMenuButton
BTN_F                           = 1580  // Button: pressMenuButton
BTN_E                           = 1579  // Button: pressMenuButton
BTN_S                           = 1593  // Button: pressMenuButton
BTN_U                           = 1595  // Button: pressMenuButton
BTN_V                           = 1596  // Button: pressMenuButton
BTN_W                           = 1597  // Button: pressMenuButton
BTN_X                           = 1598  // Button: pressMenuButton
BTN_Y                           = 1599  // Button: pressMenuButton
BTN_Z                           = 1600  // Button: pressMenuButton
BTN_N                           = 1588  // Button: pressMenuButton
BTN_O                           = 1589  // Button: pressMenuButton
BTN_P                           = 1590  // Button: pressMenuButton
BTN_Q                           = 1591  // Button: pressMenuButton
BTN_R                           = 1592  // Button: pressMenuButton
BTN_B                           = 1576  // Button: pressMenuButton
BTN_C                           = 1577  // Button: pressMenuButton
BTN_M                           = 1587  // Button: pressMenuButton
BTN_MENU_FORWARD                = 82    // Button: Forward
BTN_MENU_DECK_A_B               = 108   // Button: Deck AB

// Levels

// Variable Text Addresses

// G4 CHANNELS
BTN_MENU_DN                     = 46    // Button: Cursor Down
BTN_MENU_LT                     = 47    // Button: Cursor Left
BTN_MENU_RT                     = 48    // Button: Cursor Right
BTN_MENU_UP                     = 45    // Button: Cursor Up
BTN_MENU_CONTINUE               = 103   // Button: Continue
BTN_MENU_CONFERENCE             = 96    // Button: Conference
BTN_MENU_AUDIO                  = 118   // Button: Audio
BTN_MENU_ASTERISK               = 91    // Button: *
BTN_MENU_ANGLE                  = 117   // Button: Angle
BTN_MENU_AM                     = 79    // Button: AM
BTN_MENU_COMMA                  = 94    // Button: ,
BTN_MENU_ACCEPT                 = 60    // Button: Accept
BTN_MENU_AB_REPEAT              = 112   // Button: AB Repeat
BTN_MENU_SEND_INPUT             = 130   // Button: Send
BTN_MENU_ADVANCE                = 83    // Button: Advance
BTN_MENU_FAVORITES              = 102   // Button: Favorites
BTN_MENU_FLASH                  = 203   // Button: Flash
BTN_MENU_FM                     = 78    // Button: FM
BTN_MENU_GUIDE                  = 105   // Button: Guide
BTN_MENU_HOLD                   = 85    // Button: Hold
BTN_MENU_ENTER                  = 21    // Button: Enter
BTN_MENU_INFO                   = 101   // Button: Info
BTN_MENU_INSTANT_REPLAY         = 218   // Button: Instant Replay
BTN_MENU_LT_PAREN               = 87    // Button: (
BTN_MENU_LIST                   = 86    // Button: List
BTN_MENU_HELP                   = 113   // Button: Help
BTN_DIGIT_6                     = 16    // Button: 6
BTN_MENU_DASH                   = 90    // Button: -
BTN_MENU_DIAL                   = 95    // Button: Dial
BTN_DIGIT_0                     = 10    // Button: 0
BTN_DIGIT_1                     = 11    // Button: 1
BTN_DIGIT_2                     = 12    // Button: 2
BTN_DIGIT_3                     = 13    // Button: 3
BTN_DIGIT_5                     = 15    // Button: 5
BTN_MENU_EXIT                   = 50    // Button: Exit
BTN_DIGIT_7                     = 17    // Button: 7
BTN_DIGIT_8                     = 18    // Button: 8
BTN_DIGIT_9                     = 19    // Button: 9
BTN_MENU_DIMMER                 = 84    // Button: Dimmer
BTN_MENU_DISPLAY                = 99    // Button: Display
BTN_MENU_DOT                    = 92    // Button: .
BTN_MENU_FUNC                   = 44    // Button: Menu
BTN_DIGIT_4                     = 14    // Button: 4
BTN_MENU_UNDERSCORE             = 89    // Button: _
BTN_MENU_LIVE_TV                = 62    // Button: Live TV
BTN_MENU_SUBTITLE               = 100   // Button: Subtitle
BTN_MENU_THUMBS_DN              = 58    // Button: Thumbs Down
BTN_MENU_THUMBS_UP              = 59    // Button: Thumbs Up
BTN_MENU_TITLE                  = 114   // Button: Title
BTN_MENU_TOP_MENU               = 115   // Button: Top Menu
BTN_MENU_RT_PAREN               = 88    // Button: )
BTN_MENU_XM                     = 77    // Button: XM
BTN_MENU_ZOOM                   = 116   // Button: Zoom
BTN_MENU_TV_VCR                 = 109   // Button: TV/VCR
BTN_MENU_POUND                  = 93    // Button: #
BTN_MENU_PAGE_DN                = 107   // Button: Page Down
BTN_MENU_PAGE_UP                = 106   // Button: Page Up
BTN_MENU_PLUS_10                = 20    // Button: +10
BTN_MENU_SEND_GRAPHICS          = 131   // Button: Send Graphics
BTN_MENU_PLUS_1000              = 98    // Button: +1000
BTN_MENU_PREVIEW_INPUT          = 129   // Button: Preview
BTN_MENU_PROGRAM                = 111   // Button: Program
BTN_MENU_RECORD_SPEED           = 110   // Button: Record Speed
BTN_MENU_REJECT                 = 61    // Button: Reject
BTN_MENU_RESET                  = 215   // Button: Reset
BTN_MENU_RETURN                 = 104   // Button: Return
BTN_MENU_PLUS_100               = 97    // Button: +100
BTN_MENU_BACK                   = 81    // Button: Back
BTN_MENU_SETUP                  = 66    // Button: Setup
BTN_MENU_FUNCTION               = 65    // Button: Function
BTN_MENU_CLEAR                  = 80    // Button: Clear
BTN_MENU_CANCEL                 = 43    // Button: Cancel
BTN_MENU_PPV                    = 64    // Button: PPV
BTN_MENU_SLEEP                  = 63    // Button: Sleep
BTN_MENU_VIDEO                  = 57    // Button: Video
BTN_MENU_SELECT                 = 49    // Button: Select


// SNAPI CHANNELS
SNAPI_BTN_MENU_DN_LT                      = 53 // Button: moveMenuCursor
SNAPI_BTN_MENU_UP_RT                      = 52 // Button: moveMenuCursor
SNAPI_BTN_MENU_DN_RT                      = 54 // Button: moveMenuCursor
SNAPI_BTN_MENU_UP_LT                      = 51 // Button: moveMenuCursor


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
BTN_RED                 = 3450    // Button: Red
BTN_GREEN               = 3451    // Button: Green
BTN_YELLOW              = 3452    // Button: Yellow
BTN_BLUE                = 3453    // Button: Blue

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

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


    println ("'OnZoneChange'")
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'MenuComponent'
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
        bActiveComponent = FALSE
        nActiveDevice = 1
        nActivePage = 0
        nActiveDeviceID = nNavigationBtns[1]
        nActivePageID = 0
        nCurrentZone = 1
        bNoLevelReset = 0

    }
    OFFLINE:
    {
        bNoLevelReset = 1
    }

}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for vdvDev
//                   MenuComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the MenuComponent.
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
// CHANNEL_EVENTs For MenuComponent
//
// The following channel events are used in conjunction
// with the MenuComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_INFO
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_INFO]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_INFO]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_INFO),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FORWARD
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FORWARD]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FORWARD]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FORWARD),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_AB_REPEAT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_AB_REPEAT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_AB_REPEAT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_AB_REPEAT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_A
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_A]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-A'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-A',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SEND_INPUT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SEND_INPUT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SEND_INPUT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SEND_INPUT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ADVANCE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ADVANCE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ADVANCE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ADVANCE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_I
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_I]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-I'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-I',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FAVORITES
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FAVORITES]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FAVORITES]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FAVORITES),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FLASH
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FLASH]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FLASH]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FLASH),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FM
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FM]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FM]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FM),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_G
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_G]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-G'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-G',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_GUIDE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_GUIDE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_GUIDE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_GUIDE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_H
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_H]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-H'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-H',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_T
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_T]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-T'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-T',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_COMMA
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_COMMA]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_COMMA]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_COMMA),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_LIST
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_LIST]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_LIST]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_LIST),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_2
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_2]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_2]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_2),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_1
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_1]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_1]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_1),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_0
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_0]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_0]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_0),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DIAL
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DIAL]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DIAL]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DIAL),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DASH
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DASH]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DASH]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DASH),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_HOLD
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_HOLD]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_HOLD]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_HOLD),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_HELP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_HELP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_HELP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_HELP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ENTER
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ENTER]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ENTER]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ENTER),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_LT_PAREN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_LT_PAREN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_LT_PAREN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_LT_PAREN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_L
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_L]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-L'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-L',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_K
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_K]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-K'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-K',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_J
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_J]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-J'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-J',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_INSTANT_REPLAY
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_INSTANT_REPLAY]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_INSTANT_REPLAY]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_INSTANT_REPLAY),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_AM
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_AM]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_AM]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_AM),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_6
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_6]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_6]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_6),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DECK_A_B
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DECK_A_B]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DECK_A_B]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DECK_A_B),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_M
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_M]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-M'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-M',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on MENU_DN_LT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, MENU_DN_LT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DN_LT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DN_LT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on MENU_UP_RT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, MENU_UP_RT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_UP_RT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_UP_RT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on MENU_DN_RT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, MENU_DN_RT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DN_RT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DN_RT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_LT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_LT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_LT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_LT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_RT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_RT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_RT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_RT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on MENU_UP_LT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, MENU_UP_LT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_UP_LT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_UP_LT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ACCEPT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ACCEPT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ACCEPT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ACCEPT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ANGLE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ANGLE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ANGLE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ANGLE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ASTERISK
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ASTERISK]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ASTERISK]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ASTERISK),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_AUDIO
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_AUDIO]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_AUDIO]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_AUDIO),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_CONFERENCE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_CONFERENCE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_CONFERENCE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_CONFERENCE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_CONTINUE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_CONTINUE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_CONTINUE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_CONTINUE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_D
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_D]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-D'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-D',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_5
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_5]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_5]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_5),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_RESET
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_RESET]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_RESET]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_RESET),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_N
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_N]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-N'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-N',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_O
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_O]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-O'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-O',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_P
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_P]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-P'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-P',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PAGE_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PAGE_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PAGE_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PAGE_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PAGE_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PAGE_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PAGE_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PAGE_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PLUS_10
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PLUS_10]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PLUS_10]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PLUS_10),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SEND_GRAPHICS
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SEND_GRAPHICS]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SEND_GRAPHICS]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SEND_GRAPHICS),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PLUS_1000
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PLUS_1000]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PLUS_1000]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PLUS_1000),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PREVIEW_INPUT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PREVIEW_INPUT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PREVIEW_INPUT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PREVIEW_INPUT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PROGRAM
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PROGRAM]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PROGRAM]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PROGRAM),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_Q
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_Q]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-Q'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-Q',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_R
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_R]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-R'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-R',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_3
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_3]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_3]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_3),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SETUP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SETUP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SETUP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SETUP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_VIDEO
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_VIDEO]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_VIDEO]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_VIDEO),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SLEEP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SLEEP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SLEEP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SLEEP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PPV
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PPV]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PPV]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PPV),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_C
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_C]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-C'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-C',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_CANCEL
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_CANCEL]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_CANCEL]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_CANCEL),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_RECORD_SPEED
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_RECORD_SPEED]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_RECORD_SPEED]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_RECORD_SPEED),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FUNCTION
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FUNCTION]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FUNCTION]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FUNCTION),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_REJECT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_REJECT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_REJECT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_REJECT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_BACK
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_BACK]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_BACK]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_BACK),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_B
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_B]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-B'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-B',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_PLUS_100
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_PLUS_100]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_PLUS_100]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_PLUS_100),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_RETURN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_RETURN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_RETURN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_RETURN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_CLEAR
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_CLEAR]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_CLEAR]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_CLEAR),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DISPLAY
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DISPLAY]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DISPLAY]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DISPLAY),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_POUND
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_POUND]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_POUND]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_POUND),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_LIVE_TV
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_LIVE_TV]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_LIVE_TV]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_LIVE_TV),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_UNDERSCORE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_UNDERSCORE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_UNDERSCORE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_UNDERSCORE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_4
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_4]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_4]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_4),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_FUNC
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_FUNC]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_FUNC]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_FUNC),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SUBTITLE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SUBTITLE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SUBTITLE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SUBTITLE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DOT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DOT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DOT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DOT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_THUMBS_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_THUMBS_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_THUMBS_DN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_THUMBS_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_DIMMER
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_DIMMER]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_DIMMER]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_DIMMER),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_9
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_9]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_9]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_9),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_8
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_8]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_8]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_8),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_DIGIT_7
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_DIGIT_7]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], DIGIT_7]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(DIGIT_7),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_EXIT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_EXIT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_EXIT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_EXIT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_SELECT
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_SELECT]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_SELECT]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_SELECT),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_E
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_E]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-E'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-E',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_V
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_V]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-V'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-V',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_F
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_F]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-F'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-F',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_ZOOM
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_ZOOM]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_ZOOM]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_ZOOM),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_Z
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_Z]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-Z'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-Z',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_Y
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_Y]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-Y'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-Y',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_XM
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_XM]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_XM]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_XM),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_W
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_W]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-W'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-W',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_TV_VCR
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_TV_VCR]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_TV_VCR]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_TV_VCR),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_RT_PAREN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_RT_PAREN]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_RT_PAREN]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_RT_PAREN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_U
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_U]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-U'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-U',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_S
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_S]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-S'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-S',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_TOP_MENU
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_TOP_MENU]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_TOP_MENU]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_TOP_MENU),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_TITLE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_TITLE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_TITLE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_TITLE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: momentary button - momentary channel
//                   on BTN_MENU_THUMBS_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MENU_THUMBS_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], MENU_THUMBS_UP]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(MENU_THUMBS_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   MenuComponent: channel button - command
//                   on BTN_X
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the MenuComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_X]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'ALPHA-X'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'ALPHA-X',39")
        }
    }
}

BUTTON_EVENT[dvTP, BTN_BLUE]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'BUTTON-BLUE'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'BUTTON-RED',39")
        }
    }
}

BUTTON_EVENT[dvTP, BTN_RED]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'BUTTON-RED'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'BUTTON-RED',39")
        }
    }
}

BUTTON_EVENT[dvTP, BTN_GREEN]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'BUTTON-GREEN'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'BUTTON-GREEN',39")
        }
    }
}

BUTTON_EVENT[dvTP, BTN_YELLOW]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], 'BUTTON-YELLOW'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'BUTTON-YELLOW',39")
        }
    }
}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

