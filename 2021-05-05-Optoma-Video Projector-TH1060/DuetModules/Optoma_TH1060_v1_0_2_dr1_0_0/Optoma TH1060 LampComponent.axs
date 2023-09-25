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
MODULE_NAME = 'Optoma TH1060 LampComponent' (dev vdvDev[], dev dvTP, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 6/12/2008 10:12:41 AM                    *)
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
BTN_GET_COOLDOWN_TIME           = 1475  // Button: getCoolDownTime
BTN_GET_LAMP_TIME               = 1476  // Button: getLampTime
BTN_GET_WARMUP_TIME             = 1477  // Button: getWarmUpTime
BTN_SET_COOLDOWN_TIME           = 1478  // Button: setCoolDownTime
BTN_COUNTER_NOTIFY              = 1479  // Button: setCounterNotificationOn
BTN_SET_WARMUP_TIME             = 1481  // Button: setWarmUpTime
BTN_SET_LAMP_TIME               = 1480  // Button: setLampTime

// Levels

// Variable Text Addresses
TXT_WARMUP_TIME                 = 1476  // Text: getWarmUpTime - Response
TXT_COOLDOWN_TIME               = 1475  // Text: getCoolDownTime - Response

// G4 CHANNELS
BTN_POWER                       = 9     // Button: Power
BTN_LAMP_WARMING_FB             = 253   // Button: Lamp Warming FB
BTN_LAMP_POWER_FB               = 255   // Button: Lamp Power FB
BTN_LAMP_COOLING_FB             = 254   // Button: Lamp Cooling FB

// G4 VARIABLE TEXT ADDRESSES
TXT_LAMP_COOLDOWN               = 12    // Text: Cooldown Time
TXT_LAMP_HOURS                  = 14    // Text: Lamp Hours
TXT_LAMP_WARMUP                 = 13    // Text: Warmup Time

// SNAPI CHANNELS
SNAPI_BTN_PWR_OFF                         = 28 // Button: setLampPower
SNAPI_BTN_PWR_ON                          = 27 // Button: setLampPower
SNAPI_BTN_POWER_ON                        = 255 // Button: setLampPower


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

char sCOOLDOWN[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }
char sWARMUP[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }
char sWARMING[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }
char sCOOLING[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }
char sLAMPTIME[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }

VOLATILE INTEGER bBTN_COUNTER_NOTIFY = FALSE	// Tells if we should be receiving counter messages from the module
volatile integer nAdjustType = 0	// Are we adjusting the cooldown, warmup, or lamp time?
volatile integer m_isInitialized = FALSE

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

