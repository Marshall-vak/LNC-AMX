PROGRAM_NAME='DVX Main Program'

#include 'amx-dvx-control'
#include 'amx-modero-control'
#include 'amx-dxlink-control'
#include 'debug'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

// Master Controller
dvCONSOLE = 0:1:0

//gpio connections
dvIO = 5001:17:0	// GPIO

//relays
dvRELAY = 5001:8:0      //Relays

// RS-232 Connections
dvCOM1 = 5001:1:0	// RS-232 port 1 
dvCOM2 = 5001:2:0	// RS-232 port 2
dvCOM3 = 5001:3:0	// RS-232 port 3 
dvCOM4 = 5001:4:0	// RS-232 port 4
dvCOM3 = 5001:5:0	// RS-232 port 5 
dvCOM4 = 5001:6:0	// RS-232 port 6

//internal switcher connection
dvDVXSW = 5002:1:0	// Switcher
dvSWV = 5002:1:8	// Switcher Video
dvSWA = 5002:1:10	// Switcher Audio

//Video outputs
dvHdmi1 = 5002:1:0
dvHdmi2 = 5002:2:0
dvHdmi3 = 5002:3:0
dvHdmi4 = 5002:4:0

//DxLink DVX in/out ports
dvDvxDxLinkIn1 = 5002:1:0
dvDvxDxLinkIn2 = 5002:2:0
dvDvxDxLinkOut1 = 5002:3:0
dvDvxDxLinkOut2 = 5002:4:0


//html5 webpannel
vdvSwitcher = 41001:1:0;

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
DEV dvTPMaster[] = { }
DEV dvHdmiMaster[] = { dvHdmi1, dvHdmi2, dvHdmi3, dvHdmi4 }
DEV dvDvxDxlinkInMaster[] = { dvDvxDxLinkIn1, dvDvxDxLinkIn2 }
DEV dvDvxDxLinkOutMaster[] = { dvDvxDxLinkOut1, dvDvxDxLinkOut2 }

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*              Function DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_FUNCTION INTEGER fnGetIndex(INTEGER nArray[], INTEGER nValue){

   INTEGER x
   
    FOR (x=1; x<=LENGTH_ARRAY(nArray); x++) {
	IF (nArray[x] = nValue) RETURN x
    }

   RETURN 0

}

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//yay
print("'Starting LNC AMX DVX!'", false);

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_MODULE 

'DvxSwitcherDashboard_dr1_0_0' DvxSwitcherDashboard_dr1_0_0(vdvSwitcher, dvDVXSW);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

// Touch Pannel Startup Program
DATA_EVENT[dvTPMaster]
{
    ONLINE:
    {
	//setup touch pannel
	moderoDisableAllPopups(Data.Device)
	
	//set pannel passwords
	moderoSetPageFlipPassword(Data.Device, itoa(0), itoa(1988))
	moderoSetPageFlipPassword(Data.Device, itoa(1), itoa(1988))
	moderoSetPageFlipPassword(Data.Device, itoa(2), itoa(1950))
	
	
	//enable touch pannel
	moderoSetPage('Welcome')
	moderoBeepDouble(Data.Device)
	moderoEnablePopup(Data.Device, 'Online')
	
	SEND_STRING dvCONSOLE, "'a TP came Online:', devToString(Data.Device)"
    }
}

//html5 webpannel
data_event[vdvSwitcher]
{
    online: 
    {
	send_command data.device,'DEBUG-1';
	
	(***********************************************************)
	(*                UI customization options                 *)
	(***********************************************************)
	// Override reported DVX matrix size
	// send_command data.device,'PROPERTY-INPUT.COUNT,4';
	// send_command data.device,'PROPERTY-OUTPUT.COUNT,2';
	// Remove reported DVX Components
	// send_command data.device,'PROPERTY-Has-microphones,false';
    }
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


**************************)


