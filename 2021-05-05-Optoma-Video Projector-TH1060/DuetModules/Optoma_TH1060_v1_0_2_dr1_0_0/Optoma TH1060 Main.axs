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
PROGRAM_NAME = 'Optoma TH1060 Main' 
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 7/29/2008 3:24:54 PM                    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

vdvOptomaTH1060 = 41001:1:0  // The COMM module should use this as its duet device
// Serial RS-232 Control
dvOptomaTH1060 = 5001:1:0 // This device should be used as the physical device by the COMM module
dvOptomaTH1060Tp = 10001:1:0 // This port should match the assigned touch panel device port

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvDev[] = {vdvOptomaTH1060}

// ----------------------------------------------------------
// CURRENT DEVICE NUMBER ON TP NAVIGATION BAR
INTEGER nOptomaTH1060 = 1

// ----------------------------------------------------------
// DEFINE THE PAGES THAT YOUR COMPONENTS ARE USING IN THE 
// SUB NAVIGATION BAR HERE
INTEGER nLampPages[] = { 7 }
INTEGER nDisplayPages[] = { 1,2,3 }
INTEGER nMenuPages[] = { 4,6 }
INTEGER nSourceSelectPages[] = { 8 }
INTEGER nVolumePages[] = { 9 }
INTEGER nModulePages[] = { 12 }

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


// ----------------------------------------------------------
// DEVICE MODULE GROUPS SHOULD ALL HAVE THE SAME DEVICE NUMBER
DEFINE_MODULE 'Optoma TH1060 DisplayComponent' display(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nDisplayPages)
DEFINE_MODULE 'Optoma TH1060 LampComponent' lamp(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nLampPages)
DEFINE_MODULE 'Optoma TH1060 ModuleComponent' module(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nModulePages)
DEFINE_MODULE 'Optoma TH1060 MenuComponent' module(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nMenuPages)
DEFINE_MODULE 'Optoma TH1060 SourceSelectComponent' sourceselect(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nSourceSelectPages)
DEFINE_MODULE 'Optoma TH1060 VolumeComponent' volume(vdvDev, dvOptomaTH1060Tp, nOptomaTH1060, nVolumePages)

// Define your communications module here like so:
DEFINE_MODULE 'Optoma_TH1060_Comm_dr1_0_0' comm(vdvOptomaTH1060, dvOptomaTH1060)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [vdvOptomaTH1060]
{
   ONLINE:
    {
	#WARN 'Verify that the PROPERTY-Poll_Time and DEVICE_ID has been set to the desired setting - Default 10000.'

	//send_command vdvOptomaTH1060,"'PROPERTY-Poll_Time,10000'"
	//send_command vdvOptomaTH1060,"'PROPERTY-Device_ID,02'"
	//send_command vdvOptomaTH1060,"'REINIT'"
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