strCompName = 'LampComponent'



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
        nActiveDevice = 1
        nActivePage = 0
        nActiveDeviceID = nNavigationBtns[1]
        nActivePageID = 0
        nCurrentZone = 1
        bNoLevelReset = 0
	bBTN_COUNTER_NOTIFY = FALSE
	OFF[dvTP,BTN_COUNTER_NOTIFY]
    }
    OFFLINE:
    {
        bNoLevelReset = 1
    }
}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for vdvDev
//                   LampComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the LampComponent.
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
            // SNAPI::?COOLDOWN
            CASE 'COOLDOWN' :
            {
                sCOOLDOWN[nZone] = DuetParseCmdParam(cCmd)
                SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_COOLDOWN_TIME),',0,', sCOOLDOWN[nZone]"
            }
            // SNAPI::?WARMUP
            CASE 'WARMUP' :
            {
                sWARMUP[nZone] = DuetParseCmdParam(cCmd)
                SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_WARMUP_TIME),',0,', sWARMUP[nZone]"
            }
            // SNAPI::WARMING-<time>
            CASE 'WARMING' :
            {
                sWARMING[nZone] = DuetParseCmdParam(cCmd)
                SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_LAMP_WARMUP),',0,', sWARMING[nZone]"
            }
            // SNAPI::COOLING-<time>
            CASE 'COOLING' :
            {
                sCOOLING[nZone] = DuetParseCmdParam(cCmd)
                SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_LAMP_COOLDOWN),',0,', sCOOLING[nZone]"
            }
            // SNAPI::LAMPTIME-<time>
            CASE 'LAMPTIME' :
            {
                sLAMPTIME[nZone] = DuetParseCmdParam(cCmd)
                SEND_COMMAND dvTP,"'^TXT-',ITOA(TXT_LAMP_HOURS),',0,', sLAMPTIME[nZone]"
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
// CHANNEL_EVENTs For LampComponent
//
// The following channel events are used in conjunction
// with the LampComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: momentary button - momentary channel
//                   on BTN_POWER
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_POWER]
{
    push:
    {
            pulse[vdvDev[nCurrentZone], POWER]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(POWER),']'")
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - command
//                   on BTN_GET_COOLDOWN_TIME
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_COOLDOWN_TIME]
{
    push:
    {
            send_command vdvDev[nCurrentZone], '?COOLDOWN'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?COOLDOWN',39")
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - command
//                   on BTN_GET_LAMP_TIME
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_LAMP_TIME]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], '?LAMPTIME'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?LAMPTIME',39")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - command
//                   on BTN_GET_WARMUP_TIME
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GET_WARMUP_TIME]
{
    push:
    {
            send_command vdvDev[nCurrentZone], '?WARMUP'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?WARMUP',39")
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: momentary button - momentary channel
//                   on PWR_OFF
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, PWR_OFF]
{
    push:
    {
            pulse[vdvDev[nCurrentZone], PWR_OFF]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PWR_OFF),']'")
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - discrete channel
//                   on POWER_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, POWER_ON]
{
    push:
    {
            [vdvDev[nCurrentZone],POWER_ON] = ![vdvDev[nCurrentZone],POWER_ON]
            println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(POWER_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(POWER_ON),']'")
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: momentary button - momentary channel
//                   on PWR_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, PWR_ON]
{
    push:
    {
        pulse[vdvDev[nCurrentZone], PWR_ON]
        println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(PWR_ON),']'")
    }
}

//----------------------------------------------------------
// EXTENDED EVENTS For LampComponent
//
// The following events are used in conjunction
// with the LampComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for dvTP
//                   LampComponent: Keypad
//                   on SETUP CHANNEL
//
// PURPOSE:          This button event is used to listen for input from the keypad
//                   on the touch panel and update the MediaDeviceComponent Text Fields.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
data_event[dvTP.number:1:0]
{
    string:
    {
	if (nAdjustType)
	{
		println("'Data from TP: ',data.text")
		if (find_string(data.text, 'ABORT', 1))
		{
			nAdjustType = 0
		}
		else
		{
			switch (nAdjustType)
			{
				case BTN_SET_COOLDOWN_TIME :
				{
					remove_string(data.text, 'KEYP-', 1)
					send_command vdvDev[nCurrentZone], "'COOLDOWN-',data.text"
					println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'COOLDOWN-',data.text,39")
					nAdjustType = 0
				}
				case BTN_SET_LAMP_TIME :
				{
					remove_string(data.text, 'KEYP-', 1)
					send_command vdvDev[nCurrentZone], "'LAMPTIME-',data.text"
					println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'LAMPTIME-',data.text,39")
					nAdjustType = 0
				}
				case BTN_SET_WARMUP_TIME :
				{
					remove_string(data.text, 'KEYP-', 1)
					send_command vdvDev[nCurrentZone], "'WARMUP-',data.text"
					println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'WARMUP-',data.text,39")
					nAdjustType = 0
				}
			}
		}
	}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - command
//                   on BTN_COUNTER_NOTIFY
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the LampComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_COUNTER_NOTIFY]
{
    push:
    {
	bBTN_COUNTER_NOTIFY = !bBTN_COUNTER_NOTIFY
	send_command vdvDev[nCurrentZone], "'COUNTERNOTIFY-',itoa(bBTN_COUNTER_NOTIFY)"
	println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'COUNTERNOTIFY-',itoa(bBTN_COUNTER_NOTIFY),39")
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   LampComponent: channel button - command
//                   BTN_SET_COOLDOWN_TIME,
//                   BTN_SET_WARMUP_TIME,
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_SET_COOLDOWN_TIME]
button_event[dvTP, BTN_SET_WARMUP_TIME]
{
    push:
    {
	nAdjustType = button.input.channel
	
	switch (nAdjustType)
	{
		case BTN_SET_COOLDOWN_TIME :
		{
			send_command dvTP, "'@AKP-;Enter Cooldown Time'"
		}
		case BTN_SET_WARMUP_TIME :
		{
			send_command dvTP, "'@AKP-;Enter Warmup Time'"
		}
	}
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       CHANNEL_EVENT for Data Initialized
//                   SourceSelectComponent: on DATA_INITIALIZED
//
// PURPOSE:          This channel event is used to listen for the comm module's 
//                   data initialized event.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
channel_event[vdvDev[1], DATA_INITIALIZED]
{
    ON:
    {
	stack_var integer nLoop
		
		// reset all property values
		
		// query for new properties
	bBTN_COUNTER_NOTIFY = FALSE
	OFF[dvTP,BTN_COUNTER_NOTIFY]
	if(m_isInitialized==FALSE)
	{
	    send_command vdvDev[nCurrentZone], '?WARMUP'
	    println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?WARMUP',39")
	    send_command vdvDev[nCurrentZone], '?COOLDOWN'
	    println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?COOLDOWN',39")
	    send_command vdvDev[nCurrentZone], '?LAMPTIME'
	    println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?LAMPTIME',39")
	}
	m_isInitialized=TRUE
    }
    OFF:
    {
	m_isInitialized=FALSE
    }
}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,PWR_ON] = [vdvDev[nCurrentZone],LAMP_POWER_FB]
[dvTP,PWR_OFF] = ![vdvDev[nCurrentZone],LAMP_POWER_FB]
[dvTP,BTN_LAMP_WARMING_FB] = [vdvDev[nCurrentZone],LAMP_WARMING_FB]
[dvTP,BTN_LAMP_POWER_FB] = [vdvDev[nCurrentZone],LAMP_POWER_FB]
[dvTP,BTN_LAMP_COOLING_FB] = [vdvDev[nCurrentZone],LAMP_COOLING_FB]

[dvTP, BTN_COUNTER_NOTIFY] = bBTN_COUNTER_NOTIFY

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

