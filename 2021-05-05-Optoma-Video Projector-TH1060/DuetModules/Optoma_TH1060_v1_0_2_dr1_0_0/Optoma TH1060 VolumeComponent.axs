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
MODULE_NAME = 'Optoma TH1060 VolumeComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 12/12/2007 11:15:06 AM                    *)
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
BTN_VOL_LVL_RELEASE             = 2775  // Button: setVolume Lvl Release Btn

// Levels

// Variable Text Addresses

// G4 CHANNELS
BTN_VOL_MUTE                    = 26    // Button: Mute
BTN_VOL_DN                      = 25    // Button: Volume Down
BTN_VOL_UP                      = 24    // Button: Volume Up

// G4 LEVELS
LVL_VOL                         = 1     // Level: Volume

// SNAPI CHANNELS
SNAPI_BTN_VOL_PRESET                      = 138 // Button: cycleVolumePreset
SNAPI_BTN_VOL_MUTE_ON                     = 199 // Button: setVolumeMuteOn

// SNAPI LEVELS
SNAPI_LVL_VOL_LVL                         = 1 // Level: setVolume


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

integer nVOL_LVL[MAX_ZONE] // Stores level values for VOL_LVL

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
    send_level dvTP, LVL_VOL, nVOL_LVL[nCurrentZone]

    println ("'OnZoneChange'")
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'VolumeComponent'

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
//                   VolumeComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the VolumeComponent.
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
// CHANNEL_EVENTs For VolumeComponent
//
// The following channel events are used in conjunction
// with the VolumeComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VolumeComponent: channel button - ramping channel
//                   on BTN_VOL_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VolumeComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_VOL_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            on[vdvDev[nCurrentZone], VOL_UP]
            println (" 'on[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_UP),']'")
        }
    }
    release:
    {
        if (bActiveComponent)
        {
            off[vdvDev[nCurrentZone], VOL_UP]
            println (" 'off[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VolumeComponent: channel button - ramping channel
//                   on BTN_VOL_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VolumeComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_VOL_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            on[vdvDev[nCurrentZone], VOL_DN]
            println (" 'on[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_DN),']'")
        }
    }
    release:
    {
        if (bActiveComponent)
        {
            off[vdvDev[nCurrentZone], VOL_DN]
            println (" 'off[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VolumeComponent: channel button - discrete channel
//                   on VOL_MUTE_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VolumeComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, VOL_MUTE_ON]
{
    push:
    {
        if (bActiveComponent)
        {
            [vdvDev[nCurrentZone],VOL_MUTE_ON] = ![vdvDev[nCurrentZone],VOL_MUTE_ON]
            println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_MUTE_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_MUTE_ON),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VolumeComponent: momentary button - momentary channel
//                   on BTN_VOL_MUTE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VolumeComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_VOL_MUTE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], VOL_MUTE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_MUTE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   VolumeComponent: channel button - level
//                   on BTN_VOL_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the VolumeComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_VOL_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], VOL_LVL, nVOL_LVL[nCurrentZone]
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(VOL_LVL),', ',itoa(nVOL_LVL[nCurrentZone])")
            }
        }
    }
}

//----------------------------------------------------------
// LEVEL_EVENTs For VolumeComponent
//
// The following level events are used in conjunction
// with the VolumeComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   VolumeComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the VolumeComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, VOL_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nVOL_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   VolumeComponent: level event for VolumeComponent
//
// PURPOSE:          This level event is used to listen for SNAPI VolumeComponent changes
//                   on the VolumeComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, VOL_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nVOL_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_VOL, nVOL_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_VOL),', ',itoa(nVOL_LVL[nCurrentZone])")
        }
    }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,BTN_VOL_DN] = [vdvDev[nCurrentZone],VOL_DN_FB]
[dvTP,BTN_VOL_UP] = [vdvDev[nCurrentZone],VOL_UP_FB]
[dvTP,VOL_MUTE_ON] = [vdvDev[nCurrentZone],VOL_MUTE_FB]

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
