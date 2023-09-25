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
MODULE_NAME = 'Optoma TH1060 VideoProjectorComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 12/12/2007 11:15:04 AM                    *)
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
BTN_GET_VPROJ_PRESET            = 2225  // Button: getProjectorPreset

// Levels

// Variable Text Addresses

// G4 CHANNELS

#IF_NOT_DEFINED BTN_VPROJ_PRESET
INTEGER BTN_VPROJ_PRESET[]      =       // Button: Preset
{
  3304,  3305,  3306,  3307
}
#END_IF // BTN_VPROJ_PRESET



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


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

char sVPROJPRESET[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }


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

DEFINE_MUTUALLY_EXCLUSIVE
([dvTp,BTN_VPROJ_PRESET[1]]..[dvTp,BTN_VPROJ_PRESET[LENGTH_ARRAY(BTN_VPROJ_PRESET)]])


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'VideoProjectorComponent'



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
//                   VideoProjectorComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the VideoProjectorComponent.
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
            // SNAPI::VPROJPRESET-<int>
            CASE 'VPROJPRESET' :
            {
                sVPROJPRESET[nZone] = DuetParseCmdParam(cCmd)
                // get parameter value from SNAPI command and set feeback on user interface
                nParameter = ATOI(sVPROJPRESET[nZone])
                off[dvTP,BTN_VPROJ_PRESET]
                if (nParameter)
                    on[dvTP,BTN_VPROJ_PRESET[nParameter]]

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
// CHANNEL_EVENTs For VideoProjectorComponent
//
// The following channel events are used in conjunction
// with the VideoProjectorComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VideoProjectorComponent: channel button - command
//                   on BTN_GET_VPROJ_PRESET
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VideoProjectorComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_VPROJ_PRESET]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], '?VPROJPRESET'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?VPROJPRESET',39")
        }
    }
}


//----------------------------------------------------------
// EXTENDED EVENTS For VideoProjectorComponent
//
// The following events are used in conjunction
// with the VideoProjectorComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VideoProjectorComponent: channel range button - command
//                   on BTN_VPROJ_PRESET
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_VPROJ_PRESET]
{
    push:
    {
        if (bActiveComponent)
		{
			stack_var integer btn
			btn = get_last(BTN_VPROJ_PRESET)
			
			send_command vdvDev[nCurrentZone], "'VPROJPRESET-',itoa(btn)"
			println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'VPROJPRESET-',itoa(btn),39")
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

